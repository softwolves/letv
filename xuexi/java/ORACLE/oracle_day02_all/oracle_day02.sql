SELECT语句
SELECT是用来查询数据的语句DQL

查询某张表中所有字段的所有记录:
SELECT * FROM emp

查看指定字段的值:
SELECT ename,sal,job,deptno
FROM emp

DQL必须包含的部分是SELECT子句
与FROM子句。
SELECT用来确定查询的字段，可以
使用的有:表的字段，函数，表达式
FROM子句用来确定查询的表。

SELECT中使用表达式:
查看每个员工的年薪:
SELECT ename,sal*12
FROM emp

字符串函数:
1:CONCAT(p1,p2)
连接字符串
SELECT CONCAT(ename,sal)
FROM emp

SELECT 
 CONCAT(CONCAT(ename,':'),sal)
FROM emp

连接字符串还有一种简便的方式:使用"||"
注意与java中区分。
SELECT ename||':'||sal
FROM emp


LENGTH(p)函数
获取字符长度
SELECT ename,LENGTH(ename)
FROM emp

UPPER,LOWER,INITCAP
将字符转换为全大写，全小写，首字母
大写。
dual:伪表，当查询的内容与任何一张表
中的数据无关时，可以查询伪表。
SELECT 
  UPPER('helloworld'),
  LOWER('HELLOWORLD'),
  INITCAP('HELLO WORLD')
FROM dual


TRIM,LTRIM,RTRIM
去除字符串两边的指定字符
SELECT 
  TRIM('e' FROM 'eeeliteee')
FROM dual

SELECT
  LTRIM('esesesliteseses','se')
FROM
  dual

LPAD,RPAD补位函数
要求显示指定内容指定位数，
若不足则补充若干指定字符以
达到要显示的长度。
SELECT ename,RPAD(sal,5,'$')
FROM emp

SUBSTR截取字符串
截取给定字符串，从指定位置
开始截取指定个字符。
在数据库中，下标都是从1开始的！！
SELECT 
 SUBSTR('thinking in java',-4,4)
FROM 
 dual 


INSTR(char1,char2[,n[,m]])
查找char2在char1中的位置
n为从指定位置开始查找，可以不写
m为第几次出现，可以不写。
n,m不写默认都是1
SELECT 
 INSTR('thinking in java','in',4,2)
FROM 
 dual

SELECT ename,sal,deptno
FROM emp
WHERE SUBSTR(ename,1,1)='A'

数字函数
1:ROUND(n[,m])
对n进行四舍五入，保留
到小数点后m位。
m可以不写，不写默认为0
m为0则保留到整数位，-1
位10位，以此类推。
SELECT ROUND(45.678, 2) FROM DUAL; 
SELECT ROUND(45.678, 0) FROM DUAL;
SELECT ROUND(45.678, -1) FROM DUAL;

TRUNC()函数，参数作用于ROUND
一致，只是不进行四舍五入，而是
直接截取
SELECT TRUNC(45.678, 2) FROM DUAL; 
SELECT TRUNC(45.678, 0) FROM DUAL;
SELECT TRUNC(45.678, -1) FROM DUAL;

MOD()函数是求余数
SELECT 
  ename, sal, MOD(sal, 1000) 
FROM emp; 


CEIL和FLOOR
向上取整与向下取整
SELECT CEIL(45.678) FROM DUAL 
SELECT FLOOR(45.678) FROM DUAL


日期类型
DATE:7个字节，保存世纪，年月日时分秒。
TIMESTAMP:时间戳，比DATE多4个字节，可以
保存秒以下的精度，前7个字节与DATE一致。

关键字:
SYSDATE:对应一个内置函数，返回一个表示
当前系统时间的DATE类型值
SYSTIMESTAMP:同样的，返回的是表示当前
系统时间的时间戳类型的值

SELECT SYSDATE FROM dual
DATE默认只显示"DD-MON-RR"

SELECT SYSTIMESTAMP FROM dual
时间戳显示内容较多。

TO_DATE函数
按照给定的日期格式将字符串解析为
DATE类型值。
SELECT 
 TO_DATE('1992-09-01 23:22:11',
         'YYYY-MM-DD HH24:MI:SS'
 )
FROM 
 dual

在日期格式字符串中，凡不是英文，符号和
数字的其他字符都需要使用双引号括起来
SELECT 
 TO_DATE(
  '1992年09月01日 23:22:11',
  'YYYY"年"MM"月"DD"日" HH24:MI:SS'
 )
