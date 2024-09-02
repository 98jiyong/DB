--���̺� ����
create table users(
no int primary key,
name varchar2(10),
addr varchar2(10),
point number,
grade varchar2(1),
jumin varchar2(8));

--���̺� ���� Ȯ��
desc users;

insert into users values (1,'kimsu','suwon',99.12,1,'820405-1');
insert into users values (2,'leesu','suwon city',89.00,2,'970805-2');
insert into users values (3,'choihee','seoul',88.21,1,'910204-2');
insert into users values (4,'leesil','suwon',77.62,4,'850405-1');
insert into users values (5,'james','seoul',60.22,1,'871105-1');
insert into users values (6,'parksuji','suwon',90.12,3,'880405-2');
insert into users values (7,'kimrae','yougin',89.96,3,'820105-1');
insert into users values (8,'sangJin','youngin',99.31,3,'990420-2');
insert into users values (9,'Leechan','incheon',79.12,2,'970605-2');
insert into users values (10,'kimmi','incheon',79.92,1,'810505-1');
insert into users values (11,'ryusu','seoul',85.32,4,'861205-2');
insert into users values (12,'Gosu',null,82.13,4,'810715-1');

--���ڵ� Ȯ��
select * from users;

--1 ~ 12 ��ǥ����
select name �̸�, point ����, substr(jumin,1,6) ������� from users;
select name �̸�, addr �ּ�, point ���� from users where point >= 80;
select name �̸�, addr �ּ�, point ���� from users where name like 'kim%';
select name �̸�, addr �ּ�, point+10 ���������� from users;
select point + 1 ���� from users where grade = 1;
select name �̸�, addr �ּ�, point ���� from users where point >= 80 and point < 90;
select name, addr, grade, point, jumin from users where addr is null;
select point * 1.1 from users where grade = 4;
select no ��ȣ, name �̸�, addr �ּ�, point ���� from users order by point;
select no ��ȣ, name �̸�, grade �г�, point ���� from users order by grade asc, point desc;
select name �̸�, point ����, point-10 ���������� from users where point-10 >= 80;
select (name || ' '  || addr || ' ' || grade) "�̸� �ּ� �г�" from users where grade = 2;

--13 ~ 23 �߰�����
select count(*) from users;
select count(*) from users where grade = 1;
select LOWER(name) �ҹ����̸�, grade �г� from users;
select name �̸�, grade �г�, substr(addr,1,2) �ּ� from users where grade = 2;
select trunc(point,-1) ���� from users;
select round(point) ���� from users;
select count(*) as "2�г�" from users where grade = 2;
select count(*) as "1�г��� 80��" from users where grade = 1 and point >=80;
select avg(point) from users where grade = 3;
select MAX(point) from users;
select MIN(point) from users where grade = 2;

--24 ~ 27 ��Ǫ�� ���� 
/* trim �Լ��� �ݺ����� ���ڸ� �����ϱ� ������ 9���� 10���� incheon�� n�� �ݺ��Ǿ 'in'�� �ƴ� 'i'�� ���
select ltrim(addr,substr(addr,1,2)) "�յα��ڸ� ������ ����", rtrim(addr,ltrim(addr,substr(addr,1,2))) "�տ� ���� rtrim ���" from users;
select concat(rtrim(addr,ltrim(addr,substr(addr,1,2))),'*') "@@*" from users;
*/
select concat(substr(addr,1,2),'*') from users;
select '*' || name || '*' from users;
select concat(substr(jumin,1,2),'��') || concat(substr(jumin,3,2),'��') || concat(substr(jumin,5,2),'��') ������� from users;
select decode(substr(jumin,instr(jumin,'-',1)+1,1),1,'��',2,'��') ���� from users;

--28 ~ 30 �߰�����
select name �̸�, jumin �ֹι�ȣ, 124-substr(jumin,1,2) ���� from users;
select name �̸�, rpad(substr(name,1,1),length(name),'*') "a***" from users;
select name �̸�, grade �г�, decode(grade,1,name||'*',2,name||'%',3,name||'#',4,name||'!') ���� from users;

--�ٸ�Ǯ��
select name �̸�, grade �г�, case 
when grade = 1 then name || '*'
when grade = 2 then name || '%'
when grade = 3 then name || '#'
when grade = 4 then name || '!'
end ����
from users;
