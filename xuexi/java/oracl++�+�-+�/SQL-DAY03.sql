可以对字段加别名，当SELECT子句
中出现了函数或者表达式时，结果集中
就会用这个函数或表达式做为字段名，
可读性差，这时我们通常会给该字段加别名（AS加名字，AS可以省略）
SELECT ename,sal*12 as sal
FROM EMP_LEE
若希望别名区分大小写或者包含空格，那么可以使用双引号将别名括起来。
SELECT ename,sal*12 as "s al "
FROM emp_lee
查看20号部门的员工信息
SELECT *
FROM EMP_LEE
WHERE DEPTNO=20;
查看职位是CLERK的员工信息
SELECT * FROM EMP_LEE
WHERE JOB='CLERK'
SELECT *FROM EMP_LEE
WHERE SAL<2000;
SELECT *FROM EMP_LEE
WHERE DEPTNO<>10//不等于

SELECT *FROM EMP_LEE
WHERE hiredate> TO_DATE('1987年1月1日','YYYY"年"MM"月"DD"日"');


SELECT *FROM EMP_LEE
WHERE SAL>1000 and job='CLERK';
SELECT *FROM EMP_LEE
WHERE SAL>1000 OR JOB='CLERK'
and 优先级高于 or ,可以通过使用括号来提高or的优先级
SELECT *FROM EMP_LEE
WHERE SAL>1000 AND (JOB='SALESMAN' OR JOB='CLERK')

LIKE用于模糊匹配字符串
支持两个通配符：
_:表示单一的一个字符
%：表示任意个字符（0到多个）
查看名字第二个字母是A的员工信息？
SELECT *FROM EMP_LEE
WHERE ename LIKE '_A%';

SELECT *FROM EMP_LEE
WHERE ENAME LIKE '_L_E%'
SELECT *FROM EMP_LEE
WHERE ENAME LIkE '%N'
SELECT *FROM EMP_LEE
WHERE ENAME LIkE '%E_'

IN(list),NOT IN(list)
判断是否在列表中或不在列表中
常在子查询中使用
查看职位是CLERK或SALESMAN的员工信息？
SELECT *FROM EMP_LEE
WHERE JOB IN('CLERK','SALESMAN')
SELECT *FROM EMP_LEE
WHERE JOB NOT IN('CLERK','SALESMAN')

BETWEEN..AND..
判断在一个范围内
查看员工工资在1500到3000之间的
SELECT *FROM EMP_LEE
WHERE SAL BETWEEN 1500 AND 3000;

ANY,ALL
结合：>,>=,<,<=一个列表使用。
>ALL(list):大于列表中最大的（大于所有）
>ANY(list):大于列表中最小的（大于其中之一）
后面的列表中几乎不会使用确定值，常用于判断子查询的结果。
下面是SQL仅用于演示语法，实际开发不会这么用
SELECT *FROM EMP_LEE
WHERE SAL>ALL(3000，4000，4500)
SELECT *FROM EMP_LEE
WHERE SAL>=ANY(3000，4000，4500)
SELECT *FROM EMP_LEE
WHERE SAL<ANY(3000，4000，4500)

过滤条件中也可以使用函数或表达式
SELECT *FROM EMP_LEE
WHERE ENAME=UPPER('allen');

SELECT *FROM EMP_LEE
WHERE SAL*12>50000;

SELECT *FROM EMP_LEE
WHERE COMM IS NOT NULL AND SAL>1300 AND JOB='SALESMAN' 

SELECT *FROM EMP_LEE
WHERE SAL*12>30000 AND HIREDATE>TO_DATE('1981-1-1','YYYY-MM-DD')

DISTINCT用于去除结果集中指定字段的重复值。
查看公司共有多少职位？
SELECT DISTINCT JOB
FROM EMP_LEE

SELECT DISTINCT DEPTNO
FROM EMP_LEE
SELECT ENAME,JOB
FROM EMP_LEE
DISTINCT 必须紧跟在SELECT 关键字之后，
DISTINCT 可以对多列去重，去重原则是这些列的组合没有重复值。
SELECT DISTINCT JOB,DEPTNO
FROM EMP_LEE


ORDER BY 子句
排序结果集，可以按照指定的字段进行
升序或降序排列。
ASC 升序，可以不写，默认是升序
DESC 降序。
需要注意 ORDER BY 只能定义在 SELECT 语句的最后一个子句上。
查看公司工资排名
SELECT ENAME,SAL
FROM EMP_LEE
ORDER BY SAL DESC;

ORDER BY 可以对多列进行排序
排序具有优先级，先按照第一个字段的排序方式排序结果集，当
第一个字段有重复值时，再按照第二个字段的排序方式继续排序，以此类推
SELECT ENAME,SAL,DEPTNO FROM EMP_LEE
ORDER BY DEPTNO DESC ,SAL DESC
若排序的字段含有NULL值，NULL被视作最大值
SELECT ename,comm
FROM EMP_LEE
ORDER BY COMM DESC

聚合函数，又称为多行函数
聚合函数是用来统计结果的。

MAX,MIN
统计最大值与最小值
查看公司的最高与最低工资？
SELECT MAX(SAL),MIN(SAL)
FROM EMP_LEE

AVG,SUM
统计平均值与总和
查看公司平均工资以及工资总和？
SELECT ROUND(AVG(SAL)),SUM(SAL)
FROM EMP_LEE

COUNT
统计的是记录的条数，而不关注具体该字段的取值
查看公司员工数人数？
SELECT COUNT(ENAME)
FROM EMP_LEE

聚合函数是忽略NULL
SELECT COUNT(COMM)
FROM EMP_LEE

SELECT AVG(NVL(COMM,0)),SUM(COMM)
FROM EMP_LEE

