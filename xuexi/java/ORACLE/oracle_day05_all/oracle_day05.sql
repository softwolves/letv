视图:
数据库对象之一
在SQL语句中体现的角色与表相同。
但视图并不是一张真实存在的表，它只是
对应了一条SELECT语句查询的结果集。
使用视图可以重用子查询，并且简化SQL
语句的复杂度。

创建包含10号部门员工信息的视图
CREATE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10

SELECT * FROM v_emp_10

DESC v_emp_10


视图对应的子查询字段可以使用别名，
那么该视图对应的字段名就是这个别名了，
若字段含有函数或表达式，必须指定别名。

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10

对视图进行DML操作
对视图进行DML操作就是对视图数据
来源的基础表进行的。
只能对简单视图进行DML操作，复杂视图
不允许使用DML操作。
对简单视图进行DML操作时，也不能违背
基表的约束条件。

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',5000,10)

SELECT * FROM v_emp_10
SELECT * FROM emp

当通过视图插入一条视图本身不可见的
数据时，就是对基表的污染。
插入会造成污染，修改也会造成。但是
删除不会造成。
INSERT INTO v_emp_10
VALUES
(1001,'JACK',5000,20)

UPDATE v_emp_10
SET deptno=20

DELETE FROM v_emp_10
WHERE deptno=20

对视图添加检查选项
WITH CHECK OPTION
当视图添加了检查选项后，那么对视图
进行插入或修改操作时，视图要求:
插入时:插入的数据视图必须对其可见
修改时:修改后视图必须对数据可见
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION

为视图添加只读选项
WITH READ ONLY
当一个视图添加了只读选项后，
该视图不允许进行DML操作。
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY

SELECT object_name 
FROM user_objects 
WHERE object_type = 'VIEW';

SELECT text FROM user_views

SELECT table_name FROM user_tables

复杂视图
查询语句含有函数，表达式，分组，去重
多表关联查询。
复杂视图不能进行DML。

创建一个各部门工资情况的视图。
视图包含的字段:
部门的编号，名字，该部门的最小工资，
最高工资，平均工资和工资总和
CREATE VIEW v_dept_sal
AS
SELECT d.deptno,d.dname,
       MAX(e.sal) max_sal,
       MIN(e.sal) min_sal,
       AVG(e.sal) avg_sal,
       SUM(e.sal) sum_sal
FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY d.deptno,d.dname

查看谁比自己所在部门平均工资高?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

删除视图
DROP VIEW v_emp_10

删除视图中的数据会对应的将基表数据删除，
但是删除视图本身并不会对基表数据产生任何
的影响。



序列
序列也是数据库对象之一
序列是用来生成一系列数字的。
序列通常为表的主键提供值使用。

CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

序列支持两个伪列
NEXTVAL:使序列生成下一个数字(用最
后生成的数字加上步长得到)，新创建的
序列则返回START WITH指定的数字。
序列是不能回退的，所以通过NEXTVAL
获取了下一个数字后就无法再获取之前生
成的数字了。
CURRVAL:获取序列生成的最后一个数字，
无论调用多少次都不会导致序列生成新的
数字，但是新创建的序列至少调用一次
NEXTVAL后才可以开始使用CURRVAL。

SELECT seq_emp_id.NEXTVAL
FROM dual

SELECT seq_emp_id.CURRVAL
FROM dual

使用seq_emp_id为emp表的主键
生成值
INSERT INTO emp
(empno,ename,job,sal,deptno)
VALUES
(seq_emp_id.NEXTVAL,'JACK',
 'CLERK',5000,10)
SELECT * FROM emp

删除序列
DROP SEQUENCE seq_emp_id

UUID
字符串类型的主键值，32位不重复字符串
ORACLE提供了一个函数可以生成UUID。
SELECT sys_guid() FROM dual

SELECT * FROM emp
WHERE ename='SCOTT'



约束

唯一性约束
当某个字段使用了唯一性约束后，该字段
的值在表中是不允许有重复值的，但是NULL
除外。

CREATE TABLE employees1 (
  eid NUMBER(6) UNIQUE,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE,
  CONSTRAINT employees_email_uk 
  UNIQUE(email)
);

INSERT INTO employees1
(eid,name,email)
VALUES
(NULL,'JACK',NULL)

SELECT * FROM employees1









主键约束
非空且为一
CREATE TABLE employees2 (
  eid NUMBER(6) PRIMARY KEY,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE
);
INSERT INTO employees2
(eid,name)
VALUES
(NULL,'JACK')

SELECT * FROM employees2













