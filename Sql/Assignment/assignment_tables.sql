CREATING A AIRLINE FLIGHT MANAGEMENT SYSTEM USING POSTGRESQL.

!----------------------------CREATION OF DATABASE----------------------------!

command:-  create database Flights;



!----------------------------CREATION OF TABLES------------------------------!

CREATE TABLE Flights (
    flno INTEGER PRIMARY KEY,
    "from" VARCHAR(50),
    "to" VARCHAR(50),
    distance INTEGER,
    departs TIME,
    arrives TIME,
    price INTEGER
);

CREATE TABLE Aircraft (
    aid INTEGER PRIMARY KEY,
    aname VARCHAR(50),
    cruisingrange INTEGER
);

CREATE TABLE Employees (
    eid INTEGER PRIMARY KEY,
    ename VARCHAR(50),
    salary INTEGER
);

CREATE TABLE Certified (
    eid INTEGER,
    aid INTEGER,
    FOREIGN KEY (eid) REFERENCES Employees(eid),
    FOREIGN KEY (aid) REFERENCES Aircraft(aid)
);



!------------------INSERTION OF DATA IN TABLES-----------------------!

INSERT INTO Flights (flno, "from", "to", distance, departs, arrives, price) 
VALUES
(1, 'Los Angeles', 'New York', 2475, '07:00', '15:30', 70000),
(2, 'Chicago', 'Los Angeles', 1745, '08:00', '11:30', 20000),
(3, 'Los Angeles', 'Honolulu', 2550, '09:00', '12:00', 100000),
(4, 'San Francisco', 'Chicago', 1850, '10:00', '14:30', 250000),
(5, 'Seattle', 'Boston', 2480, '11:00', '19:30', 35000),
(6, 'Miami', 'Los Angeles', 2345, '12:00', '18:00', 33000),
(7, 'Dallas', 'San Francisco', 1460, '13:00', '16:00', 22000),
(8, 'Denver', 'Miami', 2075, '14:00', '20:00', 30000),
(9, 'Atlanta', 'Chicago', 595, '15:00', '17:00', 150000),
(10, 'Houston', 'Seattle', 1890, '16:00', '20:30', 28000),
(11, 'Los Angeles', 'Chicago', 1745, '17:00', '21:00', 27000),
(12, 'New York', 'Miami', 1090, '18:00', '21:30', 20000),
(13, 'Boston', 'Atlanta', 950, '19:00', '22:00', 180000),
(14, 'Las Vegas', 'San Francisco', 420, '20:00', '21:30', 10000),
(15, 'Portland', 'Denver', 980, '21:00', '23:30', 15000),
(16, 'Madison', 'Chicago', 120, '07:00:00', '08:00:00', 10000),
(17, 'Madison', 'Detroit', 250, '09:00:00', '11:00:00', 15000),
(18, 'Madison', 'Minneapolis', 270, '12:00:00', '13:30:00', 12000)
(19, 'Chicago', 'New York', 790, '09:00:00', '12:00:00', 20000),
(20, 'Detroit', 'New York', 520, '12:00:00', '14:00:00', 18000),
(21, 'Minneapolis', 'New York', 1020, '14:00:00', '17:00:00', 22000);

output: SELECT * FROM Flights;
 flno |     from      |      to       | distance | departs  | arrives  | price  
------+---------------+---------------+----------+----------+----------+--------
    1 | Los Angeles   | New York      |     2475 | 07:00:00 | 15:30:00 |  70000
    2 | Chicago       | Los Angeles   |     1745 | 08:00:00 | 11:30:00 |  20000
    3 | Los Angeles   | Honolulu      |     2550 | 09:00:00 | 12:00:00 | 100000
    4 | San Francisco | Chicago       |     1850 | 10:00:00 | 14:30:00 | 250000
    5 | Seattle       | Boston        |     2480 | 11:00:00 | 19:30:00 |  35000
    6 | Miami         | Los Angeles   |     2345 | 12:00:00 | 18:00:00 |  33000
    7 | Dallas        | San Francisco |     1460 | 13:00:00 | 16:00:00 |  22000
    8 | Denver        | Miami         |     2075 | 14:00:00 | 20:00:00 |  30000
    9 | Atlanta       | Chicago       |      595 | 15:00:00 | 17:00:00 | 150000
   10 | Houston       | Seattle       |     1890 | 16:00:00 | 20:30:00 |  28000
   11 | Los Angeles   | Chicago       |     1745 | 17:00:00 | 21:00:00 |  27000
   12 | New York      | Miami         |     1090 | 18:00:00 | 21:30:00 |  20000
   13 | Boston        | Atlanta       |      950 | 19:00:00 | 22:00:00 | 180000
   14 | Las Vegas     | San Francisco |      420 | 20:00:00 | 21:30:00 |  10000
   15 | Portland      | Denver        |      980 | 21:00:00 | 23:30:00 |  15000
   16 | Madison       | Chicago       |      120 | 07:00:00 | 08:00:00 |  10000
   17 | Madison       | Detroit       |      250 | 09:00:00 | 11:00:00 |  15000
   18 | Madison       | Minneapolis   |      270 | 12:00:00 | 13:30:00 |  12000
   19 | Chicago       | New York      |      790 | 09:00:00 | 12:00:00 |  20000
   20 | Detroit       | New York      |      520 | 12:00:00 | 14:00:00 |  18000
   21 | Minneapolis   | New York      |     1020 | 14:00:00 | 17:00:00 |  22000


