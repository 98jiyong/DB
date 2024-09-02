create table hm(
no number(2),
name varchar2(10),
point number(3),
addr varchar2(10)
);

insert into hm values(1, '홍길동', 30, '서울시');
insert into hm values(2, '일지매', 50, '수원');
insert into hm values(3, '이지매', 40, '서울');
insert into hm values(4, '성시골', 60, '대전');

select COUNT(*) from hm where point < 50; /* hm 테이블에서 point 컬럼에 값이 50 미만인 갯수 세기 */
select name ,point from hm where point <= 50; /*  */
select * from hm where point < 50 order by point desc;
drop table help;
commit;
