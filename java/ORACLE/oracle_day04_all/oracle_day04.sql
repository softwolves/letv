子查询
子查询是一条查询语句，其嵌套在其他
SQL语句中，作用是为外层的SQL语句提
供数据的。

和JAMES相同部门的员工?
SELECT ename,deptno
FROM emp
WHERE 
  deptno=(SELECT deptno
          FROM emp
          WHERE ename='JAMES')

子查询除了常用语DQL之外，也可以在
DDL与DML中使用。

在DDL中应用:
使用子查询的结果快速创建一张表。
DROP TABLE myemployee
CREATE TABLE myemployee
AS
SELECT 
 e.empno,e.ename,e.job,e.sal*12 sal,
 e.deptno,d.dname,d.loc
FROM 
 emp e,dept d
WHERE
 e.deptno=d.deptno

DESC myemployee
SELECT sal FROM myemployee

若子查询中查询的内容是函数或表达式，那么
该字段必须给别名。

DML中使用子查询
删除和JAMES相同部门的所有员工
DELETE FROM emp
WHERE 
  deptno=(SELECT deptno
          FROM emp
          WHERE ename='JAMES')
SELECT * FROM emp

把SMITH所在部门所有员工工资提高10%
UPDATE emp
SET sal=sal*1.1
WHERE deptno=(SELECT deptno
              FROM emp
              WHERE ename='SMITH')

子查询根据查询结果集不同通常分为:
单行单列:常用在WHERE中(配合=,>,>=等等)
多行单列:常用在WHERE中(配合IN,ANY,ALL)
多行多列:常用在FROM中作为表看待

查看比CLERK和SALESMAN工资都高的员工?
SELECT ename,sal
FROM emp
WHERE 
 sal >ALL(SELECT sal
          FROM emp
          WHERE job='SALESMAN'
          OR job='CLERK')

查看和CLERK相同部门的其他职位员工?
SELECT ename,job,deptno
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE job='CLERK')
AND job <> 'CLERK'

EXISTS关键字
用在WHERE中，其后要跟一个子查询，
作用是若子查询至少可以查询出一条
记录，那么EXISTS表达式返回真。
NOT EXISTS则起到相反的作用。查
不到数据则返回真。

查看有员工的部门?
SELECT d.deptno,d.dname,d.loc
FROM dept d
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.deptno=d.deptno
)
没有下属的员工?
SELECT m.ename
FROM emp m
WHERE NOT EXISTS(
 SELECT * FROM emp e
 WHERE e.mgr = m.empno
)

查询列出最低薪水高于部门30的最
低薪水的部门信息？
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING 
  MIN(sal)>(SELECT MIN(sal)
            FROM emp
            WHERE deptno=30)

查看高于自己所在部门平均工资的员工信息?
SELECT e.ename,e.deptno,e.sal
FROM emp e,
     (SELECT AVG(sal) avg_sal,
             deptno
      FROM emp
      GROUP BY deptno) t
WHERE e.deptno=t.deptno
AND e.sal>t.avg_sal

在SELECT子句中使用子查询
通常是外连接的一种写法。
SELECT 
 e.ename, e.sal, 
 (SELECT d.dname FROM dept d 
  WHERE d.deptno = e.deptno) dname
FROM emp e;

分页查询
通常一个查询语句查询的数据量过大时，都
会使用分页机制。分页就是将数据分批查询
出来。一次只查询部分内容。
这样的好处可以减少系统响应时间，减少系统
资源开销。
分页由于在标准SQL中没有定义，所以不同的
数据库语法不相同(方言)

ORACLE中使用ROWNUM这个伪列来实现分页。
ROWNUM,该列不存在与数据库任何表中，但是
任何表都可以查询该列，该列在结果集中的值
是每条记录的行号，行号从1开始。
编号是在查询的过程中进行的，只要可以从表
中查询出一条数据，那么该条记录的ROWNUM
字段值即为这条记录的行号。

SELECT 
  ROWNUM,ename,job,
  sal,deptno
FROM emp

查询6到10条
SELECT 
  ROWNUM,ename,job,
  sal,deptno
FROM emp
WHERE ROWNUM BETWEEN 6 AND 10
在使用ROWNUM对结果集编号的查询过程
中不要使用ROWNUM做>1以上数字的判断，
否则查询不到任何数据。
SELECT *
FROM (SELECT 
         ROWNUM rn,ename,job,
         sal,deptno
      FROM emp)
WHERE rn BETWEEN 6 AND 10

