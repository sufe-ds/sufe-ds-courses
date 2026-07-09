-- ======================
-- 视图创建
-- ======================
-- 1. 用户活跃度概览视图
CREATE
OR REPLACE VIEW v_user_activity_summary AS
SELECT
    u.user_id,
    u.username,
    u.register_time,
    (
        SELECT
            COUNT(*)
        FROM
            post p
        WHERE
            p.user_id = u.user_id
    ) AS total_posts,
    (
        SELECT
            COUNT(*)
        FROM
            comment c
        WHERE
            c.user_id = u.user_id
    ) AS total_comments,
    (
        SELECT
            COUNT(*)
        FROM
            live l
        WHERE
            l.streamer_id = u.user_id
    ) AS total_lives,
    u.activity_score
FROM
    user_info u;

SELECT
    *
FROM
    v_user_activity_summary
LIMIT
    5;

-- 2. 论坛综合统计视图
CREATE
OR REPLACE VIEW v_forum_statistics AS
SELECT
    f.forum_id,
    f.name AS forum_name,
    u.username AS admin_name,
    f.post_count,
    f.comment_count,
    f.view_count,
    f.activity_score
FROM
    forum f
    JOIN user_info u ON f.admin_id = u.user_id;

SELECT
    *
FROM
    v_forum_statistics
LIMIT
    5;

-- 3. 热门帖子详情视图
CREATE
OR REPLACE VIEW v_hot_posts_detail AS
SELECT
    p.post_id,
    p.title,
    u.username AS author_name,
    f.name AS forum_name,
    p.like_count,
    p.share_count,
    p.view_count,
    p.interaction_score,
    p.traffic_pool
FROM
    post p
    JOIN user_info u ON p.user_id = u.user_id
    JOIN forum f ON p.forum_id = f.forum_id;

SELECT
    *
FROM
    v_hot_posts_detail
LIMIT
    5;

-- 4. 直播热度排行视图
CREATE
OR REPLACE VIEW v_live_popularity_ranking AS
SELECT
    l.live_id,
    l.title,
    u.username AS streamer_name,
    l.start_time,
    l.play_count,
    l.like_count,
    l.popularity_score,
    l.status
FROM
    live l
    JOIN user_info u ON l.streamer_id = u.user_id;

SELECT
    *
FROM
    v_live_popularity_ranking
LIMIT
    5;

-- 5. 标签使用频率视图
CREATE
OR REPLACE VIEW v_tag_usage_stats AS
SELECT
    t.tag_id,
    t.content AS tag_content,
    (
        SELECT
            COUNT(*)
        FROM
            post_tag_record ptr
        WHERE
            ptr.tag_id = t.tag_id
    ) AS post_usage,
    (
        SELECT
            COUNT(*)
        FROM
            user_tag_record utr
        WHERE
            utr.tag_id = t.tag_id
    ) AS user_usage,
    (
        SELECT
            COUNT(*)
        FROM
            live_tag_record ltr
        WHERE
            ltr.tag_id = t.tag_id
    ) AS live_usage,
    (
        (
            SELECT
                COUNT(*)
            FROM
                post_tag_record ptr
            WHERE
                ptr.tag_id = t.tag_id
        ) + (
            SELECT
                COUNT(*)
            FROM
                user_tag_record utr
            WHERE
                utr.tag_id = t.tag_id
        ) + (
            SELECT
                COUNT(*)
            FROM
                live_tag_record ltr
            WHERE
                ltr.tag_id = t.tag_id
        )
    ) AS total_usage
FROM
    tag t;

SELECT
    *
FROM
    v_tag_usage_stats
LIMIT
    5;

-- 6. 多媒体素材分类视图
CREATE
OR REPLACE VIEW v_multimedia_assets AS
SELECT
    m.material_id,
    m.file_path,
    m.material_type,
    m.upload_time,
    CASE
        WHEN m.material_type = 'video' THEN 'Duration: ' || v.duration || 's, Res: ' || v.resolution
        WHEN m.material_type = 'image' THEN 'Size: ' || i.width || 'x' || i.height
        WHEN m.material_type = 'ad' THEN 'Ad Material'
        WHEN m.material_type = 'emoji' THEN 'Emoji Material'
        ELSE 'N/A'
    END AS specific_attributes
FROM
    multimedia_material m
    LEFT JOIN video v ON m.material_id = v.material_id
    LEFT JOIN image i ON m.material_id = i.material_id;

SELECT
    *
FROM
    v_multimedia_assets
LIMIT
    5;