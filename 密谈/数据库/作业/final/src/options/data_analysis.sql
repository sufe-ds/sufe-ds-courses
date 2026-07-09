-- ======================
-- 数据分析类操作
-- ======================

-- 1. 统计2025年11月17日12时的所有直播间热度并降序输出（热度=0.3*播放量+0.5*点赞量+0.2*转发量）
-- 使用参数: :target_datetime (例如: '2025-11-17 12:00:00')
SELECT 
    l.live_id,
    l.title,
    u.username AS streamer_name,
    l.play_count,
    l.like_count,
    l.share_count,
    (0.3 * l.play_count + 0.5 * l.like_count + 0.2 * l.share_count) AS calculated_heat,
    l.status
FROM live l
JOIN user_info u ON l.streamer_id = u.user_id
WHERE l.start_time <= :target_datetime
  AND (l.status = 'live' OR 
       (l.status = 'ended' AND l.start_time >= :target_datetime::timestamp - INTERVAL '24 hours'))
ORDER BY calculated_heat DESC;

-- 2. 统计热门直播（热度排名前 10）的标签分布情况，并查询每个标签下热度最高的前三个直播间
-- 使用参数: 无
WITH hot_lives AS (
    SELECT 
        live_id,
        title,
        popularity_score
    FROM live
    ORDER BY popularity_score DESC
    LIMIT 10
),
tag_distribution AS (
    SELECT 
        t.tag_id,
        t.content AS tag_content,
        COUNT(DISTINCT ltr.live_id) AS live_count
    FROM live_tag_record ltr
    JOIN tag t ON ltr.tag_id = t.tag_id
    WHERE ltr.live_id IN (SELECT live_id FROM hot_lives)
    GROUP BY t.tag_id, t.content
)
SELECT 
    td.tag_content,
    td.live_count AS total_hot_lives_with_tag,
    (
        SELECT json_agg(
            json_build_object(
                'live_id', l.live_id,
                'title', l.title,
                'streamer', u.username,
                'popularity_score', l.popularity_score
            )
            ORDER BY l.popularity_score DESC
        )
        FROM (
            SELECT DISTINCT l2.live_id, l2.title, l2.popularity_score, l2.streamer_id
            FROM live l2
            JOIN live_tag_record ltr2 ON l2.live_id = ltr2.live_id
            WHERE ltr2.tag_id = td.tag_id
            ORDER BY l2.popularity_score DESC
            LIMIT 3
        ) l
        JOIN user_info u ON l.streamer_id = u.user_id
    ) AS top_3_lives
FROM tag_distribution td
ORDER BY td.live_count DESC;

-- 简化版本（不使用JSON聚合）
WITH hot_lives AS (
    SELECT 
        live_id,
        title,
        popularity_score
    FROM live
    ORDER BY popularity_score DESC
    LIMIT 10
),
tag_distribution AS (
    SELECT 
        t.tag_id,
        t.content AS tag_content,
        COUNT(DISTINCT ltr.live_id) AS live_count
    FROM live_tag_record ltr
    JOIN tag t ON ltr.tag_id = t.tag_id
    WHERE ltr.live_id IN (SELECT live_id FROM hot_lives)
    GROUP BY t.tag_id, t.content
),
ranked_lives_by_tag AS (
    SELECT 
        ltr.tag_id,
        l.live_id,
        l.title,
        u.username AS streamer_name,
        l.popularity_score,
        ROW_NUMBER() OVER (PARTITION BY ltr.tag_id ORDER BY l.popularity_score DESC) AS rank
    FROM live_tag_record ltr
    JOIN live l ON ltr.live_id = l.live_id
    JOIN user_info u ON l.streamer_id = u.user_id
    WHERE ltr.tag_id IN (SELECT tag_id FROM tag_distribution)
)
SELECT 
    t.content AS tag_content,
    td.live_count AS total_hot_lives_with_tag,
    rl.live_id,
    rl.title,
    rl.streamer_name,
    rl.popularity_score,
    rl.rank
