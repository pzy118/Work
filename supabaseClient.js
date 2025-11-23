// 替换为你的Supabase项目URL和匿名密钥（从Supabase项目设置→API中复制）
const SUPABASE_URL = "https://mlzrfwakiuobfnmshsmv.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_YUj9js42OBH52tNMMeL09A_ZI9AqO3p";

// 初始化Supabase客户端（无需安装依赖，直接用CDN）
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);