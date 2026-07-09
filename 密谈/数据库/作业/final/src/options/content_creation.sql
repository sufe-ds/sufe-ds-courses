-- ======================
-- 内容创建类操作
-- ======================

-- 1. 查询2025年11月17日发布的"美食"标签关联的帖子标题
-- 使用参数: :tag_content (例如: '美食'), :target_date (例如: '2025-11-17')
SELECT 
    p.title,
    p.create_time,
    u.username AS author
FROM post p
JOIN user_info u ON p.user_id = u.user_id
WHERE p.post_id IN (
    SELECT ptr.post_id
    FROM post_tag_record ptr
    JOIN tag t ON ptr.tag_id = t.tag_id
    WHERE t.content = :tag_content
)
AND DATE(p.create_time) = :target_date
ORDER BY p.create_time DESC;

-- 2. 查询用户A创建的论坛下于2025年11月发布的帖子标题，发布日期和作者
-- 使用参数: :admin_username (例如: 'user_a'), :year (例如: 2025), :month (例如: 11)
SELECT 
    p.title,
    p.create_time,
    u.username AS author
FROM post p
JOIN user_info u ON p.user_id = u.user_id
JOIN forum f ON p.forum_id = f.forum_id
WHERE f.admin_id = (SELECT user_id FROM user_info WHERE username = :admin_username)
  AND EXTRACT(YEAR FROM p.create_time) = :year
  AND EXTRACT(MONTH FROM p.create_time) = :month
ORDER BY p.create_time DESC;

-- 3. 创建一个新论坛，设置名称、简介，并指定管理员
-- 使用参数: :forum_name (例如: '技术交流'), :description (例如: '分享技术经验'), :admin_username (例如: 'user_a')
INSERT INTO forum (name, description, admin_id)
VALUES (
    :forum_name,
    :description,
    (SELECT user_id FROM user_info WHERE username = :admin_username)
)
RETURNING forum_id, name, description;

-- 4. 查询脆升升广告在2025年11月17日出现在评论区的次数
-- 使用参数: :ad_content (例如: '脆升升'), :target_date (例如: '2025-11-17')
SELECT COUNT(*) AS appearance_count
FROM multimedia_usage_record mur
JOIN multimedia_material mm ON mur.material_id = mm.material_id
WHERE mm.material_type = 'ad'
  AND mm.content LIKE '%' || :ad_content || '%'
  AND mur.host_type = 'comment'
  AND DATE(mur.usage_time) = :target_date;

-- 5. 创建一个新帖子，指定论坛、标签、可见范围
-- 使用参数: 
--   :user_id (例如: 1)
--   :forum_id (例如: 1)
--   :title (例如: '今天的美食分享')
--   :content (例如: '发现了一家很棒的餐厅...')
--   :visibility (例如: 'public')
--   :tag_contents (例如: ARRAY['美食', '生活'])
WITH new_post AS (
    INSERT INTO post (user_id, forum_id, title, content, visibility)
    VALUES (:user_id, :forum_id, :title, :content, :visibility)
    RETURNING post_id
)
INSERT INTO post_tag_record (post_id, tag_id)
SELECT 
    np.post_id,
    t.tag_id
FROM new_post np
CROSS JOIN unnest(:tag_contents::text[]) AS tag_name
LEFT JOIN tag t ON t.content = tag_name
WHERE t.tag_id IS NOT NULL;

-- 如果标签不存在，需要先创建标签
-- 使用参数: :tag_content (例如: '美食')
INSERT INTO tag (content)
VALUES (:tag_content)
ON CONFLICT (content) DO NOTHING
RETURNING tag_id, content;

-- 6. 发起一场直播，设置标题、简介，并上传封面图片
-- 使用参数:
--   :streamer_id (例如: 1)
--   :title (例如: '美食烹饪教程')
--   :description (例如: '教大家做一道简单的家常菜')
--   :cover_image_path (例如: '/images/live_cover_123.jpg')
--   :cover_width (例如: 1920)
--   :cover_height (例如: 1080)

-- 首先上传封面图片素材
WITH new_material AS (
    INSERT INTO multimedia_material (file_path, file_size, material_type, content)
    VALUES (:cover_image_path, 102400, 'image', '直播封面')
    RETURNING material_id
),
new_image AS (
    INSERT INTO image (material_id, width, height, depth)
    SELECT material_id, :cover_width, :cover_height, 24
    FROM new_material
    RETURNING material_id
),
new_live AS (
    INSERT INTO live (streamer_id, title, description)
    VALUES (:streamer_id, :title, :description)
    RETURNING live_id
)
-- 关联封面图片到直播
INSERT INTO multimedia_usage_record (material_id, user_id, usage_scenario, host_type, host_id)
SELECT 
    ni.material_id,
    :streamer_id,
    'live_cover',
    'live',
    nl.live_id
FROM new_image ni, new_live nl
RETURNING usage_id;

-- 7. 统计用户 A 在 2025 年 11 月内上传的多媒体素材数量，并按素材类型（图片、视频、表情包）分类输出
-- 使用参数: :username (例如: 'user_a'), :year (例如: 2025), :month (例如: 11)
SELECT 
    mm.material_type,
    COUNT(*) AS upload_count
FROM multimedia_usage_record mur
JOIN multimedia_material mm ON mur.material_id = mm.material_id
WHERE mur.user_id = (SELECT user_id FROM user_info WHERE username = :username)
  AND EXTRACT(YEAR FROM mur.usage_time) = :year
  AND EXTRACT(MONTH FROM mur.usage_time) = :month
  AND mm.material_type IN ('image', 'video', 'emoji')
GROUP BY mm.material_type
ORDER BY upload_count DESC;

-- 8. 统计用户 A 在 2025 年 11 月 17 日最常使用的前五个表情包，按使用次数降序输出
-- 使用参数: :username (例如: 'user_a'), :target_date (例如: '2025-11-17')
SELECT 
    mm.material_id,
    mm.content AS emoji_content,
    mm.file_path,
    COUNT(*) AS usage_count
FROM multimedia_usage_record mur
JOIN multimedia_material mm ON mur.material_id = mm.material_id
WHERE mur.user_id = (SELECT user_id FROM user_info WHERE username = :username)
  AND mm.material_type = 'emoji'
  AND DATE(mur.usage_time) = :target_date
GROUP BY mm.material_id, mm.content, mm.file_path
ORDER BY usage_count DESC
LIMIT 5;
