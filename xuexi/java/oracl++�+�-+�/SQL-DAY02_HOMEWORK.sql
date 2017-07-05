1:查询EMP表中的数据，列出一列，内容为名字与职位
显示格式：ename:job
SELECT ename||':'||job
FROM EMP_LEE
SELECT CONCAT(CONCAT(ENAME,':'),JOB)
FROM EMP_LEE
2:查看每个员工职位的字符个数
SELECT ename,LENGTH(ename)
FROM EMP_LEE
3:将所有员工的名字以小写形式，与首字母大写形式
   查询出来，第一列为小写形式，第二列为首字母大写
SELECT LOWER(ename),INITCAP(ename)
FROM emp_lee
4:将字符串'aaaaaabaaaaa'中左右两边的a去除
SELECT TRIM('a'FROM'aaaaaabaaaa')
FROM dual

5:显示每个员工的名字，要求显示10位，第一列左对齐效果，第二列    右对齐效果
SELECT LPAD(ename,10,' '),RPAD(ename,10,' ')
FROM emp_lee
6:截取字符串'DOCTOR WHO'中的'WHO'
SELECT SUBSTR('DOCTOR WHO',-3,3)
FROM dual
7:查看'DOCTOR WHO'中'WHO'的位置
SELECT INSTR('DOCTOR WHO','WHO')
FROM DUAL
8:分别查看55.789四舍五入保留小数点后2位，整数位，十位后的
   数字，显示成三列。
SELECT ROUND(55.789,2),ROUND(55.789),ROUND(55.789,-1)
FROM DUAL
9:分别查看55.789截取后保留小数点后2位，整数位，十位后的
   数字，显示成三列。
SELECT TRUNC(55.789,2),TRUNC(55.789),TRUNC(55.789,-1)
FROM dual;
10：查看每名员工工资百位以下的数字?
SELECT ename,sal,MOD(sal,100)
FROM emp_lee;
11:查看每名员工从入职到今天一共多少天，若有小数则向上取整。
SELECT ename,ROUND(SYSDATE-hiredate)
FROM emp_lee;
12:查看从2008-08-08号到今天为止一共经历了多少天?
SELECT TRUNC(SYSDATE-TO_DATE('2008-08-08','YYYY-MM-DD'))
FROM DUAL
13:将每名员工入职时间以例如:
     1981年12月3日
     的形式显示
SELECT ename,TO_CHAR(hiredate,'YYYY"年"MM"月"DD"日"')
FROM emp_lee;
14：查看每个员工入职所在月的月底是哪天?
SELECT ename,LAST_DAY(hiredate)
FROM emp_lee;
15:查看每名员工转正日期(入职后3个月)
SELECT ename,ADD_MONTHS(hiredate,3)
FROM emp_lee;
16：查看每名员工入职至今共多少个月?
SELECT ename,MONTHS_BETWEEN(SYSDATE,hiredate)
FROM emp_lee;
17:查看从明天开始一周内的周日是哪天?
SELECT NEXT_DAY((SYSDATE+1),1)
FROM DUAL
18:查看82年以后入职的员工的入职日期，82年以前的按照
     1982年01月01号显示。格式都是DD-MON-RR(默认格式)
SELECT ename,greatest(hiredate,TO_DATE('1982年01月01日','YYYY"年"MM"月"DD"日"'))
FROM EMP_LEE
19:查看每名员工的入职年份?
SELECT ENAME,EXTRACT( YEAR FROM hiredate)
FROM emp_lee
20:显示每个员工的总收入(工资加奖金)，奖金为NULL的只看工资
SELECT ENAME,nvl(COMM,0)+SAL
FROM EMP_LEE
21:使用NVL2实现20题的需求
SELECT ENAME,nvl2(COMM,SAL+COMM,SAL)AS SALARY
FROM EMP_LEE

     


