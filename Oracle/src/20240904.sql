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
join : 1개 이상의 테이블을 논리적으로 합치는 것
종류 : full join : 두개의 테이블을 모두 합치는 것
결과는 n*m의 수만큼 조인이 되어 튜플이 만들어 진다.
    inner join : 조건을 제시한다. 조건에 참일 경우만 조인한다.
        종류 : 동등이너조인(==), 비동등이너조인(!=)
    outer join : 이너조인 + 조인에 참여하지 않은 튜플까지 출력
        종류 : 테이블 조인의 위치에 따라 left outer join, right outer join 
공부에 방향은 : 어떤 테이블을 조인할까? 어떤 조인을 사용할까?
먼저 full join해본다.. 절대 현업에서는 X -> 속도 느려짐
*/

/* full join */
select * from stu, pp;
/* inner join*/
select a.no, a.name, b.no, b.e_name, b.e_point
from stu a, pp b
where a.no = b.no;
/*
inner join 다른 방식 
이 문법은 from에 오는게 왼쪽 inner join에 오는게 오른쪽 (outer join 에서 사용)
무엇으로 묶을건지는 where에 적는게 아닌 on에 적음
*/
select a.no, a.name, b.no, b.e_name, b.e_point
from stu a
inner join pp b
on a.no = b.no;

/* 
같은 문법으로 outer join 
추가로 조건을 주고 싶을 땐 where에
*/
select a.name 
from stu a
left outer join pp b
on a.no = b.no
where b.no is null;

-- 문제 풀이
drop table users;
drop table carinfo;

create table users(
id varchar2(8), --아이디
name varchar2(10), --이름
addr varchar2(10)); --주소

create table carinfo(
c_num varchar2(4),   --자동차 번호
c_name varchar2(10),  -- 자동차 종류
id varchar2(8)); --아이디

insert into users values ('1111','kim','수원');
insert into users values ('2222','lee','서울');
insert into users values ('3333','park','대전');
insert into users values ('4444','choi','대전');

insert into carinfo values ('1234','중형','1111');
insert into carinfo values ('3344','소형','1111');
insert into carinfo values ('5566','중형','3333');
insert into carinfo values ('6677','중형','3333');
insert into carinfo values ('7788','중형','4444');
insert into carinfo values ('8888','중형','5555');

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
-- 다른 풀이
select name, addr from users where id=(select id from carinfo where c_num='7788');

select u.name, u.addr
from users u
left outer join carinfo c
on u.id = c.id
where c.c_num is null;

/*
조인을 한 후에 그룹화를 진행
조인을 해서 만들어진 테이블 안에서 그룹화를 진행한다.
*/
select u.name 회원, count(c.id) "등록된 자동차 수"
from users u
left outer join carinfo c
on u.id = c.id
group by (u.id, u.name);

select u.name 회원, count(c.id) "등록된 자동차 수"
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

-- 추가문제 풀이
create table companycar(     -- 자동차 정보
c_num varchar2(4),   -- 차번호
c_com varchar2(30), -- 제조사
c_name varchar2(10),  -- 차이름
c_price number);  -- 차 가격

insert into companycar values ('1234','현다','소나타',1000);
insert into companycar values ('3344','기와','축제',2000);
insert into companycar values ('7788','기와','레2',800);
insert into companycar values ('9900','현다','그랭저',2100);

select b.*
from carinfo a, companycar b
where a.c_num = b.c_num;

select b.c_num, b.c_com, b.c_name
from carinfo a
right outer join companycar b
on a.c_num = b.c_num
where a.c_num is null;

select c_name from companycar where c_price >= 1000;
-- 심화
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
여러개의 테이블을 조인할 때 concat함수를 사용하는 것처럼 
두개의 테이블을 먼저 조인한 후 조인해서 나온 테이블의 튜플과 
조인하고자하는 새로운 테이블을 또 조인한다.
10개든 100개든 그렇게 계속 조인을 진행
(a 조인 b) -> (a 조인 b) 조인 c)
*/

-- nvl => null값이 있으면 대체해라
select a.name, nvl(b.c_num, '없음') ,NVL(c.c_name, '없음') 
from users a 
left outer join carinfo b
on a.id = b.id
left outer join companycar c
on b.c_num = c.c_num;
