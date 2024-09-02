create table hm(
no number(2),
name varchar2(10),
point number(3),
addr varchar2(10),
indate date default sysdate
);

insert into hm values(1, '홍길동', 30, '서울시', sysdate + 2);
insert into hm values(2, '일지매', 50, '수원', SYSDATE + 1);
insert into hm values(3, '이지매', 40, '서울', sysdate - 1);
insert into hm values(4, '성시골', 60, '대전', SYSDATE);
insert into hm values(5, '김티처', 70, '용인시', sysdate - 2);

select COUNT(*) from hm where point < 50; /* hm 테이블에서 point 컬럼에 값이 50 미만인 갯수 세기 */
select name ,point from hm where point <= 50; /*  */
select * from hm where point < 50 order by point desc;

desc hm;
alter table hm add (indate timestamp);
select * from hm;

/* 모든 학생의 이름과 포인트를 출력합니다. 포인트는 현재 포인트에서 10점 올려서 출력*/
select name 이름, point + 10 가산포인트 
from hm;
/* 이름 현재포인트 가산포인트 -> 이름은 학생의 이름, 현재포인트는 저장된 포인트, 가산포인트는 +10점 올린 포인트 */
select name 이름, point 현재포인트, point + 10 가산포인트 
from hm;

/* 이름뒤에 님을 붙혀서 출력하시오. 모든 사람의 이름과 포인트를 출력합니다.*/
select concat (name,'님') 이름, point 포인트 from hm;
/*모든 사람의 이름과 포인트와 등록일을 출력합니다. 이때 가입순서에 따라 출력합니다. 가장 나중에 가입한 사람이 제일 먼저 출력 */
select name 이름, point 포인트, indate 등록일 from hm order by indate desc;
/*포인트가 50이상인 사람의 이름과 정보를 출력합니다. 정보는 no,이름,포인트가 합쳐진 문자열이다. */
select name 이름, concat(no,concat(name,point)) 정보 from hm where point >= 50;
/* 기준포인트는 60이다. 모든 회원이 기준포인트를 맞추기 위해서 부족한포인트를 출력하시오.. */  
select name 이름, 60 기준포인트, point 현재포인트, (60 - point) 부족한포인트 from hm;