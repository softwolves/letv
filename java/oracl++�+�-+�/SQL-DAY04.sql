子查询
子查询是一条查询语句，其嵌套在其他SQL语句中，作用是为外层的SQL语句提供
数据
和JAMES相同部门的员工号？
SELECT ENAME,deptno
FROM EMP_LEE
WHERE  deptno=(SELECT DEPTNO
               FROM EMP_LEE
               WHERE ENAME='JAMES'            
              )
RENAME EMP_LEE TO EMP;
SELECT *FROM EMP
COMMIT

子查询除了常用语句DQL之外，也可以在DDL于DML中使用。
在DDL中应用：
使用子查询的结果快速创建一张表。
CREATE TABLE MYEMPLOYEE
AS
SELECT  
 E.EMPNO,E.ENAME,E.JOB,E.SAL,
 E.DEPTNO,D.DNAME,D.LOC
FROM 
  EMP_LEE E,DEPT D
WHERE 
  E.DEPTNO=D.DEPTNO
  
DESC myemployee
SELECT *FROM MYEMPLOYEE

DML 中使用子查询
删除和JAMES 相同部门的所有员工
DELETE FROM EMP
WHERE
    deptno=(SELECT DEPTNO
            FROM EMP
            WHERE ENAME='JAMES'
    ) 
    
SELECT *FROM EMP

把SMITH所在部门的员工提高10%
UPDATE EMP
SET SAL=SAL*(1+0.1)
WHERE 
      DEPTNO=(SELECT DEPTNO
              FROM EMP
              WHERE ENAME='SMITH'
      )
SELECT *FROM dept

子查询根据查询结果集不同通常分为：
单行单列：常用在WHERE中（配合=,>,>=等）
多行单列：常用在WHERE中（配合IN，ANY,ALL）
多行多列：常用在FROM 中作为表看待

查看比CLERK和SALESMAN工资都高的员工？
SELECT ename,sal
FROM EMP
WHERE SAL>ALL(
              SELECT SAL
              FROM EMP
              WHERE JOB='CLERK' 
              OR JOB='SALESMAN')

查看和CLERK相同部门的其他职位的员工？
SELECT ENAME,JOB,DEPTNO
FROM EMP
WHERE  DEPTNO IN(SELECT DEPTNO
                  FROM EMP 
                  WHERE  JOB='CLERK')
AND JOB<>'CLERK'      
      

EXISTS关键字
用在WHERE中，其后要跟一个子查询，
作用是若子查询至少可以查询出一条记录，
那么EXISTS表达式返回真。
NOT EXISTS 则起到相反的作用。查询不到数据则返回真。

查看有员工的部门信息？
SELECT d.deptno,d.dname,d.loc
FROM dept d
WHERE  EXISTS(
      SELECT *FROM EMP E
      WHERE E.DEPTNO=D.DEPTNO
)
查询没有下级的员工 SELECT *FROM EMP
SELECT M.ENAME
FROM EMP M
WHERE NOT EXISTS(
      SELECT *FROM EMP E 
      WHERE M.EMPNO=E.MGR
)

查询列出最低薪水高于部门30的最低薪水的部门的最低薪水
SELECT MIN(SAL),DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING MIN(SAL)>
      (
      SELECT MIN(SAL)
      FROM EMP
      WHERE DEPTNO=30)

查询高于自己所在部门平均工资的员工信息？
SELECT E.ENAME,E.DEPTNO,E.SAL,E.JOB
FROM EMP E,
     ( SELECT AVG(SAL) AVG_SAL,DEPTNO
        FROM EMP
        GROUP BY DEPTNO) T
WHERE E.DEPTNO=T.DEPTNO
AND E.SAL>T.AVG_SAL

在SELECT语句中使用子查询
通常是外连接
SELECT 
  E.ENAME,E.SAL,
  (SELECT D.DNAME FROM DEPT D
  WHERE D.DEPTNO=E.DEPTNO) DNAME
FROM EMP E;

分页查询
通常通过一个查询语句查询的数据量过大时，都
会使用分页机制。分页就是讲数据分批查询出来。
一次查询部分内容。
这样的好处可以减少系统响应时间，减少系统资源开销。
分页由于在标准SQL中没有定义，所以不同的数据库语法不相同（方言）

ORACLE中使用ROWNUM这个伪列来实现分页。
ROWNUM，该列不存在与数据库任何表中，但是
任何表都可以查询该列，该列在结果集中的值是每条记录的行号，
行号从1开始。
编号是在查询过程中进行的，只要可以从表中查询出一条数据，那么该条记录的
ROWNUM字段值即为这条记录的行号。
SELECT ROWNUM,ename,job,sal,deptno
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10
在使用ROWNUM对结果集编号的查询过程中
不要使用ROWNUM做>1以上数字的判断，否则查询不到任何数据。--因为ROWNUM是在查询中编号的,小于不影响

SELECT *
FROM (
      SELECT  ROWNUM RN,ENAME,JOB
      SAL,DEPTNO
      FROM EMP
)
WHERE RN BETWEEN 6 AND 10



若对查询内容有排序需求时，要先进行排序操作。
取公司工资排名的6-10
SELECT *
FROM (
      SELECT ROWNUM RN,T.*
      FROM (SELECT  ENAME,SAL,JOB
            FROM EMP
            ORDER BY SAL DESC)T )

