create table stu(
no number,
name varchar2(5 char),
tel varchar2(13));

create table pp(
no number,
e_name varchar2(4),
e_point number(3));

insert into stu values(1,'hong','1111');
insert into stu values(2,'kim','2222');
insert into stu values(3,'lee','3333');
insert into pp values(1,'java',70);
insert into pp values(1,'html',90);
insert into pp values(3,'java',80);

select * from stu;
select * from pp;
/*
join : 1�� �̻��� ���̺��� �������� ��ġ�� ��
���� : full join : �ΰ��� ���̺��� ��� ��ġ�� ��
����� n*m�� ����ŭ ������ �Ǿ� Ʃ���� ����� ����.
    inner join : ������ �����Ѵ�. ���ǿ� ���� ��츸 �����Ѵ�.
        ���� : �����̳�����(==), �񵿵��̳�����(!=)
    outer join : �̳����� + ���ο� �������� ���� Ʃ�ñ��� ���
        ���� : ���̺� ������ ��ġ�� ���� left outer join, right outer join 
���ο� ������ : � ���̺��� �����ұ�? � ������ ����ұ�?
���� full join�غ���.. ���� ���������� X -> �ӵ� ������
*/

/* full join */
select * from stu, pp;
/* inner join*/
select a.no, a.name, b.no, b.e_name, b.e_point
from stu a, pp b
where a.no = b.no;
/*
inner join �ٸ� ��� 
�� ������ from�� ���°� ���� inner join�� ���°� ������ (outer join ���� ���)
�������� ���������� where�� ���°� �ƴ� on�� ����
*/
select a.no, a.name, b.no, b.e_name, b.e_point
from stu a
inner join pp b
on a.no = b.no;

/* 
���� �������� outer join 
�߰��� ������ �ְ� ���� �� where��
*/
select a.name 
from stu a
left outer join pp b
on a.no = b.no
where b.no is null;

-- ���� Ǯ��
drop table users;
drop table carinfo;

create table users(
id varchar2(8), --���̵�
name varchar2(10), --�̸�
addr varchar2(10)); --�ּ�

create table carinfo(
c_num varchar2(4),   --�ڵ��� ��ȣ
c_name varchar2(10),  -- �ڵ��� ����
id varchar2(8)); --���̵�

insert into users values ('1111','kim','����');
insert into users values ('2222','lee','����');
insert into users values ('3333','park','����');
insert into users values ('4444','choi','����');

insert into carinfo values ('1234','����','1111');
insert into carinfo values ('3344','����','1111');
insert into carinfo values ('5566','����','3333');
insert into carinfo values ('6677','����','3333');
insert into carinfo values ('7788','����','4444');
insert into carinfo values ('8888','����','5555');

select * from users;
select * from carinfo;

select name, addr from users;

select u.name, c.c_num
from users u, carinfo c
where u.id = c.id;

select u.name, u.addr
from users u, carinfo c
where u.id = c.id
and c.c_num = '7788';
-- �ٸ� Ǯ��
select name, addr from users where id=(select id from carinfo where c_num='7788');

select u.name, u.addr
from users u
left outer join carinfo c
on u.id = c.id
where c.c_num is null;

/*
������ �� �Ŀ� �׷�ȭ�� ����
������ �ؼ� ������� ���̺� �ȿ��� �׷�ȭ�� �����Ѵ�.
*/
select u.name ȸ��, count(c.id) "��ϵ� �ڵ��� ��"
from users u
left outer join carinfo c
on u.id = c.id
group by (u.id, u.name);

select u.name ȸ��, count(c.id) "��ϵ� �ڵ��� ��"
from users u
left outer join carinfo c
on u.id = c.id
group by c.id, u.name
having count(c.id) >= 2
order by u.name;

select c.c_num
from users u
right outer join carinfo c
on u.id = c.id
where u.id is null;

-- �߰����� Ǯ��
create table companycar(     -- �ڵ��� ����
c_num varchar2(4),   -- ����ȣ
c_com varchar2(30), -- ������
c_name varchar2(10),  -- ���̸�
c_price number);  -- �� ����

insert into companycar values ('1234','����','�ҳ�Ÿ',1000);
insert into companycar values ('3344','���','����',2000);
insert into companycar values ('7788','���','��2',800);
insert into companycar values ('9900','����','�׷���',2100);

select b.*
from carinfo a, companycar b
where a.c_num = b.c_num;

select b.c_num, b.c_com, b.c_name
from carinfo a
right outer join companycar b
on a.c_num = b.c_num
where a.c_num is null;

select c_name from companycar where c_price >= 1000;
-- ��ȭ
select a.c_num
from carinfo a, companycar b
where a.c_num = b.c_num
and b.c_price >= 1000;

select a.c_num
from carinfo a
left outer join companycar b
on a.c_num = b.c_num
where b.c_num is null;

/*
�������� ���̺��� ������ �� concat�Լ��� ����ϴ� ��ó�� 
�ΰ��� ���̺��� ���� ������ �� �����ؼ� ���� ���̺��� Ʃ�ð� 
�����ϰ����ϴ� ���ο� ���̺��� �� �����Ѵ�.
10���� 100���� �׷��� ��� ������ ����
(a ���� b) -> (a ���� b) ���� c)
*/

-- nvl => null���� ������ ��ü�ض�
select a.name, nvl(b.c_num, '����') ,NVL(c.c_name, '����') 
from users a 
left outer join carinfo b
on a.id = b.id
left outer join companycar c
on b.c_num = c.c_num;
