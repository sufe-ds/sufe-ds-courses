-- ======================
-- 清理已存在的表
-- ======================
-- 清理已存在的表（按依赖顺序删除）
DROP TABLE IF EXISTS live_tag_record CASCADE;

DROP TABLE IF EXISTS multimedia_usage_record CASCADE;

DROP TABLE IF EXISTS user_tag_record CASCADE;

DROP TABLE IF EXISTS post_tag_record CASCADE;

DROP TABLE IF EXISTS user_forum_record CASCADE;

DROP TABLE IF EXISTS live_record CASCADE;

DROP TABLE IF EXISTS emoji CASCADE;

DROP TABLE IF EXISTS image CASCADE;

DROP TABLE IF EXISTS ad CASCADE;

DROP TABLE IF EXISTS video CASCADE;

DROP TABLE IF EXISTS multimedia_material CASCADE;

DROP TABLE IF EXISTS message CASCADE;

DROP TABLE IF EXISTS live CASCADE;

DROP TABLE IF EXISTS tag CASCADE;

DROP TABLE IF EXISTS comment CASCADE;

DROP TABLE IF EXISTS post CASCADE;

DROP TABLE IF EXISTS forum CASCADE;

DROP TABLE IF EXISTS user_info CASCADE;

-- ======================
-- 主实体表
-- ======================
-- 1. 用户信息表
CREATE TABLE
    user_info (
        user_id SERIAL PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        register_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        last_login_time TIMESTAMP,
        bio TEXT,
        location VARCHAR(100),
        activity_score INTEGER DEFAULT 0,
        CONSTRAINT chk_activity_score CHECK (activity_score >= 0)
    );

COMMENT ON TABLE user_info IS '用户信息表';

COMMENT ON COLUMN user_info.user_id IS '用户ID';

COMMENT ON COLUMN user_info.username IS '用户名';

COMMENT ON COLUMN user_info.password IS '密码';

COMMENT ON COLUMN user_info.register_time IS '注册时间';

COMMENT ON COLUMN user_info.last_login_time IS '最后登录时间';

COMMENT ON COLUMN user_info.bio IS '个人简介';

COMMENT ON COLUMN user_info.location IS '位置';

COMMENT ON COLUMN user_info.activity_score IS '活跃度';

-- 2. 论坛表
CREATE TABLE
    forum (
        forum_id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description TEXT,
        admin_id INTEGER NOT NULL,
        post_count INTEGER DEFAULT 0,
        comment_count INTEGER DEFAULT 0,
        view_count BIGINT DEFAULT 0,
        activity_score INTEGER DEFAULT 0,
        CONSTRAINT fk_forum_admin FOREIGN KEY (admin_id) REFERENCES user_info (user_id) ON DELETE RESTRICT,
        CONSTRAINT chk_post_count CHECK (post_count >= 0),
        CONSTRAINT chk_comment_count CHECK (comment_count >= 0),
        CONSTRAINT chk_view_count CHECK (view_count >= 0),
        CONSTRAINT chk_forum_activity CHECK (activity_score >= 0)
    );

COMMENT ON TABLE forum IS '论坛表';

COMMENT ON COLUMN forum.forum_id IS '论坛ID';

COMMENT ON COLUMN forum.name IS '名称';

COMMENT ON COLUMN forum.description IS '简介';

COMMENT ON COLUMN forum.admin_id IS '管理员ID';

COMMENT ON COLUMN forum.post_count IS '发帖数';

COMMENT ON COLUMN forum.comment_count IS '评论数';

COMMENT ON COLUMN forum.view_count IS '阅读量';

COMMENT ON COLUMN forum.activity_score IS '活跃度';

-- 3. 帖子表
CREATE TABLE
    post (
        post_id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        forum_id INTEGER NOT NULL,
        title VARCHAR(200) NOT NULL,
        content TEXT NOT NULL,
        create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        update_time TIMESTAMP,
        visibility VARCHAR(20) DEFAULT 'public',
        location VARCHAR(100),
        like_count INTEGER DEFAULT 0,
        share_count INTEGER DEFAULT 0,
        view_count BIGINT DEFAULT 0,
        interaction_score NUMERIC(10, 2) DEFAULT 0,
        traffic_pool VARCHAR(50),
        CONSTRAINT fk_post_user FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_post_forum FOREIGN KEY (forum_id) REFERENCES forum (forum_id) ON DELETE CASCADE,
        CONSTRAINT chk_visibility CHECK (visibility IN ('public', 'private', 'friends')),
        CONSTRAINT chk_like_count CHECK (like_count >= 0),
        CONSTRAINT chk_share_count CHECK (share_count >= 0),
        CONSTRAINT chk_post_view_count CHECK (view_count >= 0)
    );

