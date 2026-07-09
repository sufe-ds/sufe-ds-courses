-- =============================================================================
-- 数据库角色与权限管理 SQL 脚本
-- 数据库系统: PostgreSQL
-- 用途: 创建角色、分配权限、配置行级安全策略
-- =============================================================================

-- =============================================================================
-- 1. 创建角色
-- =============================================================================

CREATE ROLE role_guest;
CREATE ROLE role_user;
CREATE ROLE role_forum_admin;
CREATE ROLE role_moderator;
CREATE ROLE role_analyst;
CREATE ROLE role_admin;

-- =============================================================================
-- 2. 访客角色权限（只读公开内容）
-- =============================================================================

GRANT SELECT ON forum TO role_guest;
GRANT SELECT ON tag TO role_guest;
GRANT SELECT ON v_forum_statistics TO role_guest;
GRANT SELECT ON v_hot_posts_detail TO role_guest;
GRANT SELECT ON v_live_popularity_ranking TO role_guest;
GRANT SELECT ON v_tag_usage_stats TO role_guest;

-- =============================================================================
-- 3. 普通用户角色权限
-- =============================================================================

-- 继承访客权限
GRANT role_guest TO role_user;

-- 查询权限
GRANT SELECT ON user_info TO role_user;
GRANT SELECT ON post TO role_user;
GRANT SELECT ON comment TO role_user;
GRANT SELECT ON live TO role_user;
GRANT SELECT ON multimedia_material TO role_user;
GRANT SELECT ON video TO role_user;
GRANT SELECT ON image TO role_user;
GRANT SELECT ON emoji TO role_user;

-- 修改权限（自己的内容）
GRANT INSERT, UPDATE, DELETE ON post TO role_user;
GRANT INSERT, UPDATE, DELETE ON comment TO role_user;
GRANT INSERT, UPDATE, DELETE ON message TO role_user;
GRANT INSERT, UPDATE, DELETE ON live TO role_user;
GRANT INSERT, UPDATE, DELETE ON multimedia_material TO role_user;
GRANT INSERT, UPDATE, DELETE ON video TO role_user;
GRANT INSERT, UPDATE, DELETE ON image TO role_user;
GRANT INSERT, UPDATE, DELETE ON emoji TO role_user;

-- 关系表权限
GRANT INSERT, UPDATE, DELETE ON live_record TO role_user;
GRANT INSERT, UPDATE, DELETE ON user_forum_record TO role_user;
GRANT INSERT, UPDATE, DELETE ON post_tag_record TO role_user;
GRANT INSERT, UPDATE, DELETE ON user_tag_record TO role_user;
GRANT INSERT, UPDATE, DELETE ON multimedia_usage_record TO role_user;
GRANT INSERT, UPDATE, DELETE ON live_tag_record TO role_user;

-- 视图权限
GRANT SELECT ON v_user_activity_summary TO role_user;

-- =============================================================================
-- 4. 论坛管理员角色权限
-- =============================================================================

-- 继承普通用户权限
GRANT role_user TO role_forum_admin;

-- 论坛管理权限
GRANT UPDATE, DELETE ON post TO role_forum_admin;
GRANT UPDATE, DELETE ON comment TO role_forum_admin;
GRANT UPDATE ON forum TO role_forum_admin;
GRANT INSERT, UPDATE, DELETE ON tag TO role_forum_admin;
GRANT UPDATE, DELETE ON user_forum_record TO role_forum_admin;
GRANT UPDATE, DELETE ON post_tag_record TO role_forum_admin;

-- =============================================================================
-- 5. 内容审核员角色权限
-- =============================================================================

-- 继承普通用户权限
GRANT role_user TO role_moderator;

-- 审核权限（查看和删除违规内容）
GRANT SELECT, DELETE ON post TO role_moderator;
GRANT SELECT, DELETE ON comment TO role_moderator;
GRANT SELECT, DELETE ON live TO role_moderator;
GRANT SELECT, DELETE ON message TO role_moderator;
GRANT SELECT, UPDATE ON user_info TO role_moderator;
GRANT SELECT, DELETE ON multimedia_material TO role_moderator;
GRANT SELECT, DELETE ON video TO role_moderator;
GRANT SELECT, DELETE ON ad TO role_moderator;
GRANT SELECT, DELETE ON image TO role_moderator;
GRANT SELECT, DELETE ON emoji TO role_moderator;

