Drop table Customer cascade constraints;
Drop table Table_H cascade constraints;
Drop table Table_Reservation cascade constraints;
Drop table Order_H cascade constraints;
Drop table OrderLine cascade constraints;
Drop table Reservation cascade constraints;
Drop table InPerson cascade constraints;
Drop table Telephone cascade constraints;
Drop table Online_R cascade constraints;
Drop table Section cascade constraints;
Drop table Server cascade constraints;
Drop table Menu cascade constraints;
Drop table FoodMenu cascade constraints;
Drop table WineMenu cascade constraints;



CREATE TABLE Customer(
CustomerID number (5) primary key,
FirstName varchar2(30),
LastName varchar2(30),
DateOfBirth varchar2(30),
CustomerPhone number(10)
);

CREATE TABLE Reservation (
ReservationID int primary key,
CustomerID int,
ReservationDate varchar(20),
ReservationTime varchar(20),
ReservationType varchar(20)
            CHECK(ReservationType IN ('InPerson','Telephone','Online_R')),
foreign key (CustomerID) references Customer(CustomerID)
            );

CREATE TABLE InPerson (
I_ReservationID INT Primary key,
WaitTimeinMin INT,
foreign key(I_ReservationID) references Reservation(ReservationID)
);

CREATE TABLE Telephone (
T_ReservationID INT Primary key,
Tel_confirmation varchar(20),
foreign key(T_ReservationID) references Reservation(ReservationID)
);

CREATE TABLE Online_R (
O_ReservationID INT primary key,
AppName varchar(20),
EmailAddress varchar(30),
foreign key(O_ReservationID) references Reservation(ReservationID)
);

CREATE TABLE Section (
SectionID int primary key,
SectionName varchar(20)
);

CREATE TABLE Server (
ServerID int primary key,
HeadServerID int,
SectionID int,
ServerName varchar(50),
foreign key (SectionID) references Section(SectionID),
foreign key (HeadServerID) references Server(ServerID)
);

CREATE TABLE Table_H (
TableID int primary key,
SectionID int,
foreign key(SectionID) references Section(SectionID)
);


CREATE TABLE Table_Reservation (
TableID int,
ReservationID int,
No_OfPersons int,
primary key(TableID, ReservationID),
foreign key(TableID) references Table_H(TableID),
foreign key(ReservationID) references Reservation(ReservationID)
);

CREATE TABLE Menu (
ItemID int primary key,
ItemName varchar(100),
ItemCost int,
ItemType varchar(50)
            CHECK(ItemType IN ('FoodMenu','WineMenu'))
);

CREATE TABLE FoodMenu (
F_ItemID int primary key,
MenuSection varchar(50),
foreign key (F_ItemID) references Menu(ItemID)
);

CREATE TABLE WineMenu (
W_ItemID int primary key,
AlchoholContent decimal,
WineType varchar(30),
foreign key (W_ItemID) references Menu(ItemID)
);



CREATE TABLE Order_H(
OrderID int primary key,
ServerID int,
TableID int,
CustomerBill varchar(10),
OrderDate varchar(10),
Tip int,
foreign key(ServerID) references Server(ServerID),
foreign key(TableID) references Table_H(TableID)
);

CREATE TABLE OrderLine(
OrderLineID int primary key,
ItemID int,
OrderID int,
Quantity int,
foreign key(ItemID) references Menu(ItemID),
foreign key(OrderID) references Order_H(OrderID)
);

INSERT INTO Customer VALUES (01,'Alex','Zverev', '02/03/1996', '2055504568');
INSERT INTO Customer VALUES (02,'Alex','Patel', '02/03/1996', '2056504568');
INSERT INTO Customer VALUES (03,'Riley','Stevens', '09/03/1967', '2055556988');
INSERT INTO Customer VALUES (04,'Vera','Wang', '02/08/1946', '2057789568');
INSERT INTO Customer VALUES (05,'Rick','Morty', '07/03/1896', '2089504568');
INSERT INTO Customer VALUES (06,'Bob','Marley', '02/22/1995', '2056604568');
INSERT INTO Customer VALUES (07,'Jack','Ma', '10/03/1991', '2056504569');
INSERT INTO Customer VALUES (08,'Tim','Stevens', '09/03/1968', '2055526988');
INSERT INTO Customer VALUES (09,'Vera','Mindy', '03/08/1941', '2057769568');
INSERT INTO Customer VALUES (10,'Sergio','Ramos', '10/03/1896', '2089404568');


