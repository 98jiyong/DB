
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



insert into client values('jiyong','1111','정지용',27,'010-8740-5966');
select * from client;





