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
