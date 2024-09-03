--테이블 생성
create table users(
no int primary key,
name varchar2(10),
addr varchar2(10),
point number,
grade varchar2(1),
jumin varchar2(8));

--테이블 구조 확인
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

--레코드 확인
select * from users;

--1 ~ 12 목표문제
select name 이름, point 점수, substr(jumin,1,6) 생년월일 from users;
/* 
2. 사람의 이름과 주소, 점수를 검색하기 위해서는 select절 안에는 이름과 주소, 점수 컬럼이 들어와야하고
이 컬럼들은 users테이블 안에 있기 때문에 from절 users테이블이 온다.
마지막으로 80점 이상의 사람들이 출력되어야하기 때문에 where절 점수가 80점 이상이라는 조건을 줘서
user테이블 안에 있는 튜플들 중에 조건에 충족하는 튜플을 골라 이름과 주소, 점수를 출력한다.
*/
select name 이름, addr 주소, point 점수 from users where point >= 80;
select name 이름, addr 주소, point 점수 from users where name like 'kim%';
select name 이름, addr 주소, point+10 보정한점수 from users;
select point + 1 점수 from users where grade = 1;
select name 이름, addr 주소, point 점수 from users where point >= 80 and point < 90;
select name, addr, grade, point, jumin from users where addr is null;
select point * 1.1 from users where grade = 4;
select no 번호, name 이름, addr 주소, point 점수 from users order by point;
select no 번호, name 이름, grade 학년, point 점수 from users order by grade asc, point desc;
select name 이름, point 점수, point-10 보정한점수 from users where point-10 >= 80;
select (name || ' '  || addr || ' ' || grade) "이름 주소 학년" from users where grade = 2;

--13 ~ 23 추가문제
select count(*) from users;
select count(*) from users where grade = 1;
select LOWER(name) 소문자이름, grade 학년 from users;
select name 이름, grade 학년, substr(addr,1,2) 주소 from users where grade = 2;
select trunc(point,-1) 점수 from users;
select round(point) 점수 from users;
select count(*) as "2학년" from users where grade = 2;
select count(*) as "1학년중 80점" from users where grade = 1 and point >=80;
select avg(point) from users where grade = 3;
select MAX(point) from users;
select MIN(point) from users where grade = 2;

--24 ~ 27 못푸는 문제 
/* trim 함수는 반복적인 문자를 제거하기 때문에 9번과 10번의 incheon에 n이 반복되어서 'in'이 아닌 'i'만 출력
select ltrim(addr,substr(addr,1,2)) "앞두글자를 제외한 글자", rtrim(addr,ltrim(addr,substr(addr,1,2))) "앞에 값을 rtrim 사용" from users;
select concat(rtrim(addr,ltrim(addr,substr(addr,1,2))),'*') "@@*" from users;
*/
select concat(substr(addr,1,2),'*') from users;
select '*' || name || '*' from users;
select concat(substr(jumin,1,2),'년') || concat(substr(jumin,3,2),'월') || concat(substr(jumin,5,2),'일') 생년월일 from users;
select decode(substr(jumin,instr(jumin,'-',1)+1,1),1,'남',2,'여') 성별 from users;

--28 ~ 30 추가문제
--select name 이름, jumin 주민번호, extract(year from systimestamp) - fn_age(jumin) 나이 from users;
--select name 이름, jumin 주민번호, fn_age(jumin) 나이 from users;
--
--create or replace function fn_age(val_jumin varchar2)
--return number
--is
--v_age number(4);
--begin
--    if substr(val_jumin,1,2) > substr(systimestamp,1,2) then
--        v_age := concat('19',substr(val_jumin,1,2));
--    else 
--        v_age := concat('20',substr(val_jumin,1,2));
--    end if;
--    return v_age;
--end fn_age;

select name 이름, rpad(substr(name,1,1),length(name),'*') "a***" from users;
select name 이름, grade 학년, decode(grade,1,name||'*',2,name||'%',3,name||'#',4,name||'!') 조건 from users;

--다른풀이
select name 이름, grade 학년, case 
when grade = 1 then name || '*'
when grade = 2 then name || '%'
when grade = 3 then name || '#'
when grade = 4 then name || '!'
end 조건
from users;

--Group by
select grade, count(*) 인원수
from users
group by grade 
order by grade;

select max(point) 최고점, min(point) 최저점,grade 학년, count(*) 인원수
from users
group by grade
order by grade;

--select max(point)
--from users
--group by grade;

select count(*) 인원수, grade
from users
where grade in (3,4)
group by grade;

select max(point) - min(point), count(*), grade
from users
where grade in (1,2)
group by grade;

select substr(jumin,1,2), count(*)
from users
group by substr(jumin,1,2);

select grade 학년, count(*) 인원수
from users
group by grade
having count(*) >= 3
order by grade;

select grade 학년, round(avg(point)) 평균, round((select avg(point) from users)) 전체평균
from users
group by grade
having avg(point) >= (select avg(point) from users);

select upper(name) 이름, point 점수
from users
where point = (select max(point) from users);

--그룹별로 가장 높은 점수를 획득한 사람의 이름과 점수는?
