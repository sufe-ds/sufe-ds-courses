# 社交媒体网络 ER 模型

我们对一个一个简化版的、类似于小红书的社交媒体建立 ER 模型

## 实体

1. 用户
   - 用户名
   - 密码
   - 个人简介
   - 注册时间
   - 最后登陆时间
2. 帖子
   - 发布者
   - 标题
   - 正文
   - 多媒体素材：图片或是视频
   - 位置
   - 可见范围
   - 创建时间
   - 最后更新时间
   - 点赞数
   - 分享数
   - 标签：推荐算法/发布者为帖子打上的标签
   - 流量
3. 帖子 -> 评论
   - 发布者
   - 被评论实体：评论是不能凭空存在的，存在一个实体（帖子或者评论）被它评论
   - 多媒体素材
   - 正文
   - 创建时间
   - 点赞数
4. 多媒体素材
5. 多媒体素材 -> 图片
6. 多媒体素材 -> 视频
7. 多媒体素材 -> 表情包
8. 标签
9. 消息
   - 正文
   - 发送者
   - 接收者
   - 多媒体素材
   - 发送时间  

## 关系

- 一对多关系
  - 用户发布帖子
  - 帖子包含评论
  - 评论包含评论
  - 帖子/评论包含多媒体素材
  - 用户发送消息
- 多对一关系
- 多对多关系
  - 用户关注用户
  - 用户被打上标签
  - 帖子被打上标签
  - 帖子/评论/消息拥有多媒体素材

## ER 图

```mermaid
erDiagram
    USER {
        string 用户名
        string 密码
        text 简介
        datetime 注册时间
        datetime 最后登陆时间
        string 标签
    }
    POST {
        string user
        string title
        text content
        string location
        string visibility
        datetime create_time
        datetime update_time
        int like_count
        int share_count
        int view_count
    }
    
    COMMENT {
        string comment_id PK
        string user_id FK
        string target_id
        string target_type
        string media_id FK
        text content
        datetime create_time
        int like_count
    }
    
    MEDIA {
        string media_id PK
        string media_type
        string file_path
        int file_size
        datetime upload_time
    }
    
    TAG {
        string tag_id PK
        string tag_name
        string tag_type
    }
    
    MESSAGE {
        string message_id PK
        string sender_id FK
        string receiver_id FK
        string media_id FK
        text content
        datetime send_time
        boolean read_status
    }
    
    USER ||--o{ POST : "发布"
    USER ||--o{ COMMENT : "发布"
    USER ||--o{ MESSAGE : "发送"
    POST ||--o{ COMMENT : "包含"
    COMMENT ||--o{ COMMENT : "回复"
    
    USER }o--o{ USER : "关注"
    USER }o--o{ TAG : "用户标签"
    POST }o--o{ TAG : "帖子标签"
    POST }o--o{ MEDIA : "包含媒体"
    COMMENT }o--o{ MEDIA : "包含媒体"
    MESSAGE }o--o{ MEDIA : "包含媒体"
    
    MEDIA ||--|| IMAGE : "是"
    MEDIA ||--|| VIDEO : "是"
    MEDIA ||--|| EMOTICON : "是"
    
    IMAGE {
        string media_id PK,FK
        int width
        int height
        string format
    }
    
    VIDEO {
        string media_id PK,FK
        int duration
        string format
        string thumbnail
    }
    
    EMOTICON {
        string media_id PK,FK
        string category
        boolean animated
    }
```