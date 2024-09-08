
CREATE TABLE `client` (
  `user_id` varchar(10) DEFAULT NULL,
  `user_pw` varchar(10) NOT NULL,
  `user_name` varchar(10) DEFAULT NULL,
  `user_age` int(3) DEFAULT 20,
  `user_tel` varchar(13) NOT NULL,
  PRIMARY KEY (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `train` (
  `tr_id` varchar(3) NOT NULL,
  `tr_name` varchar(20) NOT NULL,
  `tr_type` varchar(10) NOT NULL,
  PRIMARY KEY (`tr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `station` (
  `st_id` varchar(3) NOT NULL,
  `st_name` varchar(20) NOT NULL,
  `st_distance` varchar(10) NOT NULL,
  PRIMARY KEY (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `seat` (
  `seat_id` varchar(2) NOT NULL,
  `seat_name` varchar(10) NOT NULL,
  PRIMARY KEY (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `schedule` (
  `sch_id` varchar(3) NOT NULL,
  `sch_time` timestamp NOT NULL,
  `s_st` varchar(3) NOT NULL,
  `e_st` varchar(3) NOT NULL,
  `tr_id` varchar(3) NOT NULL,
  PRIMARY KEY (`sch_id`),
  KEY `schedule_station_FK` (`s_st`),
  KEY `schedule_station_FK_1` (`e_st`),
  KEY `schedule_train_FK` (`tr_id`),
  CONSTRAINT `schedule_station_FK` FOREIGN KEY (`s_st`) REFERENCES `station` (`st_id`),
  CONSTRAINT `schedule_station_FK_1` FOREIGN KEY (`e_st`) REFERENCES `station` (`st_id`),
  CONSTRAINT `schedule_train_FK` FOREIGN KEY (`tr_id`) REFERENCES `train` (`tr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `reservation` (
  `user_tel` varchar(13) NOT NULL,
  `sch_id` varchar(3) NOT NULL,
  `res_time` timestamp NOT NULL,
  `seat_id` varchar(2) NOT NULL,
  `origin_price` int(10) NOT NULL,
  `sale_info` varchar(50) NOT NULL,
  `sale_price` int(10) NOT NULL,
  PRIMARY KEY (`user_tel`,`sch_id`),
  KEY `reservation_schedule_FK` (`sch_id`),
  KEY `reservation_seat_FK` (`seat_id`),
  CONSTRAINT `reservation_client_FK` FOREIGN KEY (`user_tel`) REFERENCES `client` (`user_tel`),
  CONSTRAINT `reservation_schedule_FK` FOREIGN KEY (`sch_id`) REFERENCES `schedule` (`sch_id`),
  CONSTRAINT `reservation_seat_FK` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `notice` (
  `ntc_id` varchar(3) NOT NULL,
  `user_tel` varchar(13) NOT NULL,
  `ntc_title` varchar(50) NOT NULL,
  `ntc_text` varchar(200) NOT NULL,
  `ntc_time` timestamp NOT NULL,
  `ntc_visit` int(4) NOT NULL,
  PRIMARY KEY (`ntc_id`),
  KEY `notice_client_FK` (`user_tel`),
  CONSTRAINT `notice_client_FK` FOREIGN KEY (`user_tel`) REFERENCES `client` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `reply` (
  `rep_id` varchar(2) NOT NULL,
  `rep_text` varchar(200) NOT NULL,
  `ntc_id` varchar(2) NOT NULL,
  PRIMARY KEY (`rep_id`),
  KEY `reply_notice_FK` (`ntc_id`),
  CONSTRAINT `reply_notice_FK` FOREIGN KEY (`ntc_id`) REFERENCES `notice` (`ntc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


LOAD DATA LOCAL INFILE 'C:/Workspace/Maria/자료/client.txt' 
INTO TABLE client
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'

insert into client values('enjfn', 'sklfk122', '정이신', 30, '010-1111-2222');
insert into client values('wjdwldyd', '45657', '김지균', 20, '010-2222-3535');
insert into client values('dlaudrbs', 'ajskljf', '이태용', 45, '010-3333-2785');
insert into client values('tlsxogjs', 'djkslj44', '신정건', 78, '010-4444-4518');
insert into client values('rlaxogks', 'sjkgljn1', '이태환', 18, '010-5555-4563');
insert into client values('amanda','manda123','아만다',44,'010-2293-5868');
insert into client values('jiyong','1111','정지용',27,'010-8740-5966');
insert into client values('Brad','1963','브래드피트',61,'010-9433-5732');
insert into client values('taeha','tae9999','태하',4,'010-3239-6679');
insert into client values('presi','dent2024','윤석열',63,'010-2217-4782');

select * from client;

insert into Train values('K01','KTX-T001','KTX');
insert into Train values('K02','KTX-T002','KTX');
insert into Train values('K03','KTX-T003','KTX');
insert into Train values('K04','KTX-T004','KTX');
insert into Train values('S11','SRT-T011','SRT');
insert into Train values('S12','SRT-T012','SRT');
insert into Train values('S13','SRT-T013','SRT');
insert into Train values('S14','SRT-T014','SRT');
insert into Train values('S15','SRT-T015','SRT');
insert into Train values('I23','ITX-T023','ITX');
insert into Train values('I24','ITX-T024','ITX');
insert into Train values('I25','ITX-T025','ITX');
insert into Train values('I26','ITX-T026','ITX');
insert into Train values('I27','ITX-T027','ITX');
insert into Train values('I28','ITX-T028','ITX');
insert into Train values('M32','새마을호-T032','새마을');
insert into Train values('M33','새마을호-T033','새마을');
insert into Train values('M34','새마을호-T034','새마을');
insert into Train values('M35','새마을호-T035','새마을');
insert into Train values('M36','새마을호-T036','새마을');
insert into Train values('M37','새마을호-T037','새마을');
insert into Train values('I45','ITX-청춘05','ITX-청춘');
insert into Train values('I46','ITX-청춘06','ITX-청춘');
insert into Train values('I47','ITX-청춘07','ITX-청춘');
insert into Train values('I48','ITX-청춘08','ITX-청춘');
insert into Train values('I49','ITX-청춘09','ITX-청춘');
insert into Train values('N56','누리호-T088','누리호');
insert into Train values('N57','누리호-T089','누리호');
insert into Train values('N58','누리호-T090','누리호');
insert into Train values('N59','누리호-T091','누리호');
insert into Train values('N60','누리호-T092','누리호');

select * from train;

insert into station values('s01','서울역',1);
insert into station values('s02','부산역',2);
insert into station values('s03','인천역',3);
insert into station values('s04','대구역',4);
insert into station values('s05','광주역',5);
insert into station values('s06','대전역',6);
insert into station values('s07','수원역',7);
insert into station values('s08','전주역',8);
insert into station values('s09','창원역',9);
insert into station values('s10','경주역',10);
insert into station values('s11','속초역',11);
insert into station values('s12','청주역',12);
insert into station values('s13','제주역',13);
insert into station values('s14','용산역',14);
insert into station values('s15','강릉역',15);
insert into station values('s16','원주역',16);
insert into station values('s17','울산역',17);
insert into station values('s18','평택역',18);
insert into station values('s19','아산역',19);
insert into station values('s20','익산역',20);

select * from station;

insert into schedule values('e07','2024-09-06 08:00:00','s08','s05','N60');
insert into schedule values('e16','2024-09-10 09:30:00','s01','s09','I27');
insert into schedule values('e22','2024-09-21 08:00:00','s03','s15','K01');
insert into schedule values('e23','2024-09-21 08:00:00','s03','s15','K02');
insert into schedule values('e24','2024-09-21 19:00:00','s15','s03','K03');
insert into schedule values('e35','2024-09-22 10:00:00','s10','s17','S11');
insert into schedule values('e36','2024-09-22 10:00:00','s11','s14','S12');
insert into schedule values('e37','2024-09-22 20:00:00','s14','s11','S11');
insert into schedule values('e38','2024-09-22 20:00:00','s17','s10','S12');
insert into schedule values('e40','2024-09-30 10:30:00','s06','s16','M34');

select * from schedule;
