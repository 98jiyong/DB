create table hm(
no number(2),
name varchar2(10),
point number(3),
addr varchar2(10),
indate date default sysdate
);

insert into hm values(1, 'ȫ�浿', 30, '�����', sysdate + 2);
insert into hm values(2, '������', 50, '����', SYSDATE + 1);
insert into hm values(3, '������', 40, '����', sysdate - 1);
insert into hm values(4, '���ð�', 60, '����', SYSDATE);
insert into hm values(5, '��Ƽó', 70, '���ν�', sysdate - 2);

select COUNT(*) from hm where point < 50; /* hm ���̺��� point �÷��� ���� 50 �̸��� ���� ���� */
select name ,point from hm where point <= 50; /*  */
select * from hm where point < 50 order by point desc;

desc hm;
alter table hm add (indate timestamp);
select * from hm;

/* ��� �л��� �̸��� ����Ʈ�� ����մϴ�. ����Ʈ�� ���� ����Ʈ���� 10�� �÷��� ���*/
select name �̸�, point + 10 ��������Ʈ 
from hm;
/* �̸� ��������Ʈ ��������Ʈ -> �̸��� �л��� �̸�, ��������Ʈ�� ����� ����Ʈ, ��������Ʈ�� +10�� �ø� ����Ʈ */
select name �̸�, point ��������Ʈ, point + 10 ��������Ʈ 
from hm;

/* �̸��ڿ� ���� ������ ����Ͻÿ�. ��� ����� �̸��� ����Ʈ�� ����մϴ�.*/
select concat (name,'��') �̸�, point ����Ʈ from hm;
/*��� ����� �̸��� ����Ʈ�� ������� ����մϴ�. �̶� ���Լ����� ���� ����մϴ�. ���� ���߿� ������ ����� ���� ���� ��� */
select name �̸�, point ����Ʈ, indate ����� from hm order by indate desc;
/*����Ʈ�� 50�̻��� ����� �̸��� ������ ����մϴ�. ������ no,�̸�,����Ʈ�� ������ ���ڿ��̴�. */
select name �̸�, concat(no,concat(name,point)) ���� from hm where point >= 50;
/* ��������Ʈ�� 60�̴�. ��� ȸ���� ��������Ʈ�� ���߱� ���ؼ� ����������Ʈ�� ����Ͻÿ�.. */  
select name �̸�, 60 ��������Ʈ, point ��������Ʈ, (60 - point) ����������Ʈ from hm;