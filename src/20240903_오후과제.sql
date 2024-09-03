create table muser(
id int,
reg_num varchar2(8) not null,
name varchar2(10 char),
grade int,
salary int,
time int);

create sequence muser_no
increment by 1
start with 10
;

--id, reg_num, name, grade, salary, time
insert into muser values(muser_no.nextval,'870205-1','�̽���',1,10000,34);
insert into muser values(muser_no.nextval,'880405-1','������',2,20000,31);
insert into muser values(muser_no.nextval,'770715-2','���̼�',4,40000,32);
insert into muser values(muser_no.nextval,'010205-3','������',1,10000,30);
insert into muser values(muser_no.nextval,'810205-2','������',2,20000,34);
insert into muser values(muser_no.nextval,'820219-2','���¿�',3,30000,35);
insert into muser values(muser_no.nextval,'020205-3','�����',1,10000,30);
insert into muser values(muser_no.nextval,'970214-2','������',2,20000,31);
insert into muser values(muser_no.nextval,'040205-4','������',4,40000,31);
insert into muser values(muser_no.nextval,'770225-1','���翵',5,50000,30);
insert into muser values(muser_no.nextval,'770905-2','�̽ż�',4,40000,34);
insert into muser values(muser_no.nextval,'050208-3','�̹߲�',2,20000,30);
insert into muser values(muser_no.nextval,'051205-4','�̿���',1,10000,34);
insert into muser values(muser_no.nextval,'891215-1','���¾�',3,30000,30);
insert into muser values(muser_no.nextval,'670805-1','������',2,20000,34);
insert into muser values(muser_no.nextval,'840207-1','���̷�',1,10000,35);
insert into muser values(muser_no.nextval,'770405-1','��õ��',1,10000,31);

-- 1 ~ 20�� ����
select count(*) from muser where grade=3;
select avg(salary) from muser where grade in(1,2,4);
select count(*) from muser where salary < 20000;
select avg(salary) from muser where salary >= 30000;
select name,fn_age(reg_num), salary from muser 
where salary = (select min(salary) from muser where fn_age(reg_num) = 47) and fn_age(reg_num) = 47;
select avg(salary) from muser where fn_gender(reg_num) = '��';
select name, salary from muser where salary > (select avg(salary) from muser);
select name, salary, (select avg(salary) from muser) from muser where salary > (select avg(salary) from muser);
select count(*) from muser 
where salary > (select avg(salary) from muser where fn_gender(reg_num) = '��') and fn_gender(reg_num) = '��';
select grade, avg(salary) from muser group by grade;
select grade, avg(salary), (select avg(salary) from muser) from muser 
group by grade having avg(salary) > (select avg(salary) from muser);
select name �̸�, grade*salary*time ���޸��� from muser;
select name �̸�, fn_gender(reg_num) ���� from muser;
select name from muser where time >= 31;
select name from muser where mod(substr(reg_num,2,1),2) = 0;
select name, substr(reg_num,1,2) || '��' || substr(reg_num,3,2) || '��' || substr(reg_num,5,2) || '��' ������� from muser;
select name, fn_gender(reg_num), time, time+2 from muser where fn_gender(reg_num) = '��';
select count(*), fn_age(reg_num) from muser group by fn_age(reg_num);
select grade, count(*) from muser group by grade having grade in (2,4);

-- �߰�����
select name �̸�, reg_num �ֹε�Ϲ�ȣ, fn_age(reg_num) * 12 + substr(reg_num,3,2) ������ from muser;
select distinct time, sum(time*12)over(partition by time) from muser order by time;
/*
select time from muser where time between 30 and 31;
select time from muser where time >= 32;
select sum(time * 12)
from (select time from muser where time between 30 and 31);
select sum(time * 12)
from (select time from muser where time >= 32);
*/
select distinct time, sum(salary)over(partition by time) from muser order by time;
select distinct time, count(*)over(partition by time) from muser order by time;
select distinct grade, max(salary)over(partition by grade) from muser order by grade;
 / 
--���� �Լ� '/' ����ؼ� ������ �Լ� 
create or replace function fn_gender(v_reg_num varchar2)
return varchar2 is v_gender varchar2(2);
begin
    if substr(v_reg_num,instr(v_reg_num,'-')+1,1) in(1,3) then
        v_gender := '��';
    else
        v_gender := '��';
    end if;
    return v_gender;
end fn_gender;
/

--���� �Լ�
create or replace function fn_age(v_reg_num varchar2)
return number is v_age number(2);
begin
    if substr(v_reg_num,1,2) > substr(systimestamp,1,2) then
        v_age := to_number(extract(year from systimestamp) - concat(19,substr(v_reg_num,1,2)));
    else
        v_age := to_number(extract(year from systimestamp) - concat(20,substr(v_reg_num,1,2)));
    end if;
    return v_age;
end fn_age;
/