FROM 
 dual

DATE是可以比较大小的，越晚的越大
查看82年以后入职的员工?
SELECT ename,hiredate
FROM emp
WHERE hiredate>TO_DATE(
                '1982-01-01',
                'YYYY-MM-DD')

DATE之间可以做减法，差为相差的天数
查看每个员工至今为止入职多少天了?
SELECT 
 ename,TRUNC(SYSDATE-hiredate)
FROM emp

SELECT 
 TRUNC(SYSDATE-TO_DATE('1992-01-01','YYYY-MM-DD'))
FROM 
 dual

DATE可以和一个数字进行加减运算，相当
与加减了指定的天数。返回值为对应的日期
7天后是哪天?
SELECT SYSDATE+7
FROM dual



TO_CHAR
常用于转换日期，可以将日期按照指定
的日期格式转换为字符串。
SELECT 
 TO_CHAR(SYSDATE,'YY-MM-DD HH24:MI:ss')
FROM 
 dual

SELECT 
 TO_CHAR(
  TO_DATE('03-09-01','RR-MM-DD'),
  'YYYY-MM-DD'
 )
FROM 
 dual


LAST_DAY(date)
该函数返回给定日期所在月的
最后一天
查看当月月底?
SELECT LAST_DAY(SYSDATE)
FROM dual

查看每个员工入职所在月的月底?
SELECT ename,LAST_DAY(hiredate)
FROM emp


ADD_MONTHS(date,i)
对给定的日期加上指定的月数，若i为
负数则是减去

查看每个员工入职20周年的纪念日?
SELECT 
 ename,ADD_MONTHS(hiredate,12*20)
FROM emp

MONTH_BETWEEN(date1,date2)
计算两个日期之间相差的月，计算方式是
使用date1-date2的结果换算的。
查看每个员工至今为止入职多少个月了?
SELECT 
 ename,MONTHS_BETWEEN(
         SYSDATE,hiredate
       )
FROM emp


NEXT_DAY(date,i)
返回给定日期之后一周内的周几
SELECT 
 NEXT_DAY(SYSDATE,1)
FROM 
 dual


LEAST、GREATEST
求最小值与最大值
这组函数的参数不限制数量，两个以上即可。
SELECT 
 LEAST(SYSDATE, TO_DATE(
                '2008-10-10',
                'YYYY-MM-DD')
      ) 
FROM DUAL;

查看82年以后入职的员工的入职日期，若是
82年以前入职的，则显示为:1982-01-01
SELECT 
 ename,GREATEST(hiredate,TO_DATE('1982-01-01','YYYY-MM-DD'))
FROM
 emp

EXTRACT()提取指定日期指定时间分量的值
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;

查看81年入职的员工
SELECT ename,hiredate
FROM emp
WHERE 
 EXTRACT(YEAR FROM hiredate)=1981


CREATE TABLE student
    (id NUMBER(4), 
     name CHAR(20), 
     gender CHAR(1) NOT NULL);

INSERT INTO student VALUES(1000, '李莫愁', 'F');

INSERT INTO student VALUES(1001, '林平之', NULL);

INSERT INTO student(id, name) VALUES(1002, '张无忌');

判断一个字段的值是否为空，要使用:
IS NULL 或 IS NOT NULL
UPDATE student
SET gender='M'
WHERE gender IS NULL

SELECT * FROM student

NULL的运算
NULL与字符串连接等于什么都没做
NULL与数字运算结果还是NULL

查看每个员工的收入
SELECT ename,sal,comm,sal+comm
FROM emp

NVL(p1,p2)
若p1为NULL，函数返回p2
若不为NULL，函数返回p1自身
所以该函数的作用是将NULL值替换为
非NULL值。

查看每个员工的收入
SELECT 
 ename,sal,comm,
 sal+NVL(comm,0)
FROM emp

查看每个员工的奖金情况:
若奖金不为NULL的则显示为"有奖金"
为NULL的则显示为"没有奖金"
NVL2(p1,p2,p3)
当p1不为NULL，函数返回p2
当p1为NULL，函数返回p3
SELECT 
 ename,comm,
 NVL2(comm,'有奖金','没有奖金')
FROM 
 emp
 
NVL2可以完全实现NVL功能，但是反过来
则不行。
SELECT
 ename,NVL2(comm,sal+comm,sal)
FROM emp







