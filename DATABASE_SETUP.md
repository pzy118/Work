# 数据库设置说明

## 表结构修改

我已经重新设计了数据库表结构，添加了正确的外键关系：

### 1. 执行SQL脚本

在Supabase的SQL编辑器中执行 `setup_tables.sql` 文件中的SQL命令：

```sql
-- 删除现有表并重新创建
DROP TABLE IF EXISTS movie_categories CASCADE;
DROP TABLE IF EXISTS movies CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- 创建表结构（详见setup_tables.sql文件）
```

### 2. 表结构说明

#### categories 表
- `id`: UUID主键
- `name`: 分类名称（唯一）
- `created_at`, `updated_at`: 时间戳

#### movies 表  
- `id`: UUID主键
- `title`: 电影标题
- `rating`: 评分（0-10分）
- `comment`: 短评
- `created_at`, `updated_at`: 时间戳

#### movie_categories 表（关联表）
- `id`: UUID主键
- `movie_id`: 外键，关联movies表
- `category_id`: 外键，关联categories表
- `created_at`: 时间戳
- `UNIQUE(movie_id, category_id)`: 防止重复关联

### 3. 外键关系

- `movie_categories.movie_id` → `movies.id` (级联删除)
- `movie_categories.category_id` → `categories.id` (级联删除)

### 4. 示例数据

SQL脚本包含了6个示例分类和4部示例电影，以及它们的分类关联。

## 使用步骤

1. 在Supabase项目中打开SQL编辑器
2. 复制 `setup_tables.sql` 的内容
3. 执行SQL脚本
4. 刷新网页应用

现在应用应该能正常工作，不再出现关系查询错误。