WHERE RN BETWEEN 6 AND 10


SELECT *
FROM (  
      SELECT ROWNUM RN,T.*
      FROM(
          SELECT ENAME,SAL,JOB
          FROM EMP
          ORDER BY SAL DESC) T
      WHERE ROWNUM<=10)
WHERE RN>5

换算范围值
PageSize:每页显示的条数
Page：页数
start=(Page-1)*PageSize+1
end =PageSize*Page


SELECT ENAME,JOB,SAL,
        DECODE(JOB,
                'MANAGER',SAL*1.2,
                'ANALYST',SAL*1.1,
                'SALESMAN',sal*1.05,
                sal
        ) bonus
from emp
                
SELECT ename,job,sal,
      CASE job WHEN 'MANAGER' THEN SAL*1.2
               WHEN 'ANALYST' THEN SAL*1.1
               WHEN 'SALESMAN'THEN SAL*1.05
               ELSE SAL END
      bonus
FROM emp;


统计人数，将职位是‘ANALYST’和

SELECT COUNT(*),
        DECODE(
              JOB,
              'ANALYST','VIP',
              'MANAGER','VIP',
              'OTHER'
        ) 
FROM EMP
GROUP BY DECODE(
              JOB,
              'ANALYST','VIP',
              'MANAGER','VIP',
              'OTHER'
        )
SELECT DEPTNO,DNAME,LOC
FROM DEPT
ORDER BY
  DECODE(
        DNAME,
        'OPERATIONS',1,
        'ACCOUNTING',2,
        'SALES',3)
排序函数
排序函数可以将结果集按照指定的字段分组，然后
在组内按照指定的字段排序，并为组内每条记录生成一个编号。
ROW_NUMBER:组内连续且唯一的数字

公司每个部门的公资排名：
SELECT 
  ENAME,SAL,DEPTNO,
  ROW_NUMBER() OVER(
   PARTITION BY DEPTNO
   ORDER BY SAL DESC
   )RANK
FROM EMP

SELECT 
  ENAME,SAL,DEPTNO,JOB,
  ROW_NUMBER() OVER(
   PARTITION BY JOB
   ORDER BY SAL DESC
   )RANK
FROM EMP

RANK：生成组内不连续排序

SELECT ENAME,SAL,DEPTNO,
 RANK() OVER(
   PARTITION BY DEPTNO
   ORDER BY SAL DESC
   ) RANK
FROM EMP

DENSE_RANK: 生成组内部连续

SELECT 
 ENAME,SAL,DEPTNO,
 DENSE_RANK() OVER(
   PARTITION BY DEPTNO
   ORDER BY SAL DESC
   ) RANK
FROM EMP


CREATE TABLE sales_tab(
   year_id NUMBER NOT NULL,
   month_id NUMBER NOT NULL,
   day_id NUMBER NOT NULL,
   sales_value NUMBER(10,2) NOT NULL);
   
INSERT INTO sales_tab
SELECT TRUNC(DBMS_RANDOM.value(2010,2012))AS year_id,
       TRUNC(DBMS_RANDOM.value(1,13))AS month_id,
       TRUNC(DBMS_RANDOM.value(1,32))AS day_id,
       TRUNC(DBMS_RANDOM.value(1,100),2)AS sales_value
FROM dual
CONNECT BY level<=1000;
commit
select * from sales_tab

SELECT ename ,job,sal FROM emp
WHERE job='MANAGER'
UNION
SELECT EName,JOB,SAL FROM EMP
WHERE SAL>2500;


SELECT ename,JOB,SAL FROM EMP
WHERE JOB='MANAGER'
UNION ALL
SELECT ENAME,JOB,SAL FROM EMP
WHERE SAL>2500;
 
SELECT ENAME,JOB,SAL FROM EMP
WHERE JOB='MANAGER'
INTERSECT
SELECT ENAME,JOB,SAL FROM EMP
WHERE SAL>2500

SELECT ENAME,JOB,SAL FROM EMP
WHERE JOB='MANAGER'
MINUS
SELECT ENAME,JOB,SAL FROM EMP
WHERE SAL>=2500

高级分组函数
ROLLUP函数
ROLLUP 分组次数有指定的参数决定，次数
为参数个数+1次，而且分组原则是每个参数递减的形式，然后
将这些分组的结果并在一个结果集中显示。
GROUP BY ROLLUP(a，b,c ,...)
查看每天，每月，每年，和总营业额？
SELECT year_id,month_id,day_id,
       SUM (sales_value)
FROM sales_tab
GROUP BY
   ROLLUP(year_id,month_id,day_id)

CUBE函数
CUBE分组次数是2的参数个数次方
会将每种组合进行一次分组并将所有结果并在一个结果集中显示。
SELECT year_id,month_id,day_id,
        sum(sales_value)
from sales_tab
GROUP BY CUBE(year_id,month_id,day_id)

只查看每天与每月营业额？
GROUPING SETS()
该分组函数允许按照指定的分组方式进行分组，然后
将这些分组统计的结果并在一个结果集中显示
函数的每一个参数，就是一种分组方式。
SELECT year_id,month_id,day_id,
        SUM(sales_value)
FROM sales_tab
GROUP BY 
    GROUPING SETS(
    (year_id,month_id,day_id),
    (year_id,month_id)
)







        