统计表中记录数，常使用COUNT(*)
SELECT COUNT(*)
FROM EMP_LEE

GROUP BY子句
GROUP BY 子句允许将结果集
按照给定的字段值相同的记录看做一组，然后配合聚合函数
对每组记录进行统计
查看每个部门的最高工资
SELECT MAX(sal),deptno
FROM emp_lee
GROUP BY DEPTNO
当SELECT 含有聚合函数时，凡不在聚合函数中的单独字段都必须
出现在GROUP BY 子句中
每个职位的平均工资和工资总和
SELECT AVG(SAL),SUM(SAL),JOB
FROM EMP_LEE
GROUP BY JOB
每个部门有多少人
SELECT COUNT(DEPTNO)，DEPTNO
FROM EMP_LEE
GROUP BY DEPTNO
查看每个部门的平均工资，前提是该部门的平均工资高于2000
SELECT AVG(SAL),DEPTNO
FROM EMP_LEE
WHERE AVG(SAL)>2000--WHERE 中不允许出现聚合函数
GROUP BY DEPTNO
WHERE 中不允许出现聚合函数做为过滤
条件，原因在于过滤机制不同。
WHERE的过滤时机是在第一次从表中检索数据时添加过滤条件，
用来确定哪些数据可以被查询出来，以确定结果集。

HAVING子句：HAVING必须跟在GROUP BY子句之后，
可以使用聚合函数作为过滤条件。使之可以对分组进行过滤，将满足条件的分组
保留，不满足的去掉。
SELECT AVG(SAL),DEPTNO
FROM EMP_LEE
GROUP BY DEPTNO
HAVING AVG(SAL)>2000
查看平均工资高于2000的部门的最高工资和最低工资
SELECT MAX(SAL),MIN(SAL)
FROM EMP_LEE
GROUP BY DEPTNO
HAVING AVG(SAL)>2000--HAVING 是过滤分组的 先过滤分组后SELECT查找需要条件

关联查询
查询的结果集中字段来自多张表。
联合多张表查询数据就是关联查询。
在关联查询中需要在过滤条件中添加两张表中记录之间对应
关系，这样的条件称为连接条件。
N张表联合查询至少要有N-1个连接条件，不添加连接条件
会产生笛卡尔积，除特殊情况下，该结果集通常是无意义的，并且由于数据量大，
对系统资源消耗有巨大影响。


查看每个员工的名字以及所在部门的名字？
SELECT ename,dname
from emp_lee,dept
where emp_lee.deptno=dept.deptno --关联条件必须写

在关联查询中的过滤条件应当与连接条件同时成立。
查看SALES部门的员工信息？
SELECT ename,dname
FROM emp_lee,dept
where emp_lee.deptno=dept.deptno
and dept.dname='SALES'

当查询过程中，出现字段在两张表中都有的情况，必须明确该字段属于那张表
SELECT E.ENAME,E.DEPTNO,D.DNAME
FROM EMP_LEE E,DEPT D --可以重新定义表名达到简写
WHERE E.DEPTNO=D.DEPTNO

SELECT E.ENAME,D.DNAME
FROM EMP_LEE E,DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND E.ENAME='SMITH'

SELECT *FROM DEPT

SELECT E.ENAME,D.LOC,D.DNAME
FROM EMP_LEE E,DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND D.LOC='NEW YORK'
查看平均工资高于2000的部门所在地？
SELECT D.LOC,AVG(E.SAL),D.DNAME
FROM EMP_LEE E,DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY D.LOC,D.DNAME
HAVING AVG(E.SAL)>2000

内连接
关联查询的另一种写法
查看SALES部门的员工信息
SELECT e.ename,d.dname
FROM emp_lee e JOIN dept d
ON e.deptno=d.deptno
where d.dname='SALES'

外连接
外链接在进行关联查询时可以将不满足连接条件的
记录也查询出来。
外链接分为：左外连接，右外连接，全外链接

左外连接：以join左侧表作驱动表，该表中所有记录全部会列出来
那么当某条记录不满足连接条件时，该记录中来自右侧表中字段的值为NULL

SELECT E.ENAME ,D.DNAME 
FROM EMP_LEE E LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO

SELECT E.ENAME ,D.DNAME 
FROM EMP_LEE E RIGHT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO

SELECT E.ENAME ,D.DNAME
FROM EMP_LEE E FULL OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO

SELECT E.ENAME ,D.DNAME
FROM EMP_LEE E,DEPT D
WHERE E.DEPTNO=D.DEPTNO(+)



自连接
自连接指的是自己表中的记录对应自己
表的多条记录。建立的关联查询就是自连接。
自连接设计用于解决数据相同，但是存在上下级关系的树状结构使用。

查看每个员工以及其上司的名字
SELECT E.ENAME,D.ENAME
FROM EMP_LEE E,EMP_LEE D
WHERE E.MGR=D.EMPNO(+)

SELECT E.ENAME,D.ENAME
FROM EMP_LEE E,EMP_LEE D
WHERE E.MGR=D.EMPNO(+)
AND D.ENAME='JONES'

SELECT COUNT(E.ENAME),D.ENAME
FROM EMP_LEE E,EMP_LEE D
WHERE E.MGR=D.EMPNO
GROUP BY D.ENAME

查看JONES的上司在哪个城市工作？
SELECT D.LOC ,M.ENAME
FROM EMP_LEE E,EMP_LEE M,DEPT D
WHERE E.MGR=M.EMPNO
AND  M.DEPTNO=D.DEPTNO
AND  E.ENAME='JONES' 

SELECT D.LOC ,M.ENAME
FROM EMP_LEE E JOIN EMP_LEE M 
ON E.MGR=M.EMPNO 
JOIN DEPT D ON M.DEPTNO=D.DEPTNO
WHERE E.ENAME='JONES'