COMMENT ON TABLE post IS '帖子表';

COMMENT ON COLUMN post.post_id IS '帖子ID';

COMMENT ON COLUMN post.user_id IS '用户ID';

COMMENT ON COLUMN post.forum_id IS '论坛ID';

COMMENT ON COLUMN post.title IS '标题';

COMMENT ON COLUMN post.content IS '正文';

COMMENT ON COLUMN post.create_time IS '创建时间';

COMMENT ON COLUMN post.update_time IS '更新时间';

COMMENT ON COLUMN post.visibility IS '可见范围';

COMMENT ON COLUMN post.location IS '位置';

COMMENT ON COLUMN post.like_count IS '点赞数';

COMMENT ON COLUMN post.share_count IS '转发数';

COMMENT ON COLUMN post.view_count IS '阅读量';

COMMENT ON COLUMN post.interaction_score IS '社区互动分数';

COMMENT ON COLUMN post.traffic_pool IS '流量池';

-- 4. 评论表
CREATE TABLE
    comment (
        comment_id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        post_id INTEGER NOT NULL,
        parent_comment_id INTEGER,
        content TEXT NOT NULL,
        send_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        like_count INTEGER DEFAULT 0,
        location VARCHAR(100),
        nest_depth INTEGER DEFAULT 0,
        CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_comment_post FOREIGN KEY (post_id) REFERENCES post (post_id) ON DELETE CASCADE,
        CONSTRAINT fk_comment_parent FOREIGN KEY (parent_comment_id) REFERENCES comment (comment_id) ON DELETE CASCADE,
        CONSTRAINT chk_comment_like_count CHECK (like_count >= 0),
        CONSTRAINT chk_nest_depth CHECK (nest_depth >= 0)
    );

COMMENT ON TABLE comment IS '评论表';

COMMENT ON COLUMN comment.comment_id IS '评论ID';

COMMENT ON COLUMN comment.user_id IS '用户ID';

COMMENT ON COLUMN comment.post_id IS '所属帖子ID';

COMMENT ON COLUMN comment.parent_comment_id IS '父评论ID';

COMMENT ON COLUMN comment.content IS '正文';

COMMENT ON COLUMN comment.send_time IS '发送时间';

COMMENT ON COLUMN comment.like_count IS '点赞数';

COMMENT ON COLUMN comment.location IS '位置';

COMMENT ON COLUMN comment.nest_depth IS '嵌套深度';

-- 5. 标签表
CREATE TABLE
    tag (tag_id SERIAL PRIMARY KEY, content VARCHAR(50) NOT NULL UNIQUE);

COMMENT ON TABLE tag IS '标签表';

COMMENT ON COLUMN tag.tag_id IS '标签ID';

COMMENT ON COLUMN tag.content IS '内容';

