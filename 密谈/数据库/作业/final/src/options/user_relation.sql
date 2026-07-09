-- ======================
-- 用户关系类操作
-- ======================

-- 1. 查询用户A的基本账号信息，包括注册时间、最后登录时间、个人简介、位置、活跃度
-- 使用参数: :username (例如: '张三')
SELECT 
    user_id,
    username,
    register_time,
    last_login_time,
    bio,
    location,
    activity_score
FROM user_info
WHERE username = :username;

-- 2. 查询用户 A 在 2025 年 11 月 17 日发布的所有内容，包括帖子、评论及直播，分别输出内容类型、标题（或正文摘要）和发布时间
-- 使用参数: :username (例如: '张三'), :target_date (例如: '2025-11-17')
SELECT 
    '帖子' AS content_type,
    title AS title_or_content,
    create_time AS publish_time
FROM post
WHERE user_id = (SELECT user_id FROM user_info WHERE username = :username)
  AND DATE(create_time) = :target_date

UNION ALL

SELECT 
    '评论' AS content_type,
    LEFT(content, 50) || '...' AS title_or_content,
    send_time AS publish_time
FROM comment
WHERE user_id = (SELECT user_id FROM user_info WHERE username = :username)
  AND DATE(send_time) = :target_date

UNION ALL

SELECT 
    '直播' AS content_type,
    title AS title_or_content,
    start_time AS publish_time
FROM live
WHERE streamer_id = (SELECT user_id FROM user_info WHERE username = :username)
  AND DATE(start_time) = :target_date

ORDER BY publish_time;

-- 3. 统计2025年11月17日用户A对帖子、评论和直播的点赞、转发、收藏行为总次数
-- 使用参数: :username (例如: '张三'), :target_date (例如: '2025-11-17')
SELECT 
    COUNT(*) FILTER (WHERE like_status = TRUE) AS total_likes,
    COUNT(*) FILTER (WHERE share_status = TRUE) AS total_shares,
    COUNT(*) FILTER (WHERE like_status = TRUE OR share_status = TRUE) AS total_interactions
FROM live_record
WHERE user_id = (SELECT user_id FROM user_info WHERE username = :username)
  AND live_id IN (
      SELECT live_id 
      FROM live 
      WHERE DATE(start_time) = :target_date
  );

-- 4. 查询2025年11月17日用户A的所有私信交流对象，并统计交流时长，按交流时长降序输出
-- 注意: 使用消息数量作为交流时长的代理指标
-- 使用参数: :username (例如: '张三'), :target_date (例如: '2025-11-17')
WITH user_messages AS (
    SELECT 
        CASE 
            WHEN sender_id = (SELECT user_id FROM user_info WHERE username = :username)
            THEN receiver_id
            ELSE sender_id
        END AS contact_user_id,
        COUNT(*) AS message_count
    FROM message
    WHERE (sender_id = (SELECT user_id FROM user_info WHERE username = :username)
           OR receiver_id = (SELECT user_id FROM user_info WHERE username = :username))
      AND DATE(send_time) = :target_date
      AND message_type = 'private'
    GROUP BY contact_user_id
)
SELECT 
    u.username AS contact_username,
    um.message_count AS interaction_count
FROM user_messages um
JOIN user_info u ON um.contact_user_id = u.user_id
ORDER BY um.message_count DESC;

-- 5. 查找与用户A有频繁互动（互发消息>10条）的用户列表
-- 使用参数: :username (例如: '张三')
WITH message_pairs AS (
    SELECT 
        LEAST(sender_id, receiver_id) AS user1_id,
        GREATEST(sender_id, receiver_id) AS user2_id,
        COUNT(*) AS message_count
    FROM message
    WHERE (sender_id = (SELECT user_id FROM user_info WHERE username = :username)
           OR receiver_id = (SELECT user_id FROM user_info WHERE username = :username))
      AND message_type = 'private'
    GROUP BY user1_id, user2_id
    HAVING COUNT(*) > 10
)
SELECT 
    u.username AS frequent_contact,
    mp.message_count
FROM message_pairs mp
JOIN user_info u ON (
    CASE 
        WHEN mp.user1_id = (SELECT user_id FROM user_info WHERE username = :username)
        THEN mp.user2_id
        ELSE mp.user1_id
    END = u.user_id
)
ORDER BY mp.message_count DESC;

-- 6. 统计用户 A 在 2025 年 11 月内的活跃时间分布，输出互动行为发生频率最高的前三个日期
-- 使用参数: :username (例如: '张三'), :year (例如: 2025), :month (例如: 11)
WITH user_activity AS (
    SELECT 
        DATE(create_time) AS activity_date,
        COUNT(*) AS activity_count
    FROM post
    WHERE user_id = (SELECT user_id FROM user_info WHERE username = :username)
      AND EXTRACT(YEAR FROM create_time) = :year
      AND EXTRACT(MONTH FROM create_time) = :month
    GROUP BY DATE(create_time)
    
    UNION ALL
    
    SELECT 
        DATE(send_time) AS activity_date,
        COUNT(*) AS activity_count
    FROM comment
    WHERE user_id = (SELECT user_id FROM user_info WHERE username = :username)
      AND EXTRACT(YEAR FROM send_time) = :year
      AND EXTRACT(MONTH FROM send_time) = :month
    GROUP BY DATE(send_time)
    
    UNION ALL
    
    SELECT 
        DATE(send_time) AS activity_date,
        COUNT(*) AS activity_count
    FROM message
    WHERE sender_id = (SELECT user_id FROM user_info WHERE username = :username)
      AND EXTRACT(YEAR FROM send_time) = :year
      AND EXTRACT(MONTH FROM send_time) = :month
    GROUP BY DATE(send_time)
)
SELECT 
    activity_date,
    SUM(activity_count) AS total_activities
FROM user_activity
GROUP BY activity_date
ORDER BY total_activities DESC
LIMIT 3;
