SELECT SYSDATE FROM dual

创建表
CREATE TABLE employee_xxx(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

查看表结构
DESC employee


设置默认值
在数据库中，无论字段是什么类型，默认
值都是NULL，但是可以在创建表的时候通
过DEFAULT关键字为指定的列单独设置默认
值。
在数据库中，字符串使用单引号表示字面量，
这一点与java不一致，需要注意!

删除表
DROP TABLE employee_xxx

NOT NULL约束
NOT NULL约束可以确保指定的字段不
允许为NULL。
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20) NOT NULL,
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

修改表
1:修改表名
RENAME employee TO myemp

DESC myemp

2:修改表结构
2.1:添加新字段

向表中添加新的字段，只能在当前表的
末尾追加。可以同时追加多个列，只需要
使用逗号隔开即可，与创建表声明列时候
的语法一致。
ALTER TABLE myemp ADD(
  hiredate DATE DEFAULT SYSDATE
)

DESC myemp

2.2:删除表中现有字段
删除myemp表中的hiredate字段
ALTER TABLE myemp DROP(hiredate)

2.3:修改表中现有字段
可以修改字段的类型，长度，默认值，非空
ALTER TABLE myemp MODIFY(
  job VARCHAR2(40) DEFAULT 'CLERK'
)

DESC myemp

DML语句
用于修改表中数据，分为:增，删，改

1:插入数据
INSERT INTO myemp
(id,name,job,salary)
VALUES
(1,'jack','CLERK',5000)


SELECT * FROM myemp


插入日期类型，建议使用TO_DATE函数。
可以使用字符串，但是格式必须是
'DD-MON-RR'由于有语言差异，不推荐。
INSERT INTO myemp
(id,name,job,birth)
VALUES
(2,'rose','CLERK',
 TO_DATE('1992-08-02','YYYY-MM-DD')
)

2:修改表中现有数据
将jack的工资改为5500

UPDATE myemp
SET salary=6000,job='MANAGER'
WHERE name='jack'

修改表中数据的时候，通常要使用
WHERE限定条件，这样只会将满足
条件的记录进行修改，若不指定WHERE
则是全表所有数据都修改!

3:删除表中数据
将rose删除
DELETE FROM myemp
WHERE name='rose'

删除表中数据同样要使用WHERE添加
过滤条件，否则就是清空表操作。



SELECT * FROM myemp


