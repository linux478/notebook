BEGIN TRANSACTION;
CREATE TABLE people (
   id INTEGER PRIMARY KEY autoincrement,
   first_name TEXT not null,
   last_name TEXT not null,
   type_name TEXT,
   active INTEGER DEFAULT 1 not null
);
INSERT INTO people VALUES(1,'Andy','Mather','Employee',1);
INSERT INTO people VALUES(2,'Alessandro','Broggi','Employee',1);
INSERT INTO people VALUES(3,'Blake','McGann','Employee',1);
INSERT INTO people VALUES(4,'Brandie','Rose','Employee',1);
INSERT INTO people VALUES(5,'Charles','King','Employee',1);
INSERT INTO people VALUES(6,'CJ','Sturtevant','Employee',1);
INSERT INTO people VALUES(7,'Cliff','Thompson','Employee',1);
INSERT INTO people VALUES(8,'Corey','Blake','Employee',1);
INSERT INTO people VALUES(9,'Donald','Burnell','Employee',1);
INSERT INTO people VALUES(10,'Erica','Schreib','Employee',1);
INSERT INTO people VALUES(11,'Eric','Yorton','Employee',1);
INSERT INTO people VALUES(12,'Gayle','Roberts','Employee',1);
INSERT INTO people VALUES(13,'Jennifer','Glasgow-Morales','Employee',1);
INSERT INTO people VALUES(14,'Greg','LaBrie','Employee',1);
INSERT INTO people VALUES(15,'Jennifer','Plencner','Employee',1);
INSERT INTO people VALUES(16,'Josh','Farrow','Employee',1);
INSERT INTO people VALUES(17,'John','Connelly','Employee',1);
INSERT INTO people VALUES(18,'John','Hood','Employee',1);
INSERT INTO people VALUES(19,'John','Linnertz','Employee',1);
INSERT INTO people VALUES(20,'Krystle','Porter','Employee',1);
INSERT INTO people VALUES(21,'Kyle','Bailey','Employee',1);
INSERT INTO people VALUES(22,'Larissa','Morales','Employee',1);
INSERT INTO people VALUES(23,'Lisa','Bukowski','Employee',1);
INSERT INTO people VALUES(24,'Mark','Omilanowicz','Employee',1);
INSERT INTO people VALUES(25,'Matt','Caughey','Employee',1);
INSERT INTO people VALUES(26,'Matt','Farrell','Employee',1);
INSERT INTO people VALUES(27,'Michael','Phillips','Employee',1);
INSERT INTO people VALUES(28,'Pete','Schwalm','Employee',1);
INSERT INTO people VALUES(29,'Phil','Mazza','Employee',1);
INSERT INTO people VALUES(30,'Rich','Maliani','Employee',1);
INSERT INTO people VALUES(31,'Rick','Lawless','Employee',1);
INSERT INTO people VALUES(32,'Ricky','Green','Employee',1);
INSERT INTO people VALUES(33,'Ryan','Daddario','Employee',1);
INSERT INTO people VALUES(34,'Sarah','Otto','Employee',1);
INSERT INTO people VALUES(35,'Shawn','Hager','Employee',1);
INSERT INTO people VALUES(36,'Susan','Ecker','Employee',1);
INSERT INTO people VALUES(37,'Wren','Metcalf','Employee',1);
CREATE TABLE phone_extension (
   id INTEGER PRIMARY KEY autoincrement,
   extension TEXT not null,
   fk_people integer not null,
   foreign key (fk_people) REFERENCES people (id)
);
INSERT INTO phone_extension VALUES(1,'4005',1);
INSERT INTO phone_extension VALUES(2,'4416',2);
INSERT INTO phone_extension VALUES(3,'4004',3);
INSERT INTO phone_extension VALUES(4,'4012',4);
INSERT INTO phone_extension VALUES(5,'4005',5);
INSERT INTO phone_extension VALUES(6,'4014',6);
INSERT INTO phone_extension VALUES(7,'4007',7);
INSERT INTO phone_extension VALUES(8,'4014',8);
INSERT INTO phone_extension VALUES(9,'4011',9);
INSERT INTO phone_extension VALUES(10,'4009',10);
INSERT INTO phone_extension VALUES(11,'4040',11);
INSERT INTO phone_extension VALUES(12,'4016',12);
INSERT INTO phone_extension VALUES(13,'4020',13);
INSERT INTO phone_extension VALUES(14,'4419',14);
INSERT INTO phone_extension VALUES(15,'4023',15);
INSERT INTO phone_extension VALUES(16,'4014',16);
INSERT INTO phone_extension VALUES(17,'4012',17);
INSERT INTO phone_extension VALUES(18,'4474',18);
INSERT INTO phone_extension VALUES(19,'4026',19);
INSERT INTO phone_extension VALUES(20,'4010',20);
INSERT INTO phone_extension VALUES(21,'4045',21);
INSERT INTO phone_extension VALUES(22,'4001',22);
INSERT INTO phone_extension VALUES(23,'4050',23);
INSERT INTO phone_extension VALUES(24,'4015',24);
INSERT INTO phone_extension VALUES(25,'4006',25);
INSERT INTO phone_extension VALUES(26,'4051',26);
INSERT INTO phone_extension VALUES(27,'4012',27);
INSERT INTO phone_extension VALUES(28,'4032',28);
INSERT INTO phone_extension VALUES(29,'4021',29);
INSERT INTO phone_extension VALUES(30,'4038',30);
INSERT INTO phone_extension VALUES(31,'4052',31);
INSERT INTO phone_extension VALUES(32,'4018',32);
INSERT INTO phone_extension VALUES(33,'4033',33);
INSERT INTO phone_extension VALUES(34,'4418',34);
INSERT INTO phone_extension VALUES(35,'4022',35);
INSERT INTO phone_extension VALUES(36,'4027',36);
CREATE TABLE todo (
   id INTEGER PRIMARY KEY autoincrement,
   description TEXT not null,
   due_date REAL not null,
   finish_date REAL,
   status TEXT not null,
   category TEXT
);
INSERT INTO todo VALUES(1,"SPC;42(C)",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(2,"Training - PLANT MASTER FILE",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(3,"SPC;58(1.0)",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(4,"SAFETY 05",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(5,"SPB;22(D)(3.0)",julianday("2021-01-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(6,"SPC;46(B)(C)(1.5)",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(7,"SPF;113(B)(11.2)",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(8,"SPC;58(1.2)",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(9,"SPC;58",julianday("2021-02-15"),julianday("2021-02-17"),"DONE","TRAINING");
INSERT INTO todo VALUES(10,"SPF;100(A)(B)(1.0)",julianday("2021-01-15"),julianday("2021-02-17"),"DONE","TRAINING");
CREATE TABLE timecard (
   id INTEGER PRIMARY KEY autoincrement,
   clock_in REAL not null,
   clock_out REAL,
   lunch integer,
   pay_type TEXT
);
INSERT INTO timecard VALUES(1,julianday("2021-02-15 08:00"),julianday("2021-02-15 16:00"),0,"HOLIDAY");
INSERT INTO timecard VALUES(2,julianday("2021-02-16 07:23"),julianday("2021-02-16 16:49"),1,"WORK");
INSERT INTO timecard VALUES(3,julianday("2021-02-17 07:16"),julianday("2021-02-17 16:05"),1,"WORK");
INSERT INTO timecard VALUES(4,julianday("2021-02-18 07:54"),julianday("2021-02-18 15:48"),1,"WORK");
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('people',37);
INSERT INTO sqlite_sequence VALUES('phone_extension',36);
INSERT INTO sqlite_sequence VALUES('todo',11);
INSERT INTO sqlite_sequence VALUES('timecard',5);
COMMIT;

.header on
.mode column

SELECT strftime('%W',clock_in) AS 'weekofyear',
       sum(
       CASE when lunch = 1 then round(Cast (( JulianDay(clock_out) - JulianDay(clock_in)) * 24 - .5 As REAL),2)
            when lunch = 0 then round(Cast (( JulianDay(clock_out) - JulianDay(clock_in)) * 24 As REAL),2)
       END) as "total_time"
FROM timecard
GROUP BY weekofyear;