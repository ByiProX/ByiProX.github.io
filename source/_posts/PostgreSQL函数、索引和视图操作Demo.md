---
title: PostgreSQL函数、索引和视图操作Demo
date: 2018-09-26 16:32:31
tags:
  - 面试
  - 数据库
categories:
  - 面试
  - 数据库
---
#### 创建演示数据表结构
```SQL
--创建dept表
CREATE TABLE dept (
    d_no INT PRIMARY KEY,     --部门编号
	d_name VARCHAR(30),       --部门名称
	d_location VARCHAR(300)   --部门所在地址
);

--dept表初始化数据
INSERT INTO dept VALUES (10, '开发部', '北京市海淀区');
INSERT INTO dept VALUES (20, '测试部', '北京市东城区');
INSERT INTO dept VALUES (30, '销售部', '上海市');
INSERT INTO dept VALUES (40, '财务部', '广州市');
INSERT INTO dept VALUES (50, '运维部', '武汉市');
INSERT INTO dept VALUES (60, '集成部', '南京市');

--创建employee表
CREATE TABLE employee (
    e_no INT PRIMARY KEY,             --雇员编号
	e_name VARCHAR(30) NOT NULL,      --雇员名称
	e_gender CHAR(2) NOT NULL,        --性别，f：女，m：男
	dept_no INT,                      --所在部门编号
	e_job VARCHAR(50) NOT NULL,       --职位
	e_salary NUMERIC(9, 2),           --工资
	e_hireDate DATE,                  --入职日期
	CONSTRAINT fk_emp_deptno FOREIGN KEY (dept_no) REFERENCES dept(d_no)
);

--初始化employee表
INSERT INTO employee VALUES (100, '赵志军', 'f', 10, '开发工程师', 5000, '2010-01-01');
INSERT INTO employee VALUES (101, '张铭雨', 'f', 10, '开发工程师', 6000, '2012-04-04');
INSERT INTO employee VALUES (102, '许锋', 'f', 10, '开发经理', 8000, '2008-01-01');
INSERT INTO employee VALUES (103, '王嘉琦', 'm', 20, '测试工程师', 4500, '2013-08-12');
INSERT INTO employee VALUES (104, '李江新', 'f', 20, '测试工程师', 5000, '2011-08-16');
INSERT INTO employee VALUES (105, '张海影', 'm', 20, '测试经理', 6000, '2009-11-12');
INSERT INTO employee VALUES (106, '马恩波', 'f', 30, '销售人员', 3000, '2014-09-01');
INSERT INTO employee VALUES (107, '李慧敏', 'm', 30, '销售人员', 5000, '2010-08-14');
INSERT INTO employee VALUES (108, '马爽爽', 'm', 30, '销售经理', 9000, '2006-12-02');
INSERT INTO employee VALUES (109, '史晓云', 'm', 30, '销售高级经理', 12000, '2003-07-14');
INSERT INTO employee VALUES (110, '刘燕凤', 'm', 40, '财务人员', 3000, '2011-06-01');
INSERT INTO employee VALUES (111, '王科', 'f', 40, '财务人员', 3500, '2010-05-01');
INSERT INTO employee VALUES (112, '李林英', 'm', 40, '财务经理', 5000, '2008-05-07');
INSERT INTO employee VALUES (113, '李杨', 'f', 10, '实习工程师', NULL, '2015-05-07');
INSERT INTO employee VALUES (114, '李刚', 'f', NULL, '实习工程师', NULL, '2015-05-07');
INSERT INTO employee VALUES (115, '王林', 'f', NULL, '实习工程师', NULL, '2015-05-07');
```
<!-- more -->

#### 函数使用：数值函数
```SQL
--AVG函数
SELECT AVG(e_salary) FROM employee;
--COUNT函数
SELECT COUNT(*) FROM employee;
--MAX函数
SELECT MAX(e_salary) FROM employee;
--MIN函数
SELECT MIN(e_salary) FROM employee;
--SUM函数
SELECT SUM(e_salary) FROM employee;
```

#### 函数使用：字符串函数
```SQL
--LENGTH函数
SELECT e_name, LENGTH(e_name) FROM employee;
--CONCAT函数
SELECT CONCAT(e_no, '|', e_name, '|', e_salary) FROM employee;
SELECT e_no, e_name, e_hireDate, CONCAT(e_no, e_name, e_hireDate) FROM employee;
--TRIM函数
SELECT CONCAT('         ', e_name), TRIM(CONCAT('         ', e_name)) FROM employee;
--REPLACE函数
SELECT e_name, REPLACE(e_name, '李', '张') FROM employee;
--SUBSTRING函数
SELECT e_name, SUBSTRING(e_name, 2, 3) FROM employee;
```


#### 函数使用：日期时间函数
```SQL
--EXTRACT函数
SELECT e_no, e_name, e_hireDate, EXTRACT(YEAR FROM e_hireDate), EXTRACT(MONTH FROM e_hireDate), EXTRACT(DAY FROM e_hireDate) FROM employee;
--CURRENT_DATE、CURRENT_TIME、NOW函数
SELECT CURRENT_DATE, CURRENT_TIME, now();
```


#### 创建函数示例

```SQL
-- 函数示例
CREATE FUNCTION add(INTEGER, INTEGER) RETURNS INTEGER          
    AS ' select $1 + $2; '
LANGUAGE SQL
RETURNS NULL ON NULL INPUT;



--应用
--创建函数
CREATE OR REPLACE FUNCTION CONCAT_TEST(INTEGER, VARCHAR, DATE) RETURNS VARCHAR
    AS 'SELECT $1||$2||$3;'
    LANGUAGE SQL
RETURNS NULL ON NULL INPUT;

--函数调用
select e_no, e_name, e_hireDate, CONCAT_TEST(e_no, e_name, e_hireDate) from employee;

--删除函数
DROP FUNCTION CONCAT_TEST(INTEGER, VARCHAR, DATE);
```

#### 索引
```SQL
--创建索引
CREATE INDEX emp_name_index ON employee (e_name);
--删除索引
DROP INDEX emp_name_index;
```

#### 视图
```SQL
--创建视图
CREATE VIEW V_EMP_DEV AS
  SELECT e_no, e_name, e_salary, e_hireDate
  FROM employee
  WHERE dept_no = 10 ORDER BY e_salary DESC;

--视图调用
SELECT * FROM V_EMP_DEV;
--删除视图
DROP VIEW V_EMP_DEV;
```