-- 6. 直播表
CREATE TABLE
    live (
        live_id SERIAL PRIMARY KEY,
        streamer_id INTEGER NOT NULL,
        title VARCHAR(200) NOT NULL,
        description TEXT,
        start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        play_count BIGINT DEFAULT 0,
        like_count INTEGER DEFAULT 0,
        share_count INTEGER DEFAULT 0,
        status VARCHAR(20) DEFAULT 'live',
        popularity_score INTEGER DEFAULT 0,
        CONSTRAINT fk_live_streamer FOREIGN KEY (streamer_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT chk_live_status CHECK (status IN ('live', 'ended', 'scheduled')),
        CONSTRAINT chk_play_count CHECK (play_count >= 0),
        CONSTRAINT chk_live_like_count CHECK (like_count >= 0),
        CONSTRAINT chk_share_count_live CHECK (share_count >= 0),
        CONSTRAINT chk_popularity_score CHECK (popularity_score >= 0)
    );

COMMENT ON TABLE live IS '直播表';

COMMENT ON COLUMN live.live_id IS '直播ID';

COMMENT ON COLUMN live.streamer_id IS '主播ID';

COMMENT ON COLUMN live.title IS '标题';

COMMENT ON COLUMN live.description IS '简介';

COMMENT ON COLUMN live.start_time IS '开播时间';

COMMENT ON COLUMN live.play_count IS '播放量';

COMMENT ON COLUMN live.like_count IS '点赞数';

COMMENT ON COLUMN live.share_count IS '转发';

COMMENT ON COLUMN live.status IS '状态';

COMMENT ON COLUMN live.popularity_score IS '热度';

-- 7. 消息表
CREATE TABLE
    message (
        message_id SERIAL PRIMARY KEY,
        sender_id INTEGER NOT NULL,
        receiver_id INTEGER NOT NULL,
        content TEXT NOT NULL,
        send_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        format VARCHAR(50) DEFAULT 'text',
        message_type VARCHAR(50) DEFAULT 'private',
        read_status BOOLEAN DEFAULT FALSE,
        CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_message_receiver FOREIGN KEY (receiver_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT chk_message_type CHECK (message_type IN ('private', 'system', 'notification'))
    );

COMMENT ON TABLE message IS '消息表';

COMMENT ON COLUMN message.message_id IS '消息ID';

COMMENT ON COLUMN message.sender_id IS '发送者ID';

COMMENT ON COLUMN message.receiver_id IS '接收者ID';

COMMENT ON COLUMN message.content IS '内容';

COMMENT ON COLUMN message.send_time IS '发送时间';

COMMENT ON COLUMN message.format IS '格式';

COMMENT ON COLUMN message.message_type IS '消息类型';

COMMENT ON COLUMN message.read_status IS '已读状态';

-- 8. 多媒体素材表
CREATE TABLE
    multimedia_material (
        material_id SERIAL PRIMARY KEY,
        file_path VARCHAR(500) NOT NULL,
        file_size BIGINT NOT NULL,
        material_type VARCHAR(50) NOT NULL,
        upload_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        content TEXT,
        CONSTRAINT chk_file_size CHECK (file_size > 0),
        CONSTRAINT chk_material_type CHECK (material_type IN ('video', 'image', 'ad', 'emoji'))
    );

COMMENT ON TABLE multimedia_material IS '多媒体素材表';

COMMENT ON COLUMN multimedia_material.material_id IS '素材ID';

COMMENT ON COLUMN multimedia_material.file_path IS '文件位置';

COMMENT ON COLUMN multimedia_material.file_size IS '文件大小';

COMMENT ON COLUMN multimedia_material.material_type IS '素材类型';

COMMENT ON COLUMN multimedia_material.upload_time IS '上传时间';

COMMENT ON COLUMN multimedia_material.content IS '内容';

-- ======================
-- 继承表（多媒体素材的子类）
-- ======================
-- 9. 视频表
CREATE TABLE
    video (
        video_id SERIAL PRIMARY KEY,
        material_id INTEGER NOT NULL UNIQUE,
        duration INTEGER,
        resolution VARCHAR(20),
        format VARCHAR(20),
        CONSTRAINT fk_video_material FOREIGN KEY (material_id) REFERENCES multimedia_material (material_id) ON DELETE CASCADE,
        CONSTRAINT chk_duration CHECK (duration > 0)
    );

COMMENT ON TABLE video IS '视频表';

COMMENT ON COLUMN video.video_id IS '视频ID';

COMMENT ON COLUMN video.material_id IS '素材ID';

COMMENT ON COLUMN video.duration IS '时长（秒）';

COMMENT ON COLUMN video.resolution IS '清晰度';

COMMENT ON COLUMN video.format IS '格式';

-- 10. 广告表
CREATE TABLE
    ad (
        ad_id SERIAL PRIMARY KEY,
        material_id INTEGER NOT NULL UNIQUE,
        CONSTRAINT fk_ad_material FOREIGN KEY (material_id) REFERENCES multimedia_material (material_id) ON DELETE CASCADE
    );

COMMENT ON TABLE ad IS '广告表';

COMMENT ON COLUMN ad.ad_id IS '广告ID';

COMMENT ON COLUMN ad.material_id IS '素材ID';

-- 11. 图片表
CREATE TABLE
    image (
        image_id SERIAL PRIMARY KEY,
        material_id INTEGER NOT NULL UNIQUE,
        width INTEGER,
        height INTEGER,
        depth INTEGER,
        CONSTRAINT fk_image_material FOREIGN KEY (material_id) REFERENCES multimedia_material (material_id) ON DELETE CASCADE,
        CONSTRAINT chk_width CHECK (width > 0),
        CONSTRAINT chk_height CHECK (height > 0)
    );

COMMENT ON TABLE image IS '图片表';

COMMENT ON COLUMN image.image_id IS '图片ID';

COMMENT ON COLUMN image.material_id IS '素材ID';

COMMENT ON COLUMN image.width IS '宽';

COMMENT ON COLUMN image.height IS '高';

COMMENT ON COLUMN image.depth IS '深度';

-- 12. 表情包表
CREATE TABLE
    emoji (
        emoji_id SERIAL PRIMARY KEY,
        material_id INTEGER NOT NULL UNIQUE,
        CONSTRAINT fk_emoji_material FOREIGN KEY (material_id) REFERENCES multimedia_material (material_id) ON DELETE CASCADE
    );

COMMENT ON TABLE emoji IS '表情包表';

COMMENT ON COLUMN emoji.emoji_id IS '表情包ID';

COMMENT ON COLUMN emoji.material_id IS '素材ID';

-- ======================
-- 关系表
-- ======================
-- 13. 直播记录表
CREATE TABLE
    live_record (
        user_id INTEGER NOT NULL,
        live_id INTEGER NOT NULL,
        relation_type INTEGER NOT NULL,
        like_status BOOLEAN DEFAULT FALSE,
        share_status BOOLEAN DEFAULT FALSE,
        watch_duration INTEGER DEFAULT 0,
        PRIMARY KEY (user_id, live_id),
        CONSTRAINT fk_live_record_user FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_live_record_live FOREIGN KEY (live_id) REFERENCES live (live_id) ON DELETE CASCADE,
        CONSTRAINT chk_relation_type CHECK (relation_type IN (1, 2)),
        CONSTRAINT chk_watch_duration CHECK (watch_duration >= 0)
    );

COMMENT ON TABLE live_record IS '直播记录表';

COMMENT ON COLUMN live_record.user_id IS '用户ID';

COMMENT ON COLUMN live_record.live_id IS '直播ID';

COMMENT ON COLUMN live_record.relation_type IS '关系类型（1=发起/2=观看）';

COMMENT ON COLUMN live_record.like_status IS '点赞';

COMMENT ON COLUMN live_record.share_status IS '转发';

COMMENT ON COLUMN live_record.watch_duration IS '观看时长（秒）';

-- 14. 用户—论坛记录表
CREATE TABLE
    user_forum_record (
        user_id INTEGER NOT NULL,
        forum_id INTEGER NOT NULL,
        relation_type INTEGER NOT NULL,
        join_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (user_id, forum_id),
        CONSTRAINT fk_user_forum_user FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_user_forum_forum FOREIGN KEY (forum_id) REFERENCES forum (forum_id) ON DELETE CASCADE,
        CONSTRAINT chk_user_forum_relation CHECK (relation_type IN (1, 2))
    );

COMMENT ON TABLE user_forum_record IS '用户—论坛记录表';

COMMENT ON COLUMN user_forum_record.user_id IS '用户ID';

COMMENT ON COLUMN user_forum_record.forum_id IS '论坛ID';

COMMENT ON COLUMN user_forum_record.relation_type IS '关系类型（1=管理/2=加入）';

COMMENT ON COLUMN user_forum_record.join_time IS '加入时间';

-- 15. 帖子标签记录表
CREATE TABLE
    post_tag_record (
        post_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        tag_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (post_id, tag_id),
        CONSTRAINT fk_post_tag_post FOREIGN KEY (post_id) REFERENCES post (post_id) ON DELETE CASCADE,
        CONSTRAINT fk_post_tag_tag FOREIGN KEY (tag_id) REFERENCES tag (tag_id) ON DELETE CASCADE
    );

COMMENT ON TABLE post_tag_record IS '帖子标签记录表';

COMMENT ON COLUMN post_tag_record.post_id IS '帖子ID';

COMMENT ON COLUMN post_tag_record.tag_id IS '标签ID';

COMMENT ON COLUMN post_tag_record.tag_time IS '标记时间';

-- 16. 用户标签记录表
CREATE TABLE
    user_tag_record (
        user_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        tag_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (user_id, tag_id),
        CONSTRAINT fk_user_tag_user FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_user_tag_tag FOREIGN KEY (tag_id) REFERENCES tag (tag_id) ON DELETE CASCADE
    );

COMMENT ON TABLE user_tag_record IS '用户标签记录表';

COMMENT ON COLUMN user_tag_record.user_id IS '用户ID';

COMMENT ON COLUMN user_tag_record.tag_id IS '标签ID';

COMMENT ON COLUMN user_tag_record.tag_time IS '标记时间';

-- 17. 多媒体素材使用记录表
CREATE TABLE
    multimedia_usage_record (
        usage_id SERIAL PRIMARY KEY,
        material_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        usage_scenario VARCHAR(100),
        usage_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        host_type VARCHAR(50),
        host_id INTEGER,
        CONSTRAINT fk_usage_material FOREIGN KEY (material_id) REFERENCES multimedia_material (material_id) ON DELETE CASCADE,
        CONSTRAINT fk_usage_user FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
        CONSTRAINT chk_host_type CHECK (host_type IN ('post', 'comment', 'message', 'live', 'user_avatar'))
    );

COMMENT ON TABLE multimedia_usage_record IS '多媒体素材使用记录表';

COMMENT ON COLUMN multimedia_usage_record.usage_id IS '使用ID';

COMMENT ON COLUMN multimedia_usage_record.material_id IS '素材ID';

COMMENT ON COLUMN multimedia_usage_record.user_id IS '用户ID';

COMMENT ON COLUMN multimedia_usage_record.usage_scenario IS '使用场景';

COMMENT ON COLUMN multimedia_usage_record.usage_time IS '使用时间';

COMMENT ON COLUMN multimedia_usage_record.host_type IS '宿主类型';

COMMENT ON COLUMN multimedia_usage_record.host_id IS '宿主ID';

-- 18. 直播标签记录表
CREATE TABLE
    live_tag_record (
        live_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        tag_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (live_id, tag_id),
        CONSTRAINT fk_live_tag_live FOREIGN KEY (live_id) REFERENCES live (live_id) ON DELETE CASCADE,
        CONSTRAINT fk_live_tag_tag FOREIGN KEY (tag_id) REFERENCES tag (tag_id) ON DELETE CASCADE
    );

COMMENT ON TABLE live_tag_record IS '直播标签记录表';

COMMENT ON COLUMN live_tag_record.live_id IS '直播ID';

COMMENT ON COLUMN live_tag_record.tag_id IS '标签ID';

COMMENT ON COLUMN live_tag_record.tag_time IS '标记时间';

-- ======================
-- 索引创建
-- ======================
-- 用户表索引
CREATE INDEX idx_user_username ON user_info (username);

CREATE INDEX idx_user_activity ON user_info (activity_score DESC);

-- 论坛表索引
CREATE INDEX idx_forum_admin ON forum (admin_id);

CREATE INDEX idx_forum_activity ON forum (activity_score DESC);

-- 帖子表索引
CREATE INDEX idx_post_user ON post (user_id);

CREATE INDEX idx_post_forum ON post (forum_id);

CREATE INDEX idx_post_create_time ON post (create_time DESC);

CREATE INDEX idx_post_interaction ON post (interaction_score DESC);

-- 评论表索引
CREATE INDEX idx_comment_user ON comment (user_id);

CREATE INDEX idx_comment_post ON comment (post_id);

CREATE INDEX idx_comment_parent ON comment (parent_comment_id);

CREATE INDEX idx_comment_time ON comment (send_time DESC);

-- 标签表索引
CREATE INDEX idx_tag_content ON tag (content);

-- 直播表索引
CREATE INDEX idx_live_streamer ON live (streamer_id);

CREATE INDEX idx_live_status ON live (status);

CREATE INDEX idx_live_start_time ON live (start_time DESC);

CREATE INDEX idx_live_popularity ON live (popularity_score DESC);

-- 消息表索引
CREATE INDEX idx_message_sender ON message (sender_id);

CREATE INDEX idx_message_receiver ON message (receiver_id);

CREATE INDEX idx_message_time ON message (send_time DESC);

CREATE INDEX idx_message_read_status ON message (read_status);

-- 多媒体素材表索引
CREATE INDEX idx_material_type ON multimedia_material (material_type);

CREATE INDEX idx_material_upload_time ON multimedia_material (upload_time DESC);

-- 直播记录表索引
CREATE INDEX idx_live_record_live ON live_record (live_id);

-- 用户论坛记录表索引
CREATE INDEX idx_user_forum_forum ON user_forum_record (forum_id);

-- 帖子标签记录表索引
CREATE INDEX idx_post_tag_tag ON post_tag_record (tag_id);

-- 用户标签记录表索引
CREATE INDEX idx_user_tag_tag ON user_tag_record (tag_id);

-- 多媒体使用记录表索引
CREATE INDEX idx_usage_material ON multimedia_usage_record (material_id);

CREATE INDEX idx_usage_user ON multimedia_usage_record (user_id);

CREATE INDEX idx_usage_host ON multimedia_usage_record (host_type, host_id);

-- 直播标签记录表索引
CREATE INDEX idx_live_tag_tag ON live_tag_record (tag_id);