可以对字段加别名，当SELECT子句
中出现了函数或者表达式时，结果集中
就会用这个函数或表达式作为字段名，
可读性差，这时我们通常会给该字段加
别名。若希望别名区分大小写或者包含
空格，那么可以使用双引号将别名括起来。
SELECT ename,sal*12 sal
FROM emp

查看20号部门的员工信息
SELECT * FROM emp
WHERE deptno=20

查看职位是CLERK的员工信息
SELECT * FROM emp
WHERE job='CLERK'


工资高于1000，并且职位是CLERK
或SALESMAN的员工信息?
SELECT ename,job,sal
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

AND的优先级高于OR，可以通过
使用括号来提高OR的优先级。

LIKE用于模糊匹配字符串
支持两个通配符:
_:表示单一的一个字符
%:表示任意个字符(0-多个)

查看名字第二个字母是A的员工信息?
SELECT ename,job,sal
FROM emp
WHERE ename LIKE '_A%'


IN(list),NOT IN(list)
判断是否在列表中或不在列表中
常在子查询中使用

查看职位是CLERK或SALESMAN的员工信息?
SELECT ename,sal,job
FROM emp
WHERE job NOT IN('CLERK','SALESMAN')


BETWEEN..AND..
判断在一个范围内
查看工资在1500到3000之间的员工
SELECT ename, sal FROM emp  
WHERE sal BETWEEN 1500 AND 3000;


ANY,ALL
结合:>,>=,<,<=一个列表使用。
>ALL(list):大于列表中最大的(大于所有)
>ANY(list):大于列表中最小的(大于其中之一)
后面的列表中几乎不会使用确定值，常用于判断
子查询的结果。
下面的SQL仅用于演示语法，实际开发不会这样写。
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE sal > ANY (3500,4000,4500);

过滤条件中也可以使用函数或表达式
SELECT ename, sal, job 
FROM emp 
WHERE ename = UPPER('allen');

SELECT ename, sal, job 
FROM emp 
WHERE sal * 12 > 50000;

SELECT * FROM emp

SELECT *
FROM emp
WHERE hiredate>TO_DATE('1981-01-01','YYYY-MM-DD')
AND sal*12>30000

DISTINCT用于去除结果集中指定字段的
重复值。
查看公司共有多少种职位？
SELECT DISTINCT job
FROM emp

DISTINCT必须紧跟在SELECT关键字之后，
DISTINCT可以对多列去重,去重原则是这些
列的组合没有重复值。
SELECT DISTINCT job,deptno
FROM emp

ORDER BY子句
排序结果集，可以按照指定的字段进行
升序或者降序排列。
ASC:升序，可以不写，默认就是升序
DESC:降序。
需要注意!ORDER BY只能定义在SELECT语句
的最后一个子句上。
查看公司工资排名
SELECT ename,sal
FROM emp
ORDER BY sal DESC

ORDER BY可以对多列进行排序
排序具有优先级，先按照第一个字段的排序
方式排序结果集，当第一个字段有重复值时
再按照第二个字段的排序方式继续排序，以此类推.
SELECT ename,sal,deptno
FROM emp
ORDER BY deptno DESC,sal DESC

若排序的字段含有NULL值，
NULL被视作最大值。
SELECT ename,comm
FROM emp
ORDER BY comm DESC

聚合函数，又称为多行函数
聚合函数是用来统计结果的。

MAX,MIN
统计最大值与最小值
查看公司的最高与最低工资?
SELECT MAX(sal),MIN(sal)
FROM emp

AVG,SUM
统计平均值与总和
查看公司平均工资以及工资总和?
SELECT AVG(sal),SUM(sal)
FROM emp

COUNT
统计的是记录的条数，而不关注具体
该字段的取值
查看公司员工人数?
SELECT COUNT(ename)
FROM emp

聚合函数忽略NULL值。
SELECT COUNT(comm)
FROM emp

SELECT AVG(NVL(comm,0)),SUM(comm)
FROM emp

统计表中记录数，常使用COUNT(*)
SELECT COUNT(*)
FROM emp


