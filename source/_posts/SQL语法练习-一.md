---
title: SQL语法练习(一)
date: 2018-08-28 00:32:31
tags:
  - SQL
categories:
  - SQL
---

1. 查询学习课程"python"比课程 "java" 成绩高的学生的学号;
-- 思路：
-- 获取所有有python课程的人（学号，成绩） - 临时表
-- 获取所有有java课程的人（学号，成绩） - 临时表
-- 根据学号连接两个临时表：
-- 学号 | 物理成绩 | 生物成绩
-- 然后再进行筛选
```SQL
select A.s_id from
		(select s_id, num as python from score left join course on score.c_id = course.c_id where course.c_name = 'python') as A
		left join
		(select s_id, num as java   from score left join course on score.c_id = course.c_id where course.c_name = 'java')   as B
		on A.s_id = B.s_id where A.python > B.java;
```
<!-- more -->
2. 查询平均成绩大于65分的同学的姓名和平均成绩(保留两位小数);
```SQL
SELECT student.s_name as names, round(AVG(score.num), 2) as average
FROM student, score
WHERE student.s_id = score.s_id
GROUP BY student.s_name
HAVING AVG(score.num) > 65;
```

3. 查询所有同学的姓名、选课数、总成绩
```SQL
SELECT student.s_name, COUNT(score.s_id) as course_num, SUM(score.num) as total_grades
FROM student, score
WHERE student.s_id = score.s_id
GROUP BY student.s_name
ORDER BY student.s_name;
```

4. 查询所有的课程的名称以及对应的任课老师姓名;
```SQL
SELECT course.c_name, teacher.t_name  
FROM course, teacher
WHERE course.t_id = teacher.t_id;
```

5. 查询没学过“alex”老师课的同学的姓名;
```SQL
SELECT s_name
FROM student
WHERE student.s_id NOT IN (
			SELECT DISTINCT score.s_id
			FROM score, course, teacher
			WHERE course.c_id = score.c_id AND teacher.t_id = course.t_id AND teacher.t_name = 'alex'
			)
```

6. 查询学过'python'并且也学过编号'java'课程的同学的姓名
```SQL
SELECT s_name FROM
		(SELECT score.s_id as sid, score.c_id as cid
		 FROM score, course
		 WHERE score.c_id = course.c_id AND (course.c_name = 'python' OR course.c_name = 'java')) as B
LEFT JOIN student ON B.sid = student.s_id
GROUP BY s_name
HAVING COUNT(s_name) > 1;
```

7. 查询学过“alex”老师所教的全部课程的同学的姓名
```SQL
SELECT s_name FROM
		(SELECT score.s_id as sid, score.c_id as cid
		 FROM score, course, teacher
		 WHERE score.c_id = course.c_id AND teacher.t_id = course.t_id AND teacher.t_name = 'alex') as B
LEFT JOIN student ON B.sid = student.s_id
GROUP BY s_name
HAVING COUNT(s_name) > 1;
```
8. 查询挂科超过两门(包括两门)的学生姓名;
```SQL
SELECT s_name FROM
		(SELECT score.s_id as sid, score.c_id as cid
		 FROM score, course
		 WHERE score.c_id = course.c_id  AND (score.num < 60 OR score.num ISNULL)) as B
     LEFT JOIN student ON B.sid = student.s_id
GROUP BY s_name
HAVING COUNT(s_name) > 1;
```

-- ——————————————————————————————————————————————————————————————
-- INSERT INTO student VALUES (1, '鲁班', 12, '男');
-- INSERT INTO student VALUES (2, '貂蝉', 20, '女');
-- INSERT INTO student VALUES (3, '刘备', 35, '男');
-- INSERT INTO student VALUES (4, '关羽', 34, '男');
-- INSERT INTO student VALUES (5, '张飞', 33, '女');
--
--

--
-- INSERT INTO teacher VALUES (1, '大王');
-- INSERT INTO teacher VALUES (2, 'alex');
-- INSERT INTO teacher VALUES (3, 'egon');
-- INSERT INTO teacher VALUES (4, 'peiqi');
--


-- INSERT INTO course VALUES (1, 'python', 1);
-- INSERT INTO course VALUES (2, 'java', 2);
-- INSERT INTO course VALUES (3, 'linux', 3);
-- INSERT INTO course VALUES (4, 'go', 2);


-- INSERT INTO score VALUES (1, 1, 1, 79);
-- INSERT INTO score VALUES (2, 1, 2, 77);
-- INSERT INTO score VALUES (3, 1, 3, 58);
-- INSERT INTO score VALUES (4, 2, 2, 66);
-- INSERT INTO score VALUES (5, 2, 3, 77);
-- INSERT INTO score VALUES (6, 3, 1, 61);
-- INSERT INTO score VALUES (7, 3, 2, 64);
-- INSERT INTO score VALUES (8, 4, 3, 70);
--
