--资费信息表
create table cost(
  	cost_id			number(4) primary key,
  	name 			varchar(50)  not null,
  	base_duration 	number(11),
  	base_cost 		number(7,2),
  	unit_cost 		number(7,4),
  	status 			char(1),
  	descr 			varchar2(100),
  	creatime 		date default sysdate ,
  	startime 		date,
	cost_type		char(1)
  );

create sequence cost_seq start with 100;

INSERT INTO COST VALUES (1,'5.9元套餐',20,5.9,0.4,0,'5.9元20小时/月,超出部分0.4元/时',DEFAULT,DEFAULT,'2');
INSERT INTO COST VALUES (2,'6.9元套餐',40,6.9,0.3,0,'6.9元40小时/月,超出部分0.3元/时',DEFAULT,DEFAULT,'2');
INSERT INTO COST VALUES (3,'8.5元套餐',100,8.5,0.2,0,'8.5元100小时/月,超出部分0.2元/时',DEFAULT,DEFAULT,'2');
INSERT INTO COST VALUES (4,'10.5元套餐',200,10.5,0.1,0,'10.5元200小时/月,超出部分0.1元/时',DEFAULT,DEFAULT,'2');
INSERT INTO COST VALUES (5,'计时收费',null,null,0.5,0,'0.5元/时,不使用不收费',DEFAULT,DEFAULT,'3');
INSERT INTO COST VALUES (6,'包月',null,20,null,0,'每月20元,不限制使用时间',DEFAULT,DEFAULT,'1');
COMMIT;



--帐务信息表
create table account(
 	account_id		number(9) constraint account_id_pk primary key,
 	recommender_id	number(9),
 	login_name		varchar2(30)  not null,
 	login_passwd	varchar2(30) not null,
 	status			char(1),
 	create_date		date	 default sysdate,
 	pause_date		date,
 	close_date		date,
 	real_name		varchar2(20)	not null,
 	idcard_no		char(18)		not null,
 	birthdate		date,
 	gender	    char(1),
 	occupation		varchar2(50),
 	telephone		varchar2(15) not null,
 	email			varchar2(50),
 	mailaddress		varchar2(200),
 	zipcode			char(6),
 	qq				varchar2(15),
 	last_login_time	  	date,
 	last_login_ip		varchar2(15)
);

create sequence account_seq start with 2000;

ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy mm dd hh24:mi:ss';
INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
     REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1005,NULL,'taiji001','256528',1,'2008 03 15','zhangsanfeng','19430225','410381194302256528',13669351234);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1010,NULL,'xl18z60','190613',1,'2009 01 10','guojing','19690319','330682196903190613',13338924567);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1011,1010,'dgbf70','270429',1,'2009 03 01','huangrong','19710827','330902197108270429',13637811357);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1015,1005,'mjjzh64','041115',1,'2010 03 12','zhangwuji','19890604','610121198906041115',13572952468);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1018,1011,'jmdxj00','010322',1,'2011 01 01','guofurong','199601010322','350581200201010322',18617832562);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1019,1011,'ljxj90','310346',1,'2012 02 01','luwushuang','19930731','320211199307310346',13186454984);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1020,NULL,'kxhxd20','012115',1,'2012 02 20','weixiaobao','20001001','321022200010012115',13953410078);

INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1021,NULL,'kxhxd21','012116',1,'2012 02 20','zhangsan','20001002','321022200010012116',13953410079);
INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1022,NULL,'kxhxd22','012117',1,'2012 02 20','lisi','20001003','321022200010012117',13953410080);
INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1023,NULL,'kxhxd23','012118',1,'2012 02 20','wangwu','20001004','321022200010012118',13953410081);
INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1024,NULL,'kxhxd24','012119',1,'2012 02 20','zhouliu','20001005','321022200010012119',13953410082);
INSERT INTO ACCOUNT(ACCOUNT_ID,RECOMMENDER_ID,LOGIN_NAME,LOGIN_PASSWD,STATUS,CREATE_DATE,
REAL_NAME,BIRTHDATE,IDCARD_NO,TELEPHONE)
VALUES(1025,NULL,'kxhxd25','012120',1,'2012 02 20','maqi','20001006','321022200010012120',13953410083);
COMMIT;



--业务信息表
create table service(
 	service_id		number(10) constraint service_id_pk primary key,
 	account_id		number(9) not null,
 	unix_host		varchar2(15) not null ,
 	os_username		varchar2(8)	not null,
 	login_passwd	varchar2(30) not null,
 	status 			char(1),	
 	create_date		date	default sysdate,
 	pause_date		date,
 	close_date		date,
 	cost_id			number(4) not null
);

