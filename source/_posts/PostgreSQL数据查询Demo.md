---
title: PostgreSQL数据查询Demo
date: 2018-09-26 10:58:30
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

```
```SQL
-- select 语句顺序
SELECT
  {* | <字段列表>}       //查询结果字段内容
FROM
  [
      <表1>,<表2>…                       //查询数据表
      [WHERE <表达式>]                   //where查询条件表达式
      [GROUP BY <group by definition>]  //group by数据分组
      [HAVING <expression> [{<operator> <expression>}…]]            
      [ORDER BY <order by definition>]  //查询结果排序
      [LIMIT [<offset>,] <row count>]   //限制结果显示数量
  ]
```

<!-- more -->
```SQL
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

--查询所有字段
--查询所有字段内容(使用*号通配符)
SELECT * FROM employee;
--查询所有字段内容(穷举所有字段)  --讲解一下使用*号的弊端
SELECT e_no, e_name, e_gender, dept_no, e_job, e_salary, e_hireDate FROM employee;
--查询指定字段数据内容
SELECT e_no, e_name, e_hireDate FROM employee;

--使用别名
SELECT d_no, d_name, d_location FROM dept;

--查询指定记录，带条件查询
--指定条件查询数据
SELECT e_no, e_name, e_hireDate FROM employee WHERE e_salary = 5000;
SELECT e_no, e_name, e_gender FROM employee WHERE e_gender = 'f';
SELECT e_no, e_name, e_salary FROM employee WHERE e_salary < 5000;

--复杂条件查询
--带IN关键字的条件查询
SELECT e_no, e_name, dept_no FROM employee WHERE dept_no IN (20, 30);
SELECT e_no, e_name, dept_no FROM employee WHERE dept_no NOT IN (20, 30);

--带BETWEEN AND关键字的范围查询
SELECT e_no, e_name, e_hireDate FROM employee WHERE e_hireDate BETWEEN '2010-01-01' AND '2015-01-01';
SELECT e_no, e_name, e_salary FROM employee WHERE e_salary NOT BETWEEN 5000 AND 8000;

--带LIKE的字符匹配查询
SELECT e_no, e_name FROM employee WHERE e_name LIKE '李%';
SELECT e_no, e_name FROM employee WHERE e_name NOT LIKE '李_';

--查询空值内容
SELECT e_no, e_name, e_salary FROM employee WHERE e_salary IS NULL;
SELECT e_no, e_name, e_salary FROM employee WHERE e_salary IS NOT NULL;

--带AND的多条件查询
SELECT e_no, e_name, e_gender, dept_no FROM employee WHERE e_gender = 'f' AND dept_no = 10;
SELECT e_no, e_name, e_gender, dept_no FROM employee WHERE e_gender = 'f' AND dept_no IN (10, 30);

--带OR的多条件查询
SELECT e_no, e_name, dept_no FROM employee WHERE dept_no = 10 OR dept_no = 20;
SELECT e_no, e_name, dept_no FROM employee WHERE dept_no IN (10, 20);

--对查询结果进行排序
SELECT e_salary FROM employee ORDER BY e_salary ASC;
SELECT e_salary FROM employee ORDER BY e_salary DESC;
SELECT e_salary, e_hireDate FROM employee ORDER BY e_salary ASC, e_hireDate DESC;

--用LIMIT限制查询结果的数量
SELECT * FROM employee LIMIT 5;
SELECT * FROM employee LIMIT 4 OFFSET 3;

--连接查询
--内连接查询
SELECT e_no, e_name, e_job, d_name, d_location FROM employee, dept WHERE dept_no = d_no;
SELECT e_no, e_name, e_job, d_name, d_location FROM employee INNER JOIN dept ON dept_no = d_no WHERE dept_no = 10;

--外连接查询
--左连接查询
SELECT e.e_no, e.e_name, e.dept_no, d.d_name, d.d_location FROM employee e LEFT JOIN dept d ON e.dept_no = d.d_no
--右连接查询
SELECT e.e_no, e.e_name, e.dept_no, d.d_name, d.d_location FROM employee e RIGHT JOIN dept d ON e.dept_no = d.d_no

--子查询
--带EXISTS关键字的子查询
-- 先在外层查询中取“学生表”的第一行记录，用该记录的相关的属性值（在内层WHERE子句中给定的）处理内层查询，若外层的WHERE子句返回“TRUE”值，则这条记录放入结果表中。然后再取下一行记录；重复上述过程直到外层表的记录全部遍历一次为止。
SELECT * FROM employee WHERE EXISTS (SELECT d_no FROM dept WHERE d_name = '开发部');
SELECT * FROM employee WHERE EXISTS (SELECT d_no FROM dept WHERE d_name = '开发部'  AND dept_no = d_no);

SELECT * FROM employee WHERE NOT EXISTS (SELECT d_no FROM dept WHERE d_name = '开发部'  AND dept_no = d_no);

--带IN关键字的子查询
select * from employee WHERE dept_no in (select d_no from dept WHERE d_name = '开发部');
select * from employee WHERE dept_no not in (select d_no from dept WHERE d_name = '开发部');

--标量子查询
SELECT e.e_no, e.e_name, (SELECT d_name || ' ' || d_location FROM dept d WHERE d.d_no = e.dept_no) AS address FROM employee e;
SELECT e.e_no, e.e_name, (SELECT concat(d_name, '---', d_location) FROM dept d WHERE d.d_no = e.dept_no) AS address FROM employee e;

--合并查询结果
--使用UNION ALL合并结果
SELECT e_no, e_name, dept_no, e_salary FROM employee WHERE dept_no IN (10, 20)
UNION ALL
SELECT e_no, e_name, dept_no, e_salary FROM employee WHERE e_salary > 5000;

--使用UNION合并结果
SELECT e_no, e_name, dept_no, e_salary FROM employee WHERE dept_no IN (10, 20)
UNION
SELECT e_no, e_name, dept_no, e_salary FROM employee WHERE e_salary > 5000;

--查询结果使用空值占位
SELECT e_no, e_name, dept_no, e_salary, e_hireDate FROM employee WHERE dept_no IN (10, 20)
UNION ALL
SELECT e_no, e_name, dept_no, e_salary, NULL FROM employee WHERE e_salary > 5000;

```