INSERT INTO Aircraft (aid, aname, cruisingrange) 
VALUES
(1, 'Boeing 737', 3000),
(2, 'Airbus A320', 3500),
(3, 'Boeing 747', 8000),
(4, 'Embraer 190', 2500),
(5, 'Boeing 777', 7000),
(6, 'Airbus A380', 8500),
(7, 'Cessna 172', 800),
(8, 'Boeing 787', 7600),
(9, 'Airbus A350', 8100),
(10, 'Boeing 737 MAX', 3550),
(11, 'Boeing 757', 3900),
(12, 'Airbus A330', 6550),
(13, 'Bombardier CRJ200', 1500),
(14, 'Gulfstream G650', 7500),
(15, 'Boeing 767', 5900);

output: SELECT * FROM Aircraft;
 aid |       aname       | cruisingrange 
-----+-------------------+---------------
   1 | Boeing 737        |          3000
   2 | Airbus A320       |          3500
   3 | Boeing 747        |          8000
   4 | Embraer 190       |          2500
   5 | Boeing 777        |          7000
   6 | Airbus A380       |          8500
   7 | Cessna 172        |           800
   8 | Boeing 787        |          7600
   9 | Airbus A350       |          8100
  10 | Boeing 737 MAX    |          3550
  11 | Boeing 757        |          3900
  12 | Airbus A330       |          6550
  13 | Bombardier CRJ200 |          1500
  14 | Gulfstream G650   |          7500
  15 | Boeing 767        |          5900


INSERT INTO Employees (eid, ename, salary) 
VALUES
(1, 'John Doe', 95000),
(2, 'Jane Smith', 85000),
(3, 'Sam Brown', 80000),
(4, 'Mike Davis', 78000),
(5, 'Anna White', 87000),
(6, 'Chris Green', 120000),
(7, 'Patricia Black', 91000),
(8, 'Linda Blue', 94000),
(9, 'Robert Yellow', 99000),
(10, 'Michael Orange', 67000),
(11, 'William Pink', 73000),
(12, 'David Purple', 81000),
(13, 'Joseph Gray', 76000),
(14, 'Daniel Cyan', 92000),
(15, 'Matthew Red', 93000);

output: SELECT * FROM Employees;
SELECT * FROM Employees;
 eid |     ename      | salary 
-----+----------------+--------
   1 | John Doe       |  95000
   2 | Jane Smith     |  85000
   3 | Sam Brown      |  80000
   4 | Mike Davis     |  78000
   5 | Anna White     |  87000
   6 | Chris Green    | 120000
   7 | Patricia Black |  91000
   8 | Linda Blue     |  94000
   9 | Robert Yellow  |  99000
  10 | Michael Orange |  67000
  11 | William Pink   |  73000
  12 | David Purple   |  81000
  13 | Joseph Gray    |  76000
  14 | Daniel Cyan    |  92000
  15 | Matthew Red    |  93000


INSERT INTO Certified (eid, aid) 
VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7), (3, 8),
(4, 9),
(5, 10),
(6, 11),
(7, 12), (7, 13), (7, 14),
(8, 15),
(9, 1), (9, 5), (9, 8), (9, 10),
(10, 2),
(11, 3),
(12, 6), (12, 7),
(13, 14), (13, 15),
(14, 1), (14, 5),
(15, 4), (15, 8);

output: SELECT * FROM Certified;
 eid | aid 
-----+-----
   1 |   1
   1 |   2
   1 |   3
   2 |   4
   2 |   5
   3 |   6
   3 |   7
   3 |   8
   4 |   9
   5 |  10
   6 |  11
   7 |  12
   7 |  13
   7 |  14
   8 |  15
   9 |   1
   9 |   5
   9 |   8
   9 |  10
  10 |   2
  11 |   3
  12 |   6
  12 |   7
  13 |  14
  13 |  15
  14 |   1
  14 |   5
  15 |   4
  15 |   8

 <--------------------------------------------------------> 