create sequence service_seq start with 3000;

INSERT INTO SERVICE VALUES (2001,1010,'192.168.0.26','guojing','guo1234','0',sysdate,null,null,1);

INSERT INTO SERVICE VALUES (2002,1011,'192.168.0.26','huangr','huang234','0',sysdate,null,null,1);

INSERT INTO SERVICE VALUES (2003,1011,'192.168.0.20','huangr','huang234','0',sysdate,null,null,3);

INSERT INTO SERVICE VALUES (2004,1011,'192.168.0.23','huangr','huang234','0',sysdate,null,null,6);

INSERT INTO SERVICE VALUES (2005,1019,'192.168.0.26','luwsh','luwu2345','0',sysdate,null,null,4);

INSERT INTO SERVICE VALUES (2006,1019,'192.168.0.20','luwsh','luwu2345','0',sysdate,null,null,5);

INSERT INTO SERVICE VALUES (2007,1020,'192.168.0.20','weixb','wei12345','0',sysdate,null,null,6);

INSERT INTO SERVICE VALUES (2008,1010,'192.168.0.20','guojing','guo09876','0',sysdate,null,null,6);
COMMIT;



--业务资费更新备份表
CREATE TABLE SERVICE_UPDATE_BAK(
 ID	 NUMBER(10) PRIMARY KEY,
 SERVICE_ID	NUMBER(9) NOT NULL,
 COST_ID	 NUMBER(4)  NOT NULL
);

create sequence service_bak_seq;

--模块表
create table module_info(
		module_id 	number(4) constraint module_info_id_pk primary key,
		name 		varchar2(50) not null
);

create sequence module_seq start with 100;

--角色表
create table role_info(
		role_id		number(4)	constraint role_info_id_pk primary key,
		name	varchar2(50) 	not null
);

create sequence role_seq start with 1000;

--角色模块表
create table role_module(
		role_id     number(4) not null,
  	module_id   number(4) not null,
  	constraint role_module_pk primary key(role_id,module_id)
);



--管理员表
create table admin_info(
   	admin_id 	number(8) primary key not null,
   	admin_code 	varchar2(30) not null,
   	password 	varchar2(30) not null,
   	name 		varchar2(30) not null,
   	telephone 	varchar2(15),
   	email 		varchar2(50),
   	enrolldate 	date default sysdate not null
);

create sequence admin_seq start with 10000;


--管理员角色表
create table admin_role(
		admin_id	number(8) not null,
  	role_id		number(4) not null,
  	constraint admin_role_pk primary key(admin_id,role_id)
);



--模块表
insert into MODULE_INFO values(1,'角色管理');
insert into MODULE_INFO values(2,'管理员');
insert into MODULE_INFO values(3,'资费管理');
insert into MODULE_INFO values(4,'账务账号');
insert into MODULE_INFO values(5,'业务账号');
insert into MODULE_INFO values(6,'账单管理');
insert into MODULE_INFO values(7,'报表');
commit;
--角色表
insert into role_info values(100,'管理员');
insert into role_info values(200,'营业员');
insert into role_info values(300,'经理');
insert into role_info values(400,'aaa');
insert into role_info values(500,'bbb');
insert into role_info values(600,'ccc');
commit;
--角色模块表
insert into role_module values(100,1);
insert into role_module values(100,2);
insert into role_module values(200,3);
insert into role_module values(200,4);
insert into role_module values(200,5);
insert into role_module values(200,6);
insert into role_module values(300,7);
commit;
--管理员表
insert into admin_info values(2000,'admin','123','ADMIN','123456789','admin@tarena.com.cn',sysdate);
insert into admin_info values(3000,'zhangfei','123','ZhangFei','123456789','zhangfei@tarena.com.cn',sysdate);
insert into admin_info values(4000,'liubei','123','LiuBei','123456789','liubei@tarena.com.cn',sysdate);
insert into admin_info values(5000,'caocao','123','CaoCao','123456789','caocao@tarena.com.cn',sysdate);
insert into admin_info values(6000,'aaa','123','AAA','123456789','aaa@tarena.com.cn',sysdate);
insert into admin_info values(7000,'bbb','123','BBB','123456789','bbb@tarena.com.cn',sysdate);
commit;
--管理员角色表
insert into admin_role values(2000,100);
insert into admin_role values(3000,200);
insert into admin_role values(4000,300);
insert into admin_role values(5000,100);
insert into admin_role values(5000,200);
insert into admin_role values(5000,300);
commit;