若对查询内容有排序需求时，要先
进行排序操作。
取公司工资排名的6-10
SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT ename,sal,job
          FROM emp
          ORDER BY sal DESC) t)
WHERE rn BETWEEN 6 AND 10

SELECT *
FROM (SELECT ROWNUM rn,t.*
      FROM(SELECT ename,sal,job
           FROM emp
           ORDER BY sal DESC) t
      WHERE ROWNUM<=10)
WHERE rn>=5      

换算范围值
PageSize:每页显示的条数
Page:页数

start = (Page-1)*PageSize+1
end = PageSize*Page

int page=2; 
int pageSize=5;
int start = (Page-1)*PageSize+1;
int end = PageSize*Page;
String sql = "SELECT * "+
             "FROM (SELECT ROWNUM rn,t.* "+
             "FROM(SELECT ename,sal,job "+
             "FROM emp "+
             "ORDER BY sal DESC) t "+
             "WHERE ROWNUM<=" + end + ") "+
             "WHERE rn>="+start;

DECODE函数
可以实现分支效果

SELECT ename, job, sal,
     DECODE(job,  
            'MANAGER',sal*1.2,
            'ANALYST',sal*1.1,
            'SALESMAN',sal*1.05,
            sal
     ) bonus
FROM emp

统计人数，将职位是'ANALYST'和
'MANAGER'看做一组，其他职位看做
另一组分别统计两组人数
SELECT COUNT(*),job
FROM emp
GROUP BY job

SELECT COUNT(*),
       DECODE(job,
              'ANALYST','VIP',
              'MANAGER','VIP',
              'OTHER')
FROM emp              
GROUP BY DECODE(job,
              'ANALYST','VIP',
              'MANAGER','VIP',
              'OTHER')
SELECT deptno, dname, loc
FROM dept
ORDER BY 
 DECODE(dname,
       'OPERATIONS',1,
       'ACCOUNTING',2,
       'SALES',3)


排序函数
排序函数可以将结果集按照指定的
字段分组，然后在组内按照指定的
字段排序，并为组内每条记录生成
一个编号。
ROW_NUMBER:组内连续且唯一的数字

公司每个部门的工资排名:
SELECT 
 ename,sal,deptno,
 ROW_NUMBER() OVER(
   PARTITION BY deptno
   ORDER BY sal DESC
 ) rank
FROM 
 emp

RANK:生成组内不连续也不唯一的数字
SELECT 
 ename,sal,deptno,
 RANK() OVER(
   PARTITION BY deptno
   ORDER BY sal DESC
 ) rank
FROM 
 emp


DENSE_RANK:生成组内连续但不唯一的数字
SELECT 
 ename,sal,deptno,
 DENSE_RANK() OVER(
   PARTITION BY deptno
   ORDER BY sal DESC
 ) rank
FROM 
 emp

SELECT 
 year_id,month_id,day_id,
 sales_value
FROM 
 sales_tab
ORDER BY
 year_id,month_id,day_id

查看每天的营业额?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id

每月的营业额?
SELECT year_id,month_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

每年的营业额?
SELECT year_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

总营业额?
SELECT SUM(sales_value)
FROM sales_tab

SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
UNION ALL
SELECT year_id,month_id,NULL,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
UNION ALL
SELECT year_id,NULL,NULL,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id
UNION ALL
SELECT NULL,NULL,NULL,
       SUM(sales_value)
FROM sales_tab

高级分组函数
ROLLUP函数
ROLLUP分组次数有指定的参数决定，次数
为参数个数+1次，而且分组原则是每个参数
递减的形式，然后将这些分组的结果并在一个
结果集中显示。

GROUP BY ROLLUP(a,b,c,...)
例如:
GROUP BY ROLLUP(a,b,c)
等同于
GROUP BY a,b,c
UNION ALL
GROUP BY a,b
UNION ALL
GROUP BY a
UNION ALL
全表

查看每天，每月，每年，和总营业额?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 ROLLUP(year_id,month_id,day_id)



CUBE函数
CUBE分组次数是2的参数个数次方
会将每种组合进行一次分组并将所有
结果并在一个结果集中显示。

GROUP BY CUBE(a,b,c)
a,b,c
a,b
a,c
b,c
a
b
c
全表
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 CUBE(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id


只查看每天与每月营业额?
GROUPING SETS()
该分组函数允许按照指定的分组方式
进行分组，然后将这些分组统计的结果
并在一个结果集中显示
函数的每一个参数，就是一种分组方式。

SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 GROUPING SETS(
  (year_id,month_id,day_id),
  (year_id,month_id)
  )
ORDER BY year_id,month_id,day_id