GROUP BY子句
GROUP BY子句允许将结果集按照给定的
字段值相同的记录看做一组，然后配合聚合
函数对每组记录进行统计。
查看每个部门的最高工资?
SELECT MAX(sal),deptno
FROM emp
GROUP BY deptno

当SELECT中含有聚合函数时，凡不在聚合函数
中的单独字段都必须出现在GROUP BY子句中

查看每个职位的平均工资和工资总和？
SELECT AVG(sal),SUM(sal),job
FROM emp
GROUP BY job

查看每个部门各多少人?
SELECT COUNT(*),deptno
FROM emp
GROUP BY deptno

查看每个部门的平均工资，前提是该部门
平均工资高于2000
SELECT AVG(sal),deptno
FROM emp
WHERE AVG(sal)>2000
GROUP BY deptno

WHERE中不允许使用聚合函数作为过滤
条件，原因在于过滤时机不同。
WHERE的过滤时机是在第一次从表中检索
数据时添加过滤条件，用来确定哪些数据
可以被查询出来，以确定结果集。

HAVING子句:HAVING必须跟在GROUP BY
子句之后，可以使用聚合函数作为过滤条件。
使之可以对分组进行过滤，将满足条件的分组
保留，不满足的去掉。

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000

查看平均工资高于2000的部门的
最高工资和最低工资
SELECT MAX(sal),MIN(sal),deptno
FROM emp,dept
WHERE sal>1000
GROUP BY deptno
HAVING AVG(sal)>2000
ORDER BY deptno


SELECT COUNT(*),job,deptno
FROM emp
GROUP BY job,deptno

SELECT deptno,dname
FROM dept

关联查询
查询的结果集中字段来自多张表。
联合多张表查询数据就是关联查询。
在关联查询中需要在过滤条件中添加
两张表中记录之间的对应关系，这样的
条件称为连接条件。
N张表联合查询至少要有N-1个连接条件，
不添加连接条件会产生笛卡尔积，除特殊
情况下，该结果集通常是无意义的，并且
由于数据量大，对系统资源消耗有巨大影响。


查看每个员工的名字以及所在部门名字?
SELECT ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno

在关联查询中的过滤条件应当与连接条件
同时成立。
查看SALES部门的员工信息?
SELECT ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND dept.dname='SALES'

当查询过程中，出现字段在两张表中都有
的情况是，必须明确该字段属于那张表。
SELECT e.ename,e.deptno,
       d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno


SELECT d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND e.ename='SMITH'

SELECT e.ename,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.loc='NEW YORK'

查看平均工资高于2000的部门所在地?
SELECT AVG(e.sal),d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY d.dname,d.loc
HAVING AVG(e.sal)>2000

内连接
关联查询的另一种写法
查看SALES部门的员工信息
SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname='SALES'

外连接
外连接在进行关联查询时可以将不
满足连接条件的记录也查询出来。
外连接分为:左外连接，右外连接，全外连接

左外连接:以JOIN左侧表作为驱动表，该表
中所有记录全部会列出来，那么当某条记录
不满足连接条件时，该记录中来自右侧表中
字段的值为NULL

SELECT e.ename,d.dname
FROM emp e 
 LEFT |RIGHT |FULL OUTER JOIN 
 dept d
ON e.deptno=d.deptno

SELECT e.ename,d.dname
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno

自连接
自连接指的是自己表中的记录对应自己
表的多条记录。建立的关联查询就是
自连接。
自连接设计用于解决数据相同，但是存在
上下级关系的树状结构使用。

SELECT empno,ename,mgr
FROM emp

查看每个员工以及其上司的名字?
SELECT e.ename,m.ename
FROM emp e,emp m
WHERE e.mgr=m.empno
AND m.ename='JONES'

查看每个领导手下多少人?
SELECT COUNT(*),m.ename
FROM emp e,emp m
WHERE e.mgr=m.empno
GROUP BY m.ename

查看JONES的上司在哪个城市工作? 
SELECT d.loc
FROM emp e,emp m,dept d
WHERE e.mgr = m.empno
AND m.deptno=d.deptno
AND e.ename='JONES'

SELECT deptno,dname,loc
FROM dept




