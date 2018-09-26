---
title: PostgreSQL数据操作和数据表约束Demo
date: 2018-09-26 13:57:21
tags:
  - 面试
  - 数据库
categories:
  - 面试
  - 数据库
---

#### 插入数据
```SQL
--创建student数据表
CREATE TABLE student (
   id INT,                   --学生编号
   name VARCHAR(30),         --学生姓名
   birthday DATE,            --出生日期
   score NUMERIC(5, 2)       --学分
);

--向表中所有字段插入数据（顺序不能乱）
INSERT INTO student VALUES (1, '张三', '1990-01-01', 3.85);

--向表中指定字段插入数据
INSERT INTO student(id, name, birthday) VALUES (2, '李四', '1990-01-02');

--向表中指定字段插入数据（打乱字段顺序）
INSERT INTO student(id, birthday, name) VALUES (3, '1988-05-01', '王五');

--使用INSERT语句批量插入多条数据
INSERT INTO student(id, name, birthday) VALUES (4, '张三1', '1990-02-01'), (5, '张三2', '1990-02-02'), (6, '张三3', '1990-02-03');

--创建student1数据表
CREATE TABLE student_new (
   id INT,                   --学生编号
   name VARCHAR(30),         --学生姓名
   birthday DATE,            --出生日期
   score NUMERIC(5, 2)       --学分
);

--将查询结果插入到表中
INSERT INTO student_new SELECT * FROM student;

--将查询结果插入到表中
INSERT INTO student_new(id, name, birthday) SELECT id, name, birthday FROM student;
```
<!-- more -->

#### 更新数据
```SQL
--指定条件更新数据
update student set name = '李四1' where id = 2;

--批量更新数据
UPDATE student SET score = 3.76;

--将指定结果更新到对应字段
update student set score = 1.1+2.3 where id = 1;
```


#### 删除数据
```SQL
--删除数据
DELETE FROM student WHERE id = 1;
DELETE FROM student WHERE birthday BETWEEN '1988-01-01' AND '1989-12-31';

--TRUNCATE清空数据
TRUNCATE TABLE student_new;

```

#### 主键约束
```SQL
--创建emp表
CREATE TABLE emp (
   id INT PRIMARY KEY,       --编号
   name VARCHAR(30),         --姓名
   salary NUMERIC(9, 2)      --工资
);

INSERT INTO emp VALUES (1, '张三', 3000.00);
--INSERT INTO emp VALUES (1, '李四', 3000.00); --插入提示错误，主键冲突

--创建emp1表
CREATE TABLE emp1 (
   id INT,                   --编号
   name VARCHAR(30),         --姓名
   salary NUMERIC(9, 2),     --工资
   CONSTRAINT pk_emp1 PRIMARY KEY(id)
);

--创建emp2表（联合主键）
CREATE TABLE emp2 (
   id INT,                   --编号
   name VARCHAR(30),         --姓名
   salary NUMERIC(9, 2),     --工资
   CONSTRAINT pk_emp2 PRIMARY KEY(id, name)
);
```

#### 外键约束
```SQL
--创建dept表
CREATE TABLE dept (
   id INT,                   --编号
   name VARCHAR(30),         --部门名称
   CONSTRAINT pk_dept PRIMARY KEY(id)
);

INSERT INTO dept VALUES(1, '开发部');
INSERT INTO dept VALUES(2, '测试部');

--创建emp表
CREATE TABLE emp3 (
   id INT PRIMARY KEY,       --编号
   name VARCHAR(30),         --姓名
   salary NUMERIC(9, 2),     --工资
   deptId INT,
   CONSTRAINT fk_emp3_dept FOREIGN KEY(deptId) REFERENCES dept(id)
);

--插入数据
INSERT INTO emp3 VALUES(1, '张三', 3000.00, 1);
--INSERT INTO emp3 VALUES(2, '李四', 3000.00, 3); --插入数据报错，外键关联数据不存在
--DELETE FROM dept WHERE id = 1; --删除数据报错，存在外键关联数据
DELETE FROM dept WHERE id = 2; --不存在外键关联数据，可以正常删除数据

--删除表
--DROP TABLE dept; --直接删除dept表会报错，与emp3表存在关联
DROP TABLE dept CASCADE; --强制递归删除数据

--创建非空约束
CREATE TABLE emp4 (
   id INT PRIMARY KEY,           --编号
   name VARCHAR(30) NOT NULL,    --姓名
   salary NUMERIC(9, 2)         --工资
);

INSERT INTO emp4 VALUES(1, '张三', 3000.00);
--INSERT INTO emp4 VALUES(2, NULL, 3000.00); --插入数据报错，违法非空约束

--创建唯一约束
CREATE TABLE emp5 (
   id INT PRIMARY KEY,          --编号
   name VARCHAR(30),            --姓名
   phone VARCHAR(30) UNIQUE,    --电话号码
   salary NUMERIC(9, 2)         --工资
);

INSERT INTO emp5 VALUES(1, '张三', '13436652541', 3000.00);
--INSERT INTO emp5 VALUES(2, '李四', '13436652541', 3000.00); --插入数据报错，违法唯一约束

--创建默认值约束
CREATE TABLE emp6 (
   id INT PRIMARY KEY,               --编号
   name VARCHAR(30),                 --姓名
   salary NUMERIC(9, 2) default 0.0  --工资
);

insert into emp6 (id, name) values (1,'张三');
insert into emp6 (id, name, salary) values (2,'李四', 3000);
```

-------------
