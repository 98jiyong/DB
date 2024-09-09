select * from client;

select * from train;

select * from station;

delete from schedule;

insert into schedule values('s21','2024-09-12 08:34:00','s07','s17','M32',50000);
insert into schedule values('s22','2024-09-14 18:56:00','s01','s18','I46',85000);
insert into schedule values('s23','2024-09-13 11:05:00','s11','s15','N56',20000);
insert into schedule values('s24','2024-09-15 14:15:00','s19','s03','N60',80000);
insert into schedule values('s25','2024-09-13 15:52:00','s02','s14','K01',60000);
insert into schedule values('e07','2024-09-06 08:00:00','s08','s05','N60',15000);
insert into schedule values('e16','2024-09-10 09:30:00','s01','s09','I27',40000);
insert into schedule values('e22','2024-09-21 08:00:00','s03','s15','K01',60000);
insert into schedule values('e23','2024-09-21 08:00:00','s03','s15','K02',60000);
insert into schedule values('e24','2024-09-21 19:00:00','s15','s03','K03',60000);
insert into schedule values('e35','2024-09-22 10:00:00','s10','s17','S11',35000);
insert into schedule values('e36','2024-09-22 10:00:00','s11','s14','S12',15000);
insert into schedule values('e37','2024-09-22 20:00:00','s14','s11','S11',15000);
insert into schedule values('e38','2024-09-22 20:00:00','s17','s10','S12',35000);
insert into schedule values('e40','2024-09-30 10:30:00','s06','s16','M34',50000);
insert into schedule values('t51','2024-09-11 09:00:00','s02','s20','I46',90000);
insert into schedule values('t52','2024-09-11 10:00:00','s02','s20','I49',90000);
insert into schedule values('t43','2024-09-12 07:00:00','s08','s15','K01',35000);
insert into schedule values('t44','2024-09-14 15:45:00','s11','s02','K03',45000);
insert into schedule values('t45','2024-09-23 19:50:00','s19','s09','N56',50000);
select * from schedule;

delete from reply;
delete from notice;
show table status where name = 'reply';

insert into notice values('n01','010-8740-5966','화장실 건의','화장실 변기가 계속 막혀요','2024-09-06 12:23:15',22);
insert into notice values('n02','010-8740-5966','좌석 건의','기차 좌석이 너무 좁아요','2024-09-10 12:45:01',151);
insert into notice values('n15','010-1111-2222','컴플레인','역무원에 태도가 너무 무례한것 같아요','2024-09-25 23:45:01',332);
insert into notice values('n27','010-9433-5732','train delay complain','waiting too much time so boring!','2024-09-15 08:23:12',624);
insert into notice values('n34','010-8740-5966','Wǒ zài','Wǒ zài wǎngshang mǎi de ànmóyǐ, yòng le yí cì jiù ‘bàgōng’ le.','2024-09-21 17:30:01',13);
insert into notice values('n17','010-4444-4518','자리 확장 건의','추석에 자리를 예매하지 못해서 자리를 늘려주세요','2024-09-28 14:22:32',583);
insert into notice values('n18','010-3239-6679','간식','기차 안에 간식 종류가 궁금해요','2024-09-11 12:34:32',121);
insert into notice values('n21','010-2222-3535','화장실','기차 내부 화장실이 막혀서 못 사용해요','2024-09-18 21:54:32',5);
insert into notice values('n22','010-2217-4782','무임승차','기차를 무임승차 하는 사람이 있어요','2024-09-14 22:54:32',99);
insert into notice values('n31','010-2217-4782','미화관련','수원역 기차 탑승 구간이 너무 더러워요','2024-09-17 17:54:32',58);
select * from notice;
select * from reply;

delete from notice;
delete from reply;

(select user_age,
case 
	when user_age < 5 then  0.25
	when user_age < 12 then 0.5
	when user_age < 64 then 1
	else 0.7
end 
from client);

-- 가격에 대한 업데이트
update reservation
set origin_price = 
(select origin_price 
from schedule
where schedule.sch_id = reservation.sch_id);

-- 할인율에 대한 업데이트
update reservation set age_per = (select
case 
	when user_age < 5 then  0.25
	when user_age < 12 then 0.5
	when user_age < 64 then 1
	else 0.7
end 
from client where client.user_tel = reservation.user_tel);

-- 할인가격에 대한 업데이트
update reservation 
set sale_price = origin_price * age_per ;

select a.user_name as "예약자", a.user_age as "나이", d.res_time as "예약시간",
(select st_name from station where st_id = c.s_st) as "출발역",
(select st_name from station where st_id = c.e_st) as "도착역",
c.sch_time as "출발시간", b.tr_name as "기차정보", 
d.origin_price as "가격", concat(round((1 - d.age_per) * 100,0),"%할인") as "할인정보" ,
d.sale_price  as "할인 가격"
from client a, train b, schedule c, reservation d
where d.user_tel = a.user_tel 
and c.sch_id = d.sch_id
and c.tr_id = b.tr_id
order by "예약시간";

select s_st, sch_time
from schedule
where to_char(sch_time, 'YYYYMMDD')='20240922'
and s_st='s14';  // s14 -> 용산역;


create view Ticket_View as
select a.user_name as "예약자", a.user_age as "나이", d.res_time as "예약시간",
(select st_name from station where st_id = c.s_st) as "출발역",
(select st_name from station where st_id = c.e_st) as "도착역",
c.sch_time as "출발시간", b.tr_name as "기차정보", 
d.origin_price as "가격", concat(round((1 - d.age_per) * 100,0),"%할인") as "할인정보" ,
d.sale_price  as "할인 가격"
from client a, train b, schedule c, reservation d
where d.user_tel = a.user_tel 
and c.sch_id = d.sch_id
and c.tr_id = b.tr_id
order by "예약시간";

select date_format(출발시간,'%Y-%m-%d') as '출발일', count(*) from ticket_view tv group by date_format(출발시간,'%Y-%m-%d') order by 출발시간;
select 예약자, 기차정보 from ticket_view tv where 기차정보 like '누리호%';
select 예약자, 출발역 from ticket_view tv  where 출발역 = '부산역';
select "할인 가격" from ticket_view tv ;
select date_format(출발시간,'%Y-%m-%d') as '출발일', count(*), sum(할인가격) from ticket_view tv group by date_format(출발시간,'%Y-%m-%d') order by 출발시간;