FROM tag_distribution td
JOIN tag t ON td.tag_id = t.tag_id
LEFT JOIN ranked_lives_by_tag rl ON td.tag_id = rl.tag_id AND rl.rank <= 3
ORDER BY td.live_count DESC, rl.rank;

-- 3. 计算B论坛2025年11月内的综合活跃度（活跃度=0.3*发帖数+0.5*评论数+0.2*阅读量）
-- 使用参数: :forum_name (例如: 'B论坛'), :year (例如: 2025), :month (例如: 11)
WITH forum_stats AS (
    SELECT 
        f.forum_id,
        f.name,
        COUNT(DISTINCT p.post_id) AS post_count,
        COUNT(DISTINCT c.comment_id) AS comment_count,
        COALESCE(SUM(p.view_count), 0) AS total_views
    FROM forum f
    LEFT JOIN post p ON f.forum_id = p.forum_id 
        AND EXTRACT(YEAR FROM p.create_time) = :year
        AND EXTRACT(MONTH FROM p.create_time) = :month
    LEFT JOIN comment c ON p.post_id = c.post_id
        AND EXTRACT(YEAR FROM c.send_time) = :year
        AND EXTRACT(MONTH FROM c.send_time) = :month
    WHERE f.name = :forum_name
    GROUP BY f.forum_id, f.name
)
SELECT 
    forum_id,
    name AS forum_name,
    post_count,
    comment_count,
    total_views,
    (0.3 * post_count + 0.5 * comment_count + 0.2 * total_views) AS activity_score
FROM forum_stats;

-- 4. 统计用户 A 在 2025 年 11 月内点赞、评论和转发行为的时间分布，分类型升序输出行为发生频率最高的三天
-- 使用参数: :username (例如: 'user_a'), :year (例如: 2025), :month (例如: 11)
WITH user_actions AS (
    -- 评论行为
    SELECT 
        DATE(send_time) AS action_date,
        '评论' AS action_type,
        COUNT(*) AS action_count
    FROM comment
    WHERE user_id = (SELECT user_id FROM user_info WHERE username = :username)
      AND EXTRACT(YEAR FROM send_time) = :year
      AND EXTRACT(MONTH FROM send_time) = :month
    GROUP BY DATE(send_time)
    
    UNION ALL
    
    -- 点赞行为（从直播记录中统计）
    SELECT 
        DATE(l.start_time) AS action_date,
        '点赞' AS action_type,
        COUNT(*) AS action_count
    FROM live_record lr
    JOIN live l ON lr.live_id = l.live_id
    WHERE lr.user_id = (SELECT user_id FROM user_info WHERE username = :username)
      AND lr.like_status = TRUE
      AND EXTRACT(YEAR FROM l.start_time) = :year
      AND EXTRACT(MONTH FROM l.start_time) = :month
    GROUP BY DATE(l.start_time)
    
    UNION ALL
    
    -- 转发行为（从直播记录中统计）
    SELECT 
        DATE(lr.watch_duration::text::timestamp) AS action_date,
        '转发' AS action_type,
        COUNT(*) AS action_count
    FROM live_record lr
    JOIN live l ON lr.live_id = l.live_id
    WHERE lr.user_id = (SELECT user_id FROM user_info WHERE username = :username)
      AND lr.share_status = TRUE
      AND EXTRACT(YEAR FROM l.start_time) = :year
      AND EXTRACT(MONTH FROM l.start_time) = :month
    GROUP BY DATE(lr.watch_duration::text::timestamp)
),
ranked_actions AS (
    SELECT 
        action_type,
        action_date,
        action_count,
        ROW_NUMBER() OVER (PARTITION BY action_type ORDER BY action_count DESC) AS rank
    FROM user_actions
)
SELECT 
    action_type,
    action_date,
    action_count
FROM ranked_actions
WHERE rank <= 3
ORDER BY action_type ASC, action_count DESC;
