1:创建一个视图，包含20号部门的员工信息，字段:empno,ename,sal,job,deptno
CREATE VIEW V_EMP_20
AS 
SELECT EMPNO,ENAME,SAL,JOB,DEPTNO
FROM EMP
WHERE DEPTNO=20
SELECT *FROM V_EMP_20


2:创建一个序列seq_emp_no,从10开始，步进为10
CREATE SEQUENCE SEQ_EMP_NO
START WITH 10
INCREMENT BY 10


3:编写SQL语句查看seq_emp_no序列的下一个数字
SELECT SEQ_EMP_NO.NEXTVAL FROM DUAL

4:编写SQL语句查看seq_emp_no序列的当前数字
SELECT SEQ_EMP_NO.CURRVAL FROM DUAL
5:为emp表的ename字段添加索引:idx_emp_ename 
CREATE INDEX IDX_EMP_ENAME  ON EMP(ENAME)

6:为emp表的LOWER(ename)字段添加索引:idx_emp_lower_ename
CREATE INDEX IDX_EMP_LOWER_ENAME ON EMP(LOWER(ENAME))

7:为emp表的sal,comm添加多列索引
CREATE INDEX IDX_EMP_SAL_COMM ON EMP(SAL,COMM)

8:创建myemployee表，字段:
  id NUMBER(4) ,
  nameVARCHAR2(20),
  birthday DATE,
  telephone VARCHAR2(11)
  scoreNUMBER(9,2)
  其中id作为主键，name要求不能为空,telephone需要唯一,score值必须>=0
  CREATE TABLE MYEMPLOYEE1(
  ID NUMBER(4) PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  BIRTHDAY DATE,
  TELEPHONE VARCHAR2(11) UNIQUE,
  SCORE NUMBER(9，2) CHECK(SCORE>=0) )
  
  INSERT INTO MYEMPLOYEE1(ID,NAME,BIRTHDAY,TELEPHONE,SCORE)
  VALUES(2，'J',TO_DATE('1998-1-1','YYYY-MM-DD'),'188',-1)
  
  SELECT *FROM MYEMPLOYEE1
  
  
  
  
  
  
  
  
  
  
  