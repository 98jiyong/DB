create table hm(
no number(2),
name varchar2(10),
point number(3),
addr varchar2(10)
);

insert into hm values(1, 'ȫ�浿', 30, '�����');
insert into hm values(2, '������', 50, '����');
insert into hm values(3, '������', 40, '����');
insert into hm values(4, '���ð�', 60, '����');

select COUNT(*) from hm where point < 50; /* hm ���̺��� point �÷��� ���� 50 �̸��� ���� ���� */
select name ,point from hm where point <= 50; /*  */
select * from hm where point < 50 order by point desc;
drop table help;
commit;
