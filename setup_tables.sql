-- 删除现有的表（如果存在）
DROP TABLE IF EXISTS movie_categories CASCADE;
DROP TABLE IF EXISTS movies CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- 创建分类表
CREATE TABLE categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建电影表
CREATE TABLE movies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 10),
    comment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建电影分类关联表
CREATE TABLE movie_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(movie_id, category_id) -- 防止重复关联
);

-- 创建索引以提高查询性能
CREATE INDEX idx_movie_categories_movie_id ON movie_categories(movie_id);
CREATE INDEX idx_movie_categories_category_id ON movie_categories(category_id);

-- 插入一些示例分类数据
INSERT INTO categories (name) VALUES 
('动作片'),
('喜剧片'),
('爱情片'),
('科幻片'),
('恐怖片'),
('动画片');

-- 插入一些示例电影数据
INSERT INTO movies (title, rating, comment) VALUES 
('复仇者联盟4', 8.5, '史诗级的超级英雄电影，十年布局的完美收官'),
('泰坦尼克号', 9.0, '经典爱情电影，永恒的经典'),
('千与千寻', 9.2, '宫崎骏的杰作，充满想象力的世界'),
('盗梦空间', 8.8, '诺兰的烧脑神作，层层梦境');

-- 为示例电影添加分类关联
INSERT INTO movie_categories (movie_id, category_id) 
SELECT 
    (SELECT id FROM movies WHERE title = '复仇者联盟4'),
    (SELECT id FROM categories WHERE name = '动作片');

INSERT INTO movie_categories (movie_id, category_id) 
SELECT 
    (SELECT id FROM movies WHERE title = '复仇者联盟4'),
    (SELECT id FROM categories WHERE name = '科幻片');

INSERT INTO movie_categories (movie_id, category_id) 
SELECT 
    (SELECT id FROM movies WHERE title = '泰坦尼克号'),
    (SELECT id FROM categories WHERE name = '爱情片');

INSERT INTO movie_categories (movie_id, category_id) 
SELECT 
    (SELECT id FROM movies WHERE title = '千与千寻'),
    (SELECT id FROM categories WHERE name = '动画片');

INSERT INTO movie_categories (movie_id, category_id) 
SELECT 
    (SELECT id FROM movies WHERE title = '盗梦空间'),
    (SELECT id FROM categories WHERE name = '科幻片');