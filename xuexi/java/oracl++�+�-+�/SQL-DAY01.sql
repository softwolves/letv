创建表
CREATE TABLE employee_lee(
  id NUMBER(4),
  name VARCHAR2(20),
  gender CHAR(1),
  birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)

);
查看表结构
DESC employee_lee;
设置默认值
在数据库中，无论字段是什么类型，默认值都是null，但是可以在创建表的
时候通过DEFAULT关键字为指定的列单独设置默认值。
在数据库中，字符串使用单引号表示字面量，这一点和java不一样，需要注意！

删除表
DROP TABLE employee_lee;
DROP TABLE student;
CREATE TABLE employee_lee(
  id NUMBER(4),
  name VARCHAR2(20),
  gender CHAR(1) DEFAULT 'M',
  birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
);
DESC employee_lee;
DROP TABLE employee_lee;
CREATE TABLE employee_lee(
  id NUMBER(4),
  name VARCHAR2(20) NOT NULL,
  gender CHAR(1) DEFAULT 'M',
  birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
);
DESC employee_lee;
修改表
修改表名字
RENAME employee_lee to myemp_lee;
DESE employee_lee;
DESC employee_lee;
DESC myemp_lee;
2：修改表结构
2.1：添加新字段
向表中添加新的字段，只能在当前表的末尾追加。可以同时追加多个列，
只需要使用逗号隔开即可，与创建表声明列时候语法一致。
ALTER TABLE myemp_lee ADD(
  hiredate DATE DEFAULT SYSDATE
);
DESC myemp_lee
2.2删除表中现有字段
删除myemp表中的hiredate字段
ALTER TABLE myemp_lee DROP(
  hiredate
)
DESC myemp_lee;
2.3 修改表中现有字段
可以修改字段的类型，长度，默认值，非空
ALTER TABLE myemp_lee MODIFY(
  job VARCHAR2(40) DEFAULT 'CLERK'
) 
DESC myemp_lee;

DML 语句
用于修改表中数据，分为：增，删，改

INSERT INTO myemp_lee(id,name,job,salary)
VALUES(1,'jack','CLERK',5000)
COMMIT
SELECT * FROM myemp_lee

插入日期类型，建议使用TO-DATE函数。
可以使用字符串，但是格式必须是‘DD-MON-RR’由于语言差异，不推荐。
INSERT INTO myemp_lee(id,name,job,birth)
VALUES(2,'rose','CLERK',TO_DATE('1992-08-02','YY-MM-DD'))
COMMIT
2:修改表中的现有数据
将rose的工资改为5500
UPDATE myemp_lee 
SET salary=5555，job='MANAGER'
WHERE name='jack'
UPDATE myemp_lee
SET salary=6500
WHERE name='rose'
修改表中数据的时候，通常要使用WHERE限定条件，这样只会将满足条件的记录进行修改，若不指定
WHERE则是全表所有数据都修改！

3:删除表中数据
将rose删除
DELETE FROM myemp_lee
WHERE name='rose'
删除表中数据同样要使用WHERE添加过滤条件，否则就是清空表操作。
INSERT INTO myemp_lee(id,name)
VALUES(2,'TOM')
SELECT * FROM myemp_lee

CREATE TABLE emp_lee(
  empno NUMBER(4,0),
  ename VARCHAR2(10),
  job VARCHAR2(9),
  mgr NUMBER(4,0),
  hiredate DATE,
  sal NUMBER(7,2),
  comm NUMBER(7,2),
  deptno NUMBER(2,0)
);
DESC emp_lee
COMMIT
CREATE TABLE dept(
  deptno NUMBER(2,0),
  dname VARCHAR2(14),
  loc VARCHAR2(13)
)
COMMIT
DESC dept
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7369,'SMITH','CLERK',7902,TO_DATE('1980/12/17','YY/MM/DD'),800.00,20)
ALTER TABLE emp_lee MODIFY(
  comm NUMBER(7,2)  DEFAULT ' '
)

DESC dept
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(7499,'ALLEN','SALESMAN',7698,TO_DATE('1981/2/20','YY/MM/DD'),
1600.00,300,30)
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(7521,'WARD','SALESMAN',7698,TO_DATE('1981/2/22','YY/MM/DD'),
1250.00,500.00,30)
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7566,'JONES','MANAGER',7839,TO_DATE('1981/4/2','YY/MM/DD'),
2975.00,20)
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(7654,'MARTIN','SALESMAN',7698,TO_DATE('1981/9/28','YY/MM/DD'),
1250.00,1400.00,30)
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7698,'BLAKE','MAMAGER',7839,TO_DATE('1981/6/9','YY/MM/DD'),
2850.00,30)
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7782,'CLARK','MAMAGER',7839,TO_DATE('1981/6/9','YY/MM/DD'),
2450.00,10)
INSERT INTO emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7788,'SCOTT','ANALYST',7566,TO_DATE('1987/4/9','YY/MM/DD'),
3000.00,20)
INSERT INTO emp_lee(empno,ename,job,hiredate,sal,deptno)
VALUES(7839,'KING','PRESIDENT',TO_DATE('1981/11/17','YY/MM/DD'),
5000.00,10)
INSERT INTO  emp_lee(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(7844,'TURNER','SALESMAN',7698,TO_DATE('1981/9/8','YY/MM/DD'),
1500.00,0.00,30)
INSERT INTO  emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7876,'ADAMS','CLERK',7788,TO_DATE('1987/5/23','YY/MM/DD'),
1100.00,20)
INSERT INTO  emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7900,'JAMES','CLERK',7698,TO_DATE('1981/12/3','YY/MM/DD'),
950.00,30)
INSERT INTO  emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7902,'FORD','ANALYST',7566,TO_DATE('1981/12/3','YY/MM/DD'),
3000.00,20)
INSERT INTO  emp_lee(empno,ename,job,mgr,hiredate,sal,deptno)
VALUES(7934,'MILLER','CLERK',7782,TO_DATE('1982/1/23','YY/MM/DD'),
1300.00,10)
SELECT *FROM emp_lee
COMMIT
INSERT INTO dept(deptno,dname,loc)
VALUES(10,'ACCOUNTING','NEW YORK')

INSERT INTO dept(deptno,dname,loc)
VALUES(20,'RESEARCH','DALLAS')
INSERT INTO dept(deptno,dname,loc)
VALUES(30,'SALES','CHIGAGO')
INSERT INTO dept(deptno,dname,loc)
VALUES(40,'OPERATIONS','BOSTON')
commit
SELECT *FROM dept
SELECT *FROM emp_lee































