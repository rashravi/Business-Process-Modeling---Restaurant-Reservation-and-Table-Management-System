
--Queries--
--Give reservation details for the customer Bob Marley.
Select r.ReservationID,r.CustomerID,r.ReservationDate,r.ReservationTime,r.ReservationType, c.FirstName, c.LastName from Reservation r
Join Customer c
on c.CustomerID=r.CustomerID
Where c.FIRSTNAME='Bob'And c.LASTNAME='Marley';

--Give details of Items ordered by Table-5 on 12/04/2017
Select ord.ORDERDATE, ord.TABLEID, ordl.ITEMID FROM ORDER_H ord
JOIN ORDERLINE ordl
on ord.ORDERID= ordl.ORDERID
JOIN MENU m
on m.ITEMID= ordl.ITEMID
where ord.TABLEID=5 AND ord.ORDERDATE= '12/04/2017'

--Select all the desserts available from the food menu
SELECT fm.MENUSECTION,m.ITEMNAME from FOODMENU fm
JOIN Menu m
on fm.F_ITEMID= m.ITEMID
where fm.MENUSECTION='Dessert';

--List the Head server for each Section Id displayed along with Section Name
SELECT DISTINCT a.SECTIONID AS "Section ID",
b.SERVERNAME AS "Supervisor Name",
c.SectionName AS "Section Name"
FROM SERVER a, SERVER b, SECTION c
WHERE a.HEADSERVERID = b.SERVERID AND c.SECTIONID= a.SECTIONID;

--What is average wait time for Inperson reservations
SELECT avg(WaitTimeinMin) FROM INPERSON;

--Give details of the number of times, section 1 has been preferred in the month of November
select COUNT(*)as "Total Reservations" from (
Select ord.ORDERDATE, ord.TABLEID FROM ORDER_H ord
JOIN Table_H th
on th.tableid = ord.tableid
JOIN ORDERLINE ordl
on ord.ORDERID= ordl.ORDERID
JOIN MENU m
on m.ITEMID= ordl.ITEMID
where ord.TABLEID in (1,2,3) and ord.orderdate like '11/%%/2017') x

-- List the customer who visited the most in November--
--This customer will receive Surprise free membership for the restaurant’s loyalty membership program
create view Novinfo as
select x.customerid,count(x.customerid) as visit,x.firstname,x.lastname,sum(x.customerbill)as total from (
select c.customerid,c.FIRSTNAME,c.lastname,r.reservationid,o.CUSTOMERBILL from customer c
join reservation r
on c.customerid = r.customerid
join table_reservation tr
on r.reservationid = tr.reservationid
join table_h t
on tr.tableid = t.tableid
join order_h o
on t.tableid = o.tableid
where o.orderdate like '11/%%/2017' and  r.reservationdate like '11/%%/2017') x
group by x.customerid,x.firstname,x.lastname

SELECT v.*
FROM Novinfo v
where v.visit=(
SELECT MAX(visit)
from novinfo);


--Average no of people per reservation in november and december--
--To evaluate the crowd during holiday season and prepare for upcoming peak seasons
-- Changes with respect to addition of tables, servers can be made based on this query
select avg(t.no_ofpersons)as "Avg No.of people per res" from reservation r
left join table_reservation t
on r.reservationid = t.reservationid
where r.reservationdate like '11/%%/2017' or r.reservationdate like '12/%%/2017'

--Which section has most number of reservations overall--
--This will help the restaurant to market the popular area or set it as it's trademark
-- More number of tables can be put in the popular section
CREATE VIEW RES_SECTION AS
SELECT t.sectionid,s.sectionname, COUNT(tr.reservationid) as No_of_res FROM table_reservation tr
join table_h t
on tr.tableid = t.tableid
join section s
on s.sectionid = t.sectionid
group by t.sectionid,s.sectionname

SELECT v.*
FROM res_section v
where v.No_of_res=(
SELECT MAX(No_of_res)
from res_section);


--Person who made the highest bill with just one visit--
-- This customer will receive one time discount voucher for the next visit
create view view1 as
select x.customerid,count(x.customerid) as visit,x.firstname,x.lastname,sum(x.customerbill)as total from (
select c.customerid,c.FIRSTNAME,c.lastname,r.reservationid,o.CUSTOMERBILL from customer c
join reservation r
on c.customerid = r.customerid
join table_reservation tr
on r.reservationid = tr.reservationid
join table_h t
on tr.tableid = t.tableid
join order_h o
on t.tableid = o.tableid
where o.orderdate = r.reservationdate ) x
group by x.customerid,x.firstname,x.lastname

SELECT v.*
FROM view1 v
where v.total=(
SELECT MAX(total)
FROM view1
where visit=1);

--List the details which shows the servers and the bills that were made under
--their service along with tips in descending order of bill amount.
-- To evaluate server staff and consider as factor when deciding on the "Best server"
SELECT serverid,sum(customerbill) as Server_bill,count(orderid) as no_of_orders,
sum(tip)as Server_tip,round((sum(tip)/count(orderid)),2) as tip_per_order from order_h
group by serverid
order by server_bill desc;


--Find out which servers are assigned to which table in Sea-facing section
SELECT s1.serverid, s1.servername, t.tableid, s.sectionname
FROM server s1
JOIN section s
ON s1.sectionid = s.sectionid
JOIN table_h t
ON s.sectionid = t.sectionid
WHERE s.sectionname = 'Sea-facing';

--What were the Item Names ordered on 11/04/2017
SELECT o.orderdate, ol.itemid,m.itemname, o.tableid
FROM order_h o
JOIN orderline ol
ON o.orderid = ol.orderid
JOIN menu m
ON ol.itemid = m.itemid
WHERE o.orderdate = '11/04/2017';


--Give all details of ItemID - 109
SELECT m.* , w.*
FROM Menu m
JOIN winemenu w
ON m.itemid = w.w_itemid
WHERE m.itemid = 109;


-- Display customer phone number for reservation 7 PM on 11/04/2017
select tl.*
from reservation r
join telephone tl
ON r.reservationid = tl.t_reservationid
WHERE r.reservationtime = '7 PM'AND r.reservationdate = '11/04/2017';

--What items did customer Bob Marley order ?
SELECT c.firstname, c.lastname, m.itemname, m.itemcost
FROM CUSTOMER C
JOIN RESERVATION R
ON C.customerid = r.customerid
JOIN Table_Reservation tr
ON r.reservationid = tr.reservationid
JOIN Order_H O
ON tr.tableid= o.tableid
JOIN orderline ol
ON o.orderid = ol.orderid
JOIN Menu m
ON ol.itemid = m.itemid
WHERE c.firstname = 'Bob' AND c.lastname='Marley';
