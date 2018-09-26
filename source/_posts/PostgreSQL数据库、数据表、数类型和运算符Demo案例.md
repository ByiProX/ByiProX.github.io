---
title: PostgreSQL数据库、数据表、数类型和运算符Demo案例
date: 2018-09-26 10:19:05
tags:
  - 面试
  - 数据库
categories:
  - 面试
  - 数据库
---

#### 数据库对象操作 ####
```SQL
--最简单创建数据库示例（使用默认参数）
CREATE DATABASE db_jikexueyuan1;

--带参数创建数据库示例（指定数据库OWNER和字符集）
CREATE DATABASE db_jikexueyuan2 WITH OWNER = postgres ENCODING = 'UTF8';

--修改数据库名称
ALTER DATABASE db_jikexueyuan2 RENAME TO db_jikexueyuan3;

--修改数据库连接数
ALTER DATABASE db_jikexueyuan2 CONNECTION LIMIT = 20;

--删除数据库
DROP DATABASE db_jikexueyuan2;
```
<!-- more -->
#### 数据表对象操作 ####
```SQL
--创建student数据表
CREATE TABLE studnet (
   id INT,                   --学生编号
   name VARCHAR(30),         --学生姓名
   birthday DATE,            --出生日期
   score NUMERIC(5, 2)       --学分
);

--修改数据表名称
ALTER TABLE studnet RENAME TO studnet1;

--修改数据表字段长度
ALTER TABLE studnet1 ALTER COLUMN name TYPE VARCHAR(40);

--修改数据表字段名称
ALTER TABLE studnet1 RENAME id TO bh;

--在数据表中新增字段
ALTER TABLE studnet1 ADD COLUMN address VARCHAR(100);

--删除数据表中字段
ALTER TABLE student DROP COLUMN name;

--删除数据表对象
DROP TABLE studnet1;

--删除数据表之前先做判断
DROP TABLE IF EXISTS studnet1;
```

#### 数据类型 ####
```SQL
--数值类型
CREATE TABLE temp (x SMALLINT, y INT, z NUMERIC(5, 2));
INSERT INTO temp VALUES (1, 100, 3.58);
--INSERT INTO temp VALUES (1, 100, 1000.58);--（出现错误，超过存储范围）
INSERT INTO temp VALUES (1, 100, 100.58);
INSERT INTO temp VALUES (1, 100, 100.588);--（合法，会进行四舍五入）

--日期/时间类型
CREATE TABLE temp1 (t TIME, d DATE, ts TIMESTAMP);
INSERT INTO temp1 VALUES ('02:02:02', '1996-01-01', '1996-01-01 02:02:02');
INSERT INTO temp1 VALUES ('101112', '96-01-01', '1996-01-01 02:02:02');

--字符串类型
CREATE TABLE temp2 (ch CHAR(4), vch VARCHAR(30), t TEXT);
INSERT INTO temp2 VALUES ('abcd', '极客学院', '极客学院极客学院极客学院');

--比较char类型与varchar类型之间的区别
SELECT
    CONCAT('(', ch, ')'),
	CONCAT('(', vch, ')'),
    CONCAT('(', t, ')')
FROM temp2;
```

#### 运算符介绍
```SQL
--算术运算符
SELECT 3+2, 3-2, 3*2, 3/2, 3%2;

--比较运算符
--比较运算符（一）
SELECT 1 = 0, '2' = 2, '2' <> 2, 2 = 2, NULL = NULL, NULL != NULL;

--比较运算符（二）
SELECT 1 >= 2, 4 >= 4, 2 > 1, 'good' >= 'god', 'good' > 'god', NULL >= NULL;

--比较运算符（三）
SELECT 4 BETWEEN 2 AND 5, 12 BETWEEN 10 AND 12;

--比较运算符（四）
SELECT 2 IN (2,3,4), 3 NOT IN (1,2,5,9), 'a' IN ('a','b','c','d'), NULL IN (1,3,NULL);

--比较运算符（五）
-- % 表示任意0个或多个字符
-- _ 表示任意单个字符
-- [ ] 表示括号内所列字符中的一个（类似与正则表达式）
-- [^ ] 表示不在括号所列之内的单个字符
SELECT 'abc' LIKE 'abc', 'abc' LIKE 'ab_', 'abc' LIKE '%c', 'abc' LIKE 't___';

--逻辑运算符
--逻辑运算符（一）
SELECT NOT '1', NOT 'y', NOT '0', NOT NULL, NOT 'n';

--逻辑运算符（二）
SELECT '1' AND 'y', '1' AND '0', '1' AND NULL, '0' AND NULL;

--逻辑运算符（三）
SELECT '1' OR 't', '1' OR 'y', '1' OR NULL;
```