-- =============================================================================
-- 6. 数据分析师角色权限
-- =============================================================================

-- 对所有表的只读权限
GRANT SELECT ON ALL TABLES IN SCHEMA public TO role_analyst;

-- =============================================================================
-- 7. 系统管理员角色权限
-- =============================================================================

-- 完全控制权限
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO role_admin;

-- =============================================================================
-- 8. 行级安全策略 (Row Level Security)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 8.1 用户信息表安全策略
-- -----------------------------------------------------------------------------

ALTER TABLE user_info ENABLE ROW LEVEL SECURITY;

-- 用户只能查看自己的信息，审核员、分析师和管理员可以查看所有
CREATE POLICY user_info_select_policy ON user_info
    FOR SELECT
    USING (
        user_id = current_setting('app.current_user_id')::INTEGER 
        OR current_user IN ('role_moderator', 'role_analyst', 'role_admin')
    );

-- 用户只能更新自己的信息，审核员和管理员可以更新所有
CREATE POLICY user_info_update_policy ON user_info
    FOR UPDATE
    USING (
        user_id = current_setting('app.current_user_id')::INTEGER 
        OR current_user IN ('role_moderator', 'role_admin')
    );

-- -----------------------------------------------------------------------------
-- 8.2 帖子表安全策略
-- -----------------------------------------------------------------------------

ALTER TABLE post ENABLE ROW LEVEL SECURITY;

-- 公开帖子所有人可见，私密帖子仅作者可见，审核员和分析师可见所有
CREATE POLICY post_select_policy ON post
    FOR SELECT
    USING (
        visibility = 'public' 
        OR user_id = current_setting('app.current_user_id')::INTEGER
        OR current_user IN ('role_moderator', 'role_analyst', 'role_admin')
    );

-- 用户只能创建属于自己的帖子
CREATE POLICY post_insert_policy ON post
    FOR INSERT
    WITH CHECK (user_id = current_setting('app.current_user_id')::INTEGER);

-- 用户只能更新自己的帖子，论坛管理员可更新论坛内的帖子
CREATE POLICY post_update_policy ON post
    FOR UPDATE
    USING (
        user_id = current_setting('app.current_user_id')::INTEGER
        OR current_user IN ('role_forum_admin', 'role_moderator', 'role_admin')
    );

-- 用户只能删除自己的帖子，论坛管理员和审核员可删除论坛内的帖子
CREATE POLICY post_delete_policy ON post
    FOR DELETE
    USING (
        user_id = current_setting('app.current_user_id')::INTEGER
        OR current_user IN ('role_forum_admin', 'role_moderator', 'role_admin')
    );

-- -----------------------------------------------------------------------------
-- 8.3 消息表安全策略
-- -----------------------------------------------------------------------------

ALTER TABLE message ENABLE ROW LEVEL SECURITY;

-- 用户只能查看自己发送或接收的消息
CREATE POLICY message_select_policy ON message
    FOR SELECT
    USING (
        sender_id = current_setting('app.current_user_id')::INTEGER 
        OR receiver_id = current_setting('app.current_user_id')::INTEGER
        OR current_user IN ('role_moderator', 'role_admin')
    );

-- 用户只能发送属于自己的消息
CREATE POLICY message_insert_policy ON message
    FOR INSERT
    WITH CHECK (sender_id = current_setting('app.current_user_id')::INTEGER);

-- =============================================================================
-- 9. 创建示例用户并分配角色
-- =============================================================================

-- 创建普通用户
CREATE USER user_zhang WITH PASSWORD 'password123';
GRANT role_user TO user_zhang;

-- 创建系统管理员
CREATE USER admin_wang WITH PASSWORD 'admin456';
GRANT role_admin TO admin_wang;

-- 创建数据分析师
CREATE USER analyst_li WITH PASSWORD 'analyst789';
GRANT role_analyst TO analyst_li;

-- =============================================================================
-- 10. 使用说明
-- =============================================================================

-- 应用层需要在每次数据库连接时设置当前用户 ID
-- 示例:
-- SET app.current_user_id = 1001;

-- 这样行级安全策略才能正确识别当前操作的用户身份
