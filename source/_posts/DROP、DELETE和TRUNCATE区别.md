---
title: DROP、DELETE和TRUNCATE区别
date: 2018-09-26 13:20:40
tags:
  - 面试
  - 数据库
categories:
  - 面试
  - 数据库
---

|  Diffs   | DELETE    |TRUNCATE   | Drop |
| :-----: | :-----:  | :-----:   |  :-----:|
| 执行速度      | 慢  | 较快  |       快       |
| 可执行条件    | 可以  | 不可以  |   不可以       |
| 语句分类    | DML  | DDL  |        DDL       |
| 可以回滚事务    | 可以  | 不可以  |     不可以      |
| 删除操作记录日志    | 记录  | 不记录  |     不记录     |

- drop：drop table 表名
删除内容和定义，并释放空间。执行drop语句，将使此表的结构一起删除。
- truncate (清空表中的数据)：truncate table 表名
删除内容、释放空间但不删除定义(也就是保留表的数据结构)。与drop不同的是,只是清空表数据而已。
truncate不能删除行数据，虽然只删除数据，但是比delete彻底，它只删除表数据。
- delete：delete from 表名 （where 列名 = 值）
与truncate类似，delete也只删除内容、释放空间但不删除定义；但是delete即可以对行数据进行删除，也可以对整表数据进行删除。

---------------------

<!-- more -->

#### 相同点：

 - truncate 和不带 where 子句的 delete，以及 drop 都会删除表内的数据

#### 不同点:

1. `truncate 和 delete 只删除数据不删除表的结构(定义)`
drop 语句将删除表的结构被依赖的约束(constrain)、触发器(trigger)、索引(index);依赖于该表的存储过程/函数将保留,但是变为 invalid 状态。

2. `delete 语句是数据库操作语言(dml)，这操作会放到rollback segement 中，事务提交之后才生效;如果有相应的 trigger，执行的时候将被触发。`
`truncate、drop 是数据库定义语言(ddl)，操作立即生效，原数据不放到 rollback segment 中，不能回滚，操作不触发 trigger。`

3. delete 语句不影响表所占用的 extent，高水线(high watermark)保持原位置不动
　　显然 drop 语句将表所占用的空间全部释放。
　　truncate 语句缺省情况下见空间释放到 minextents个 extent，除非使用reuse storage;truncate 会将高水线复位(回到最开始)。

4. 速度，一般来说: drop> truncate > delete

5. 安全性：小心使用 drop 和 truncate，尤其没有备份的时候.否则哭都来不及

6. 使用上: 想删除部分数据行用 delete，注意带上where子句. 回滚段要足够大.想删除表,当然用 drop;
`想保留表而将所有数据删除，如果和事务无关，用truncate即可。如果和事务有关,或者想触发trigger,还是用delete。`
如果是整理表内部的碎片，可以用truncate跟上reuse stroage，再重新导入/插入数据。

#### 语法
```SQL
Delete from Tablename where 条件
Truncate table Tablename
Drop table Tablename
```


#### Mysql的truncate和delete的区别
truncate table table_name 和delete from table_name 都是删除表中所有记录。

区别：

truncate能够快速清空一个表。并且重置auto_increment的值。而delete只能一行一行的删除。

但对于不同的类型存储引擎需要注意的地方是：

A. 对于myisam

>truncate会重置auto_increment的值为1。而delete后表仍然保持auto_increment。

B. 对于innodb

>truncate会重置auto_increment的值为1。delete后表仍然保持auto_increment。但是在做delete整个表之后重启MySQL的话，则`重启后`的auto_increment会被置为1。

也就是说，innodb的表本身是无法持久保存auto_increment。delete表之后auto_increment仍然保存在内存，但是重启后就丢失了，只能从1开始。实质上`重启`后的auto_increment会从 SELECT 1+MAX(ai_col) FROM t 开始。

-----------
