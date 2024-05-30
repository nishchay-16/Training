<!--------------------------DATABASE ASSIGNMENT SOLUTIONS---------------------------!>
               
            <!---AIRLINE FLIGHT INFORMATION MANAGEMENT SYSTEM---!>


Q1 Find the names of aircraft such that all pilots certified to operate them earn more than $80,000.
Ans:

SELECT a.aname as "Aircraft Name"
FROM aircraft a
JOIN certified c ON a.aid = c.aid
JOIN employees e ON c.eid = e.eid
GROUP BY a.aname
HAVING MIN(e.salary) > 80000;

output:
   Aircraft Name   
-------------------
 Boeing 737 MAX
 Embraer 190
 Boeing 737
 Boeing 777
 Bombardier CRJ200
 Airbus A330
 Boeing 757



Q2 For each pilot who is certified for more than three aircraft, find the eid and the maximum cruisingrange of the aircraft for which she or he is certified.
Ans:

SELECT c.eid, e.ename, MAX(a.cruisingrange) AS max_range 
FROM employees e 
JOIN certified c ON c.eid = e.eid 
JOIN aircraft a ON a.aid = c.aid 
GROUP BY c.eid, e.ename 
HAVING COUNT(c.aid) > 3;

output:
 eid |     ename     | max_range 
-----+---------------+-----------
   9 | Robert Yellow |      7600



Q3 Find the names of pilots whose salary is less than the price of the cheapest route from Los Angeles to Honolulu.
Ans:

SELECT e.ename
FROM Employees e
WHERE e.salary < (
    SELECT MIN(f.price)
    FROM Flights f
    WHERE f."from" = 'Los Angeles' AND f."to" = 'Honolulu'
);

output:
     ename      
----------------
 John Doe
 Jane Smith
 Sam Brown
 Mike Davis
 Anna White
 Patricia Black
 Linda Blue
 Robert Yellow
 Michael Orange
 William Pink
 David Purple
 Joseph Gray
 Daniel Cyan
 Matthew Red



Q4 For all aircraft with cruisingrange over 1000 miles, find the name of the aircraft and the average salary of all pilots certified for this aircraft.
Ans:

SELECT a.aname, AVG(e.salary) AS "Average Salary"
FROM Aircraft a
JOIN Certified c ON a.aid = c.aid
JOIN Employees e ON c.eid = e.eid
WHERE a.cruisingrange > 1000
GROUP BY a.aname;

output:
       aname       |   Average Salary    
-------------------+---------------------
 Boeing 737 MAX    |  93000.000000000000
 Airbus A380       |  80500.000000000000
 Airbus A320       |  81000.000000000000
 Airbus A350       |  78000.000000000000
 Boeing 767        |  85000.000000000000
 Embraer 190       |  89000.000000000000
 Boeing 787        |  90666.666666666667
 Boeing 737        |  95333.333333333333
 Boeing 777        |  92000.000000000000
 Bombardier CRJ200 |  91000.000000000000
 Airbus A330       |  91000.000000000000
 Boeing 757        | 120000.000000000000
 Boeing 747        |  84000.000000000000
 Gulfstream G650   |  83500.000000000000



Q5 Find the names of pilots certified for some Boeing aircraft.
Ans:

SELECT DISTINCT e.ename as "Pilots Name"
FROM Employees e
JOIN Certified c ON e.eid = c.eid
JOIN Aircraft a ON c.aid = a.aid
WHERE a.aname LIKE 'Boeing%';

output:
  Pilots Name  
---------------
 Anna White
 Chris Green
 Daniel Cyan
 Jane Smith
 John Doe
 Joseph Gray
 Linda Blue
 Matthew Red
 Robert Yellow
 Sam Brown
 William Pink



Q6 Find the aids of all aircraft that can be used on routes from Los Angeles to Chicago.
Ans:

SELECT a.aid as "ID" , a.aname as "Name"
FROM Aircraft a
JOIN Flights f ON a.cruisingrange >= f.distance
WHERE f."from" = 'Los Angeles' AND f."to" = 'Chicago';

output:
 ID |      Name       
----+-----------------
  1 | Boeing 737
  2 | Airbus A320
  3 | Boeing 747
  4 | Embraer 190
  5 | Boeing 777
  6 | Airbus A380
  8 | Boeing 787
  9 | Airbus A350
 10 | Boeing 737 MAX
 11 | Boeing 757
 12 | Airbus A330
 14 | Gulfstream G650
 15 | Boeing 767



Q7 Identify the routes that can be piloted by every pilot who makes more than $100,000.
Ans:

SELECT f."from", f."to"
FROM Flights f
WHERE NOT EXISTS (
    SELECT e.eid
    FROM Employees e
    WHERE e.salary > 100000
    AND NOT EXISTS (
        SELECT c.aid
        FROM Certified c
        JOIN Aircraft a ON c.aid = a.aid
        WHERE a.cruisingrange >= f.distance AND c.eid = e.eid
    )
);

OR

SELECT DISTINCT f."from",f."to"
            FROM certified c
            JOIN aircraft a ON a.aid=c.aid
            JOIN employees e ON e.eid=c.eid
            JOIN flights f ON a.cruisingrange>=f.distance
            WHERE e.salary>100000;