INSERT INTO Reservation VALUES (001,04,'12/04/2017','7 PM','InPerson');
INSERT INTO Reservation VALUES (002,05,'12/08/2017','2 PM','Online_R');
INSERT INTO Reservation VALUES (003,03,'11/04/2017','7 PM','Telephone');
INSERT INTO Reservation VALUES (004,10,'11/04/2017','2 PM','InPerson');
INSERT INTO Reservation VALUES (005,02,'06/04/2017','9 PM','Telephone');
INSERT INTO Reservation VALUES (006,03,'11/05/2017','6 PM','InPerson');
INSERT INTO Reservation VALUES (007,05,'11/04/2017','12 PM','Online_R');
INSERT INTO Reservation VALUES (008,07,'11/04/2017','4 PM','Telephone');
INSERT INTO Reservation VALUES (009,01,'05/09/2017','2 PM','InPerson');
INSERT INTO Reservation VALUES (010,02,'08/05/2017','9 PM','Telephone');
INSERT INTO Reservation VALUES (011,08,'12/04/2017','7 PM','InPerson');
INSERT INTO Reservation VALUES (012,08,'11/09/2017','1 PM','Online_R');
INSERT INTO Reservation VALUES (013,03,'11/01/2017','7 PM','Online_R');
INSERT INTO Reservation VALUES (014,09,'05/11/2017','2 PM','InPerson');
INSERT INTO Reservation VALUES (015,06,'06/05/2017','9 PM','Online_R');



INSERT INTO InPerson VALUES (001,30);
INSERT INTO InPerson VALUES (004,20);
INSERT INTO InPerson VALUES (006,30);
INSERT INTO InPerson VALUES (009,20);
INSERT INTO InPerson VALUES (011,30);
INSERT INTO InPerson VALUES (014,20);



INSERT INTO Telephone VALUES (003,'1a');
INSERT INTO Telephone VALUES (005,'2b');
INSERT INTO Telephone VALUES (008,'3a');
INSERT INTO Telephone VALUES (010,'4d');



INSERT INTO Online_R VALUES (002,'GrubHub','mor.rick@gmail.com');
INSERT INTO Online_R VALUES (007,'Zomato','mor.rick@gmail.com');
INSERT INTO Online_R VALUES (012,'Yelp','tim.stevens@gmail.com');
INSERT INTO Online_R VALUES (013,'Zomato','riley.stevens@gmail.com');
INSERT INTO Online_R VALUES (015,'Yelp','vera.mindy@gmail.com');



INSERT INTO Section(SectionID,SectionName) VALUES (1, 'Sea-facing');
INSERT INTO Section(SectionID,SectionName) VALUES (2, 'Center');
INSERT INTO Section(SectionID,SectionName) VALUES (3, 'lawn-facing');



INSERT INTO Server(ServerID,SectionID,Servername) VALUES (01, 1, 'Peter');
INSERT INTO Server(ServerID,SectionID,Servername,HeadServerID) VALUES (02, 1, 'Jack', 01);
INSERT INTO Server(ServerID,SectionID,SERVERNAME) VALUES (03, 2, 'Harry');
INSERT INTO Server(ServerID,SectionID,SERVERNAME,HEADSERVERID) VALUES (04, 2, 'Tom',03);
INSERT INTO Server(ServerID,SectionID,SERVERNAME) VALUES (05, 3, 'Mitchel');
INSERT INTO Server(ServerID,SectionID,SERVERNAME,HEADSERVERID) VALUES (06, 3, 'Anthony', 05);



INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (01,1);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (02,1);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (03,1);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (04,2);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (05,2);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (06,2);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (07,3);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (08,3);
INSERT INTO Table_H(TABLEID,SECTIONID) VALUES (09,3);



INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (01, 003, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (02, 004, 2);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (01, 007, 5);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (05, 001, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (02, 002, 3);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (03, 005, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (07, 006, 3);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (08, 008, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (09, 009, 3);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (02, 010, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (01, 011, 3);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (04, 012, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (05, 013, 3);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (07, 014, 4);
INSERT INTO Table_Reservation(TableID,ReservationID,No_OfPersons) VALUES (09, 015, 3);



INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (111, 01, 01,'56.23','11/04/2017',3);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (112, 02, 02,'100.23','11/04/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (113, 02, 03,'140.23','11/04/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (114, 04, 05,'56.23','12/04/2017',3);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (115, 01, 02,'160.23','12/08/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (116, 01, 03,'100.23','06/04/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (117, 06, 07,'52.23','11/05/2017',3);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (118, 05, 08,'120.23','11/04/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (119, 06, 09,'100.23','05/09/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (120, 02, 02,'79.23','08/05/2017',3);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (121, 01, 01,'300.23','12/04/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (122, 04, 04,'105.23','11/09/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (123, 03, 05,'1000.23','11/01/2017',3);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (124, 05, 07,'10.23','05/11/2017',5);
INSERT INTO ORDER_H(ORDERID,SERVERID,TABLEID,CUSTOMERBILL,ORDERDATE,TIP) VALUES (125, 05, 09,'190.23','06/05/2017',5);


INSERT INTO MENU VALUES('101','Crab Cakes','15','FoodMenu');
INSERT INTO MENU VALUES('102','Bruschetta','8','FoodMenu');
INSERT INTO MENU VALUES('103','italian Hot Peppers','12','FoodMenu');
INSERT INTO MENU VALUES('104','Caesar','12','FoodMenu');
INSERT INTO MENU VALUES('105','Rigatoni Bolognese','25','FoodMenu');
INSERT INTO MENU VALUES('106','Margherita Pizza','10','FoodMenu');
INSERT INTO MENU VALUES('107','Caramel Custard','15','FoodMenu');
INSERT INTO MENU VALUES('108','Panna Cotta','20','FoodMenu');
INSERT INTO MENU VALUES('109','Prosecco ','60','WineMenu');
INSERT INTO MENU VALUES('110','Lombardia','50','WineMenu');
INSERT INTO MENU VALUES('200','Cabernet','72','WineMenu');



INSERT INTO FOODMENU VALUES('101','Appetizers');
INSERT INTO FOODMENU VALUES('102','Appetizers');
INSERT INTO FOODMENU VALUES('103','Salad');
INSERT INTO FOODMENU VALUES('104','Salad');
INSERT INTO FOODMENU VALUES('105','MainCourse');
INSERT INTO FOODMENU VALUES('106','MainCourse');
INSERT INTO FOODMENU VALUES('107','Dessert');
INSERT INTO FOODMENU VALUES('108','Dessert');


INSERT INTO WINEMENU VALUES('109','12.5','White Wine');
INSERT INTO WINEMENU VALUES('110','14.5','Red Wine');
INSERT INTO WINEMENU VALUES('200','14.5','Red Wine');



INSERT INTO ORDERLINE VALUES('0101','101','111','1');
INSERT INTO ORDERLINE VALUES('0102','102','112','2');
INSERT INTO ORDERLINE VALUES('0103','103','113','3');
INSERT INTO ORDERLINE VALUES('0104','107','114','1');
INSERT INTO ORDERLINE VALUES('0105','105','115','2');
INSERT INTO ORDERLINE VALUES('0106','106','116','3');
INSERT INTO ORDERLINE VALUES('0107','107','117','1');
INSERT INTO ORDERLINE VALUES('0108','108','118','2');
INSERT INTO ORDERLINE VALUES('0109','109','119','3');
INSERT INTO ORDERLINE VALUES('0110','110','120','1');
INSERT INTO ORDERLINE VALUES('0111','200','121','2');
INSERT INTO ORDERLINE VALUES('0112','103','122','3');
INSERT INTO ORDERLINE VALUES('0113','107','123','1');
INSERT INTO ORDERLINE VALUES('0114','104','124','2');
INSERT INTO ORDERLINE VALUES('0115','108','125','3');