output:
     from      |      to       
---------------+---------------
 Los Angeles   | New York
 Chicago       | Los Angeles
 Los Angeles   | Honolulu
 San Francisco | Chicago
 Seattle       | Boston
 Miami         | Los Angeles
 Dallas        | San Francisco
 Denver        | Miami
 Atlanta       | Chicago
 Houston       | Seattle
 Los Angeles   | Chicago
 New York      | Miami
 Boston        | Atlanta
 Las Vegas     | San Francisco
 Portland      | Denver
 Madison       | Chicago
 Madison       | Detroit
 Madison       | Minneapolis
 Chicago       | New York
 Detroit       | New York
 Minneapolis   | New York



Q8 Print the enames of pilots who can operate planes with cruisingrange greater than 3000 miles but are not certified on any Boeing aircraft.
Ans:

SELECT e.ename as "Pilots Name"
FROM Employees e
JOIN Certified c ON e.eid = c.eid
JOIN Aircraft a ON c.aid = a.aid
WHERE a.cruisingrange > 3000
AND e.eid NOT IN (
    SELECT c2.eid
    FROM Certified c2
    JOIN Aircraft a2 ON c2.aid = a2.aid
    WHERE a2.aname LIKE 'Boeing%'
);

output:
  Pilots Name   
----------------
 Mike Davis
 Patricia Black
 Patricia Black
 Michael Orange
 David Purple



Q9 A customer wants to travel from Madison to New York with no more than two changes of flight. 
   List the choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m.
Ans:

SELECT departs AS departure_time
FROM Flights
WHERE "from" = 'Madison' AND "to" = 'New York' AND arrives <= '18:00'
UNION
SELECT f1.departs AS departure_time
FROM Flights f1
JOIN Flights f2 ON f1."to" = f2."from"
WHERE f1."from" = 'Madison' AND f2."to" = 'New York' AND f2.arrives <= '18:00';

output:
 departure_time 
----------------
 07:00:00
 09:00:00
 12:00:00



Q10 Compute the difference between the average salary of a pilot and the average salary of all employees (including pilots).
Ans:

WITH 
PilotSalary AS (
    SELECT AVG(salary) AS avg_pilot_salary
    FROM Employees e
    JOIN Certified c ON e.eid = c.eid
),
AllEmployeeSalary AS (
    SELECT AVG(salary) AS avg_employee_salary
    FROM Employees
)
SELECT avg_pilot_salary - avg_employee_salary AS salary_difference
FROM PilotSalary, AllEmployeeSalary;

output:
 salary_difference 
-------------------
 1117.241379310345



Q11 Print the name and salary of every nonpilot whose salary is more than the average salary for pilots.
Ans:

SELECT ename, salary
FROM Employees
WHERE  salary > (
    SELECT AVG(salary) 
    FROM Employees e 
    JOIN Certified c ON e.eid = c.eid
    );

output:
     ename      | salary 
----------------+--------
 John Doe       |  95000
 Chris Green    | 120000
 Patricia Black |  91000
 Linda Blue     |  94000
 Robert Yellow  |  99000
 Daniel Cyan    |  92000
 Matthew Red    |  93000



Q12 Print the names of employees who are certified only on aircrafts with cruising range longer than 1000 miles.
Ans:

SELECT e.ename
FROM Employees e
JOIN Certified c ON e.eid = c.eid
JOIN Aircraft a ON c.aid = a.aid
WHERE a.cruisingrange > 1000
GROUP BY e.ename
HAVING COUNT(*) = (
    SELECT COUNT(*) 
    FROM Aircraft 
    WHERE cruisingrange > 1000
    );



Q13 Print the names of employees who are certified only on aircrafts with cruising range longer than 1000 miles, but on at least two such aircrafts.
Ans:

WITH count AS (
    SELECT e.ename, COUNT(*) AS certified
    FROM Employees e
    JOIN Certified c ON e.eid = c.eid
    JOIN Aircraft a ON c.aid = a.aid
    WHERE a.cruisingrange > 1000
    GROUP BY e.ename
)
SELECT ename
FROM count
WHERE certified >= 2;

output:
     ename      
----------------
 Sam Brown
 Robert Yellow
 Daniel Cyan
 John Doe
 Patricia Black
 Matthew Red
 Jane Smith
 Joseph Gray



Q14  Print the names of employees who are certified only on aircrafts with cruising range longer than 1000 miles and who are certified on some Boeing aircraft.
Ans:

SELECT distinct  e.eid, e.ename
FROM Employees e
JOIN Certified c ON e.eid = c.eid
JOIN Aircraft a ON c.aid = a.aid
WHERE a.cruisingrange > 1000
AND EXISTS (
    SELECT 1
    FROM Aircraft
    WHERE aid = c.aid AND aname LIKE 'Boeing%'
);

output:
 eid |     ename     
-----+---------------
   1 | John Doe
   2 | Jane Smith
   3 | Sam Brown
   5 | Anna White
   6 | Chris Green
   8 | Linda Blue
   9 | Robert Yellow
  11 | William Pink
  13 | Joseph Gray
  14 | Daniel Cyan
  15 | Matthew Red

