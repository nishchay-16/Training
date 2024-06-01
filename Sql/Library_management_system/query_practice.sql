!------------QUERY PRACTICE OF LIBRARY MANAGEMENT SYSTEM---------------!


Q1 Retrieve the names and nationalities of all authors in the database.
Ans:

SELECT a.author_name, a.nationality 
FROM author as a;
        
output:-
  author_name  | nationality 
---------------+-------------
 J.K. Rowling  | British
 George Orwell | African
 MS chauhan    | Indian
 Amy Poehler   | American
 Stephan King  | American



Q2 Find out how many books are available in the Horror Section.
Ans: 

SELECT COUNT(available_quantity) 
FROM Book
WHERE section_id = (
    SELECT section_id
    FROM Section
    WHERE section_name = 'Horror Section'
) AND available_quantity > 0;

output:-
 count 
-------
     4



Q3 List all members who have borrowed books and their corresponding return dates.
Ans:

SELECT m.member_name , t.returndate 
FROM member m JOIN transaction t on m.member_id = t.member_id ;

output:-
 member_name | returndate 
-------------+------------
 Nishchay    | 2024-05-30
 Nishchay    | 2024-05-15
 Pragya      | 2024-05-19
 Deepin      | 2024-06-10
 Nishchay    | 2024-07-25
 Pragya      | 2024-06-26
 Deepin      | 2024-02-09
 Pragya      | 2024-07-11



Q4 Display the titles of books borrowed by a specific member.
Ans:

SELECT b.title
FROM Book b
JOIN Transaction t ON b.isbn = t.isbn
JOIN Member m ON t.member_id = m.member_id
WHERE m.member_name = 'Nishchay';

output:
                  title                  
-----------------------------------------
 Harry Potter and the Philosophers Stone
 1984



Q5 Calculate the total fine amount that has been paid by all members.
Ans: 

SELECT SUM(fine_amount) AS total_fine_paid
FROM Fine
WHERE payment_status = 'Paid';

output:
 total_fine_paid 
-----------------
           15.00



Q6 Identify the librarian who issued the most transactions.
Ans:

SELECT l.librarian_name, COUNT(t.transaction_id) AS transaction_count
FROM Librarian l
JOIN Transaction t ON l.librarian_id = t.librarian_id
GROUP BY l.librarian_name
ORDER BY transaction_count DESC
LIMIT 1;
 
OR

SELECT librarian_name 
FROM librarian 
WHERE librarian_id IN 
    (SELECT t.librarian_id 
     FROM transaction t 
     GROUP BY t.librarian_id 
     ORDER BY t.librarian_id DESC
     LIMIT 1);

output:
 librarian_name | transaction_count 
----------------+-------------------
 Kavita         |                 3



Q7 Show the titles of books with their corresponding authors and genres.
Ans:

SELECT b.title , g.genre_name, a.author_name 
FROM book b 
JOIN author a ON b.author_id = a.author_id 
JOIN genre g ON b.genre_id = g.genre_id ;

output:
                  title                  |   genre_name    |  author_name  
-----------------------------------------+-----------------+---------------
 Harry Potter and the Deathly Hallows    | Fantasy         | J.K. Rowling
 Harry Potter and the Philosophers Stone | Fantasy         | J.K. Rowling
 The Shining                             | Horror          | Stephan King
 Bird Box                                | Horror          | Stephan King
 Dracula                                 | Horror          | J.K. Rowling
 1984                                    | Horror          | George Orwell
 Pride and Prejudice                     | Literature      | MS chauhan
 Inception                               | Literature      | George Orwell
 Catch-22                                | Comedy          | Amy Poehler
 Bossypants                              | Comedy          | J.K. Rowling
 Yesplease                               | Comedy          | J.K. Rowling
 Enders Game                             | Science Fiction | J.K. Rowling



Q8 Find out which section has the highest capacity.
Ans:

SELECT * 
FROM Section 
ORDER BY capacity DESC 
LIMIT 1;

OR

SELECT *
FROM Section
WHERE capacity = (
    SELECT MAX(capacity)
    FROM Section
);

output:
 section_id |    section_name    | capacity 
------------+--------------------+----------
          3 | Literature Section |      500



Q9 List all transactions issued by a specific librarian.
Ans:

SELECT * 
FROM transaction 
WHERE librarian_id IN
    (SELECT l.librarian_id 
     FROM librarian l 
     WHERE l.librarian_name = 'Jitender'
    );

output:
 transaction_id | member_id |  isbn  | issuedate  | returndate | librarian_id 
----------------+-----------+--------+------------+------------+--------------
              4 |         4 | 978076 | 2024-05-13 | 2024-06-10 |            3
              6 |         3 | 978076 | 2024-05-22 | 2024-06-26 |            3
              7 |         4 | 978077 | 2024-01-26 | 2024-02-09 |            3



Q10 Display the names and email addresses of all members who have unpaid fines.
Ans:

SELECT m.member_name, m.email
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Fine f ON t.transaction_id = f.transaction_id
WHERE f.payment_status = 'Unpaid';

output:
 member_name |            email             
-------------+------------------------------
 Nishchay    | nishugupta123gupta@gmail.com



Q11 Retrieve the names of authors who have written more than one book.
Ans:

SELECT a.author_name
FROM Author a
JOIN Book b ON a.author_id = b.author_id
GROUP BY a.author_id
HAVING COUNT(b.author_id) > 1;

output:
  author_name  
---------------
 Stephan King
 George Orwell
 J.K. Rowling



Q12 Find the name and email of the member who has the earliest issued book.
Ans: 

SELECT m.member_name, m.email
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
ORDER BY t.issuedate ASC
LIMIT 1;

output:
 member_name |      email       
-------------+------------------
 Deepin      | deepin@gmail.com



Q13 Display the section names that have books by 'George Orwell'.
Ans:

SELECT s.section_name
FROM Section s
JOIN Book b ON s.section_id = b.section_id
JOIN Author a ON b.author_id = a.author_id
WHERE a.author_name = 'George Orwell';

output:
    section_name    
--------------------
 Horror Section
 Literature Section



Q14 Calculate the total number of books in each genre.
Ans:

SELECT g.genre_name, SUM(b.quantity) AS quantity
FROM Book b
JOIN Genre g ON g.genre_id = b.genre_id
GROUP BY g.genre_id, g.genre_name;

output:
   genre_name    | sum 
-----------------+-----
 Literature      |   9
 Science Fiction |   1
 Comedy          |  48
 Horror          |  18
 Fantasy         |   8



Q15 List all the members who have never borrowed a book.
Ans:

SELECT m.member_name
FROM Member m
LEFT JOIN Transaction t ON m.member_id = t.member_id
WHERE t.member_id IS NULL;

output:
 member_name 
-------------
 Naman



Q16 Show the most popular genre based on the number of books borrowed.
Ans:

SELECT g.genre_name                                 
FROM Genre g
JOIN Book b ON g.genre_id = b.genre_id
GROUP BY g.genre_id              
HAVING (MAX(b.quantity - b.available_quantity)) = 
    (SELECT MAX(quantity - available_quantity) FROM Book);

OR

SELECT g.genre_name, COUNT(t.isbn) AS books_borrowed
FROM Genre g
JOIN Book b ON g.genre_id = b.genre_id
JOIN Transaction t ON b.isbn = t.isbn
GROUP BY g.genre_name
ORDER BY books_borrowed DESC
LIMIT 1;

output:
 genre_name | books_borrowed 
------------+----------------
 Comedy     |              4



Q17 Display the details of the book with the highest quantity.
Ans:

SELECT * 
FROM Book
ORDER BY quantity DESC
LIMIT 1;

output:
  isbn  |  title   | author_id | genre_id | quantity | available_quantity | section_id 
--------+----------+-----------+----------+----------+--------------------+------------
 975987 | Catch-22 |         4 |        4 |       19 |                 19 |          4



Q18 Retrieve the names of members who have fines that were issued in the last 30 days.
Ans:

SELECT DISTINCT m.member_name
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Fine f ON t.transaction_id = f.transaction_id
WHERE f.fine_date >= CURRENT_DATE - INTERVAL '30 days';
 member_name 

output:
 member_name 
-------------
 Nishchay



Q19 List all the unique genres available in the library.
Ans:

SELECT DISTINCT genre_name
FROM Genre;

output:
   genre_name    
-----------------
 Comedy
 Literature
 Fantasy
 Horror
 Science Fiction



Q20 Find the average capacity of sections in the library.
Ans: 

SELECT AVG(capacity) AS Avg_capacity 
FROM section ;

output:
     avg_capacity     
----------------------
 159.0000000000000000



Q21 Find the age of the member from dob.
Ans:

SELECT member_name , dob , EXTRACT(YEAR FROM AGE(CURRENT_DATE ,dob)) AS age 
FROM member;

OR

SELECT member_name , dob , EXTRACT(YEAR FROM AGE(dob)) AS age 
FROM member;

output:
 member_name |    dob     | age 
-------------+------------+-----
 Nishchay    | 2002-10-16 |  21
 Naman       | 2002-11-06 |  21
 Pragya      | 2004-01-24 |  20
 Deepin      | 2002-06-15 |  21



Q22 Find the name of the member who has borrowed the most books.
Ans: 

SELECT m.member_name
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Book b ON t.isbn = b.isbn
GROUP BY m.member_id, m.member_name
ORDER BY COUNT(b.isbn) DESC
LIMIT 1;

OR

SELECT m.member_name 
FROM member m 
JOIN transaction t ON m.member_id = t.member_id 
GROUP BY m.member_id 
ORDER BY count(t.transaction_id) DESC 
LIMIT 1;

output:
 member_name 
-------------
 Pragya



Q23  Retrieve the title of book that have been borrowed the most.
Ans:  

SELECT b.title 
FROM book b 
JOIN transaction t ON t.isbn = b.isbn
GROUP BY b.isbn
ORDER BY COUNT(t.transaction_id) DESC
LIMIT 1;

output:
   title   
-----------
 Yesplease



Q24 List the member names who have borrowed books from the 'Horror Section'.
Ans:

SELECT m.member_name
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Book b ON t.isbn = b.isbn
JOIN Section s ON b.section_id = s.section_id
WHERE s.section_name = 'Horror Section';

output:
 member_name 
-------------
 Nishchay



Q25 Display the genre names along with the average quantity of books available in each genre.
Ans:

SELECT g.genre_name, AVG(b.available_quantity) AS avg_available_quantity
FROM genre g
JOIN book b ON g.genre_id = b.genre_id
GROUP BY g.genre_id;

output:
   genre_name    | avg_available_quantity 
-----------------+------------------------
 Comedy          |    14.0000000000000000
 Literature      |     3.5000000000000000
 Fantasy         |     3.5000000000000000
 Horror          |     3.7500000000000000
 Science Fiction | 0.00000000000000000000



Q26 List all the books that have been borrowed only once.
Ans:

SELECT b.*
FROM book b
JOIN transaction t on b.isbn = t.isbn
GROUP BY b.isbn
HAVING COUNT(t.transaction_id) = 1;

output:
  isbn  |                  title                  | author_id | genre_id | quantity | available_quantity | section_id 
--------+-----------------------------------------+-----------+----------+----------+--------------------+------------
 978077 | Bossypants                              |         1 |        4 |       14 |                 13 |          4
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1
 978014 | 1984                                    |         2 |        2 |        7 |                  7 |          2


Q27 Show the names of members who have borrowed books in the last 30 days and have fines.
Ans:

SELECT DISTINCT m.member_name
FROM member m
JOIN transaction t ON m.member_id = t.member_id
JOIN fine f on f.transaction_id = t.transaction_id
where t.issuedate >= CURRENT_DATE - INTERVAL '30 days';

output:
 member_name 
-------------
 Nishchay



Q28 Display the librarian names along with the total fine amount they have collected.
Ans:

SELECT l.librarian_name, SUM(f.fine_amount) AS total_fine
FROM librarian l
JOIN transaction t ON l.librarian_id = t.librarian_id
JOIN fine f ON t.transaction_id = f.transaction_id
GROUP BY l.librarian_name;

output:
 librarian_name | total_fine 
----------------+------------
 Dinesh         |      40.00



Q29 Display the author detials whose books have been borrowed from the library.
Ans:

SELECT DISTINCT a.*
FROM author a
JOIN book b ON a.author_id = b.author_id
JOIN transaction t ON b.isbn = t.isbn;

output:
 author_id |  author_name  | nationality 
-----------+---------------+-------------
         2 | George Orwell | African
         1 | J.K. Rowling  | British

  

Q30 List the books details that have never been borrowed.
Ans:

SELECT b.*
FROM book b
LEFT JOIN transaction t ON b.isbn = t.isbn
WHERE t.transaction_id IS NULL;

output:
  isbn  |                title                 | author_id | genre_id | quantity | available_quantity | section_id 
--------+--------------------------------------+-----------+----------+----------+--------------------+------------
 975987 | Catch-22                             |         4 |        4 |       19 |                 19 |          4
 978990 | The Shining                          |         5 |        2 |        1 |                  0 |          2
 978090 | Enders Game                          |         1 |        5 |        1 |                  0 |          5
 990208 | Pride and Prejudice                  |         3 |        3 |        2 |                  2 |          3
 977101 | Dracula                              |         1 |        2 |        3 |                  2 |          2
 978054 | Harry Potter and the Deathly Hallows |         1 |        1 |        3 |                  3 |          1
 977000 | Bird Box                             |         5 |        2 |        7 |                  6 |          2



Q31 Calculate the average fine amount per member.
Ans:

SELECT m.member_name, AVG(f.fine_amount) AS avg_fine_amount
FROM member m
JOIN transaction t ON m.member_id = t.member_id
JOIN fine f ON t.transaction_id = f.transaction_id
GROUP BY m.member_id;

output:
 member_name |   avg_fine_amount   
-------------+---------------------
 Nishchay    | 20.0000000000000000



Q32  Find the average time (in days) members take to return books.
Ans:

SELECT m.member_name, AVG(AGE(t.returndate, t.issuedate)) AS avg_borrow_duration
FROM member m
JOIN transaction t ON m.member_id = t.member_id
GROUP BY m.member_name;

output:
 member_name | avg_borrow_duration 
-------------+---------------------
 Pragya      | 1 mon 27 days
 Nishchay    | 1 mon 23 days
 Deepin      | 21 days



Q33 Find the authors who have the highest number of books in the library
Ans: 

SELECT a.author_name, COUNT(b.isbn) AS book_count
FROM author a
JOIN book b ON a.author_id = b.author_id
GROUP BY a.author_name
ORDER BY book_count DESC
LIMIT 1;

output:
 author_name  | book_count 
--------------+------------
 J.K. Rowling |          6



Q34 List the members who have borrowed the same book more than once.
Ans:

SELECT m.member_name, b.title, COUNT(t.isbn) AS borrow_count
FROM member m
JOIN transaction t ON m.member_id = t.member_id
JOIN book b ON t.isbn = b.isbn
GROUP BY m.member_name, b.title
HAVING COUNT(t.isbn) > 1;

output:
 member_name |   title   | borrow_count 
-------------+-----------+--------------
 Pragya      | Inception |            2



Q35 Find the genres that have the highest number of available books
Ans

SELECT g.genre_name, SUM(b.available_quantity) AS total_available_books
FROM genre g
JOIN book b ON g.genre_id = b.genre_id
GROUP BY g.genre_name
ORDER BY total_available_books DESC
LIMIT 1;

output:
 genre_name | total_available_books 
------------+-----------------------
 Comedy     |                    42



Q36 Find the details of books that are currently available for borrowing:
Ans:

SELECT b.*
FROM book b
WHERE b.available_quantity > 0;

output:
  isbn  |                  title                  | author_id | genre_id | quantity | available_quantity | section_id 
--------+-----------------------------------------+-----------+----------+----------+--------------------+------------
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1
 978054 | Harry Potter and the Deathly Hallows    |         1 |        1 |        3 |                  3 |          1
 978014 | 1984                                    |         2 |        2 |        7 |                  7 |          2
 978076 | Yesplease                               |         1 |        4 |       15 |                 10 |          4
 978077 | Bossypants                              |         1 |        4 |       14 |                 13 |          4
 978009 | Inception                               |         2 |        3 |        7 |                  5 |          3
 977101 | Dracula                                 |         1 |        2 |        3 |                  2 |          2
 977000 | Bird Box                                |         5 |        2 |        7 |                  6 |          2
 990208 | Pride and Prejudice                     |         3 |        3 |        2 |                  2 |          3
 975987 | Catch-22                                |         4 |        4 |       19 |                 19 |          4



Q37 Calculate the age of each member and display it in years and months.
Ans:

SELECT member_name, dob,
       EXTRACT(YEAR FROM AGE(dob)) AS years,
       EXTRACT(MONTH FROM AGE(dob)) AS months
FROM member;

OR

SELECT member_name,
       dob,
       DATE_PART('year', age(dob)) AS years,
       DATE_PART('month', age(dob)) AS months
FROM member;

output:
 member_name |    dob     | years | months 
-------------+------------+-------+--------
 Nishchay    | 2002-10-16 |    21 |      7
 Naman       | 2002-11-06 |    21 |      6
 Pragya      | 2004-01-24 |    20 |      4
 Deepin      | 2002-06-15 |    21 |     11



Q38 List the titles of books along with the number of times they have been borrowed, only for books borrowed more than twice.
Ans:

SELECT b.title, 
       COUNT(t.transaction_id) AS borrow_count
FROM book b
JOIN transaction t ON b.isbn = t.isbn
GROUP BY b.title
HAVING COUNT(t.transaction_id) > 2;

output:
 title     | borrow_count 
-----------+---------------
 Yesplease |             3



Q39 Display the average fine amount collected per day.
Ans:

SELECT DATE_TRUNC('day', fine_date) AS day, 
       AVG(fine_amount) AS average_fine
FROM fine
GROUP BY DATE_TRUNC('day', fine_date)
ORDER BY day;

output:
            day            |    average_fine     
---------------------------+---------------------
 2024-05-20 00:00:00+05:30 | 25.0000000000000000
 2024-05-23 00:00:00+05:30 | 15.0000000000000000

OR

SELECT Extract(day from fine_date) AS day, 
       AVG(fine_amount) AS average_fine
FROM fine
GROUP BY Extract(day from fine_date)
ORDER BY day;

output:
 day |    average_fine     
-----+---------------------
  20 | 25.0000000000000000
  23 | 15.0000000000000000



Q39 Retrieve the details of the member who have a fine amount greater than the average fine;
Ans:

SELECT DISTINCT m.*
FROM member m
JOIN transaction t ON m.member_id = t.member_id
JOIN fine f ON t.transaction_id = f.transaction_id
WHERE f.fine_amount > (SELECT AVG(fine_amount) FROM fine);

output:
 member_id | member_name |    dob     |  phone_no  |            email             |       address        | occupation 
-----------+-------------+------------+------------+------------------------------+----------------------+------------
         1 | Nishchay    | 2002-10-16 | 9588169118 | nishugupta123gupta@gmail.com | #494 sector-6 karnal | student

  

Q40 Find the most recent book borrowed by each member.
Ans: 

SELECT DISTINCT ON (m.member_id) m.member_name, b.title, t.issuedate
FROM member m
JOIN transaction t ON m.member_id = t.member_id
JOIN book b ON t.isbn = b.isbn
ORDER BY m.member_id, t.issuedate DESC;

output:
 member_name |                  title                  | issuedate  
-------------+-----------------------------------------+------------
 Nishchay    | Harry Potter and the Deathly Hallows    | 2024-05-30
 Pragya      | Inception                               | 2024-05-19
 Deepin      | Yesplease                               | 2024-05-13



Q41 Find the total quantity of books in each genre.
Ans:

SELECT g.genre_name, 
       SUM(b.quantity) AS total_quantity
FROM genre g
JOIN book b ON g.genre_id = b.genre_id
JOIN transaction t ON b.isbn = t.isbn
GROUP BY g.genre_id;

output:
   genre_name    | total_quantity 
-----------------+----------------
 Literature      |              9
 Science Fiction |              1
 Comedy          |             48
 Horror          |             18
 Fantasy         |              8



Q42 List the names of members who have not borrowed any book in the last 6 months.
Ans:

SELECT DISTINCT m.member_name
FROM member m
LEFT JOIN transaction t ON m.member_id = t.member_id 
    AND t.issuedate >= CURRENT_DATE - INTERVAL '6 months'
WHERE t.transaction_id IS NULL;

OR

SELECT DISTINCT m.member_name
FROM member m
WHERE m.member_id NOT IN (
    SELECT DISTINCT t.member_id
    FROM transaction t
    WHERE t.issuedate >= CURRENT_DATE - INTERVAL '6 months'
);

output:
 member_name 
-------------
 Naman



Q43 Retrieve the titles of books borrowed by members whose age is more than 20 years.
Ans:

SELECT DISTINCT b.title
FROM book b
JOIN transaction t ON b.isbn = t.isbn
JOIN member m ON t.member_id = m.member_id
WHERE EXTRACT(YEAR FROM AGE(m.dob)) > 20;

output:
                  title                  
-----------------------------------------
 Bossypants
 Harry Potter and the Philosophers Stone
 1984
 Yesplease



Q44  Find the total number of distinct genres borrowed by each member
Ans:

SELECT m.member_name, COUNT(DISTINCT b.genre_id) AS genres_borrow
FROM member m
JOIN transaction t ON m.member_id = t.member_id
JOIN book b ON t.isbn = b.isbn
GROUP BY m.member_name;

output:
 member_name | genres_borrow 
-------------+---------------
 Deepin      |             1
 Nishchay    |             3
 Pragya      |             2



Q45 List members who have borrowed more books than the average number of books borrowed by all members.
Ans:

WITH avg_borrowed AS (
    SELECT AVG(book_count) 
    FROM (
        SELECT COUNT(*) AS book_count
        FROM transaction
        GROUP BY member_id
    ) 
)
SELECT m.member_name
FROM member m
JOIN transaction t ON m.member_id = t.member_id
GROUP BY m.member_name
HAVING COUNT(*) > (SELECT * FROM avg_borrowed);

OR

SELECT m.member_name
FROM member m
JOIN transaction t ON m.member_id = t.member_id
GROUP BY m.member_name
HAVING COUNT(*) > (
  SELECT AVG(book_count) 
  FROM (
    SELECT COUNT(*) AS book_count
    FROM transaction
    GROUP BY member_id
      )
  )
;

output:
 member_name 
-------------
 Pragya
 Nishchay



Q46 List members who have not borrowed any books from a particular section (e.g., 'Comedy Section').
Ans:

SELECT DISTINCT m.member_name
FROM member m
LEFT JOIN (
    SELECT t.member_id
    FROM transaction t
    JOIN book b ON t.isbn = b.isbn
    JOIN section s ON b.section_id = s.section_id
    WHERE s.section_name = 'Comedy Section'
) AS tr ON m.member_id = tr.member_id
WHERE tr.member_id IS NULL;

output:
 member_name 
-------------
 Naman



Q47 List the genres and the average age of members who have borrowed books in those genres.
Ans:

SELECT g.genre_id ,g.genre_name, AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, m.dob))) AS avg_age
FROM genre g
JOIN book b ON g.genre_id = b.genre_id
JOIN transaction t ON b.isbn = t.isbn
JOIN member m ON t.member_id = m.member_id
GROUP BY g.genre_id 
ORDER BY avg_age DESC;

output:
 genre_id | genre_name |       avg_age       
----------+------------+---------------------
        2 | Horror     | 21.0000000000000000
        1 | Fantasy    | 21.0000000000000000
        4 | Comedy     | 20.7500000000000000
        3 | Literature | 20.0000000000000000



Q48 SQL query to find the average fine amount paid by members who have borrowed books from the 'Fantasy'  genre.
Ans:

SELECT AVG(f.fine_amount) AS average_fine_amount
FROM fine f
JOIN transaction t ON f.transaction_id = t.transaction_id
JOIN book b ON t.isbn = b.isbn
JOIN genre g ON b.genre_id = g.genre_id
JOIN member m ON t.member_id = m.member_id
WHERE g.genre_name IN ('Fantasy')
GROUP BY m.member_id
HAVING COUNT(DISTINCT g.genre_id) = 1;

output:
 average_fine_amount 
---------------------
 20.0000000000000000



Q49 SQL query to identify the most common day of the week for book returns, along with the total number of returns on that day.
Ans:

SELECT EXTRACT(DOW FROM t.returndate) AS return_day_of_week, COUNT(*) AS return_count
FROM transaction t
GROUP BY return_day_of_week
ORDER BY return_count DESC
LIMIT 1;

output:
 return_day_of_week | return_count 
--------------------+--------------
                  4 |            3



Q50 SQL query to retrieve the names of members who have borrowed books from both the 'Fantasy Section', 'Comedy Section' and  'Horror Section'. 
    Display the member names along with the titles of the books borrowed from each section.
Ans:

SELECT m.member_name, b1.title AS fantasy_book, b2.title AS sci_fi_book, b3.title AS comedy_book
FROM member m
JOIN transaction t1 ON m.member_id = t1.member_id
JOIN book b1 ON t1.isbn = b1.isbn
JOIN section s1 ON b1.section_id = s1.section_id
JOIN transaction t2 ON m.member_id = t2.member_id
JOIN book b2 ON t2.isbn = b2.isbn
JOIN section s2 ON b2.section_id = s2.section_id
JOIN transaction t3 ON m.member_id = t3.member_id
JOIN book b3 ON t3.isbn = b3.isbn
JOIN section s3 ON b3.section_id = s3.section_id
WHERE s1.section_name = 'Fantasy Section'
AND s2.section_name = 'Horror Section'
AND s3.section_name = 'Comedy Section';

output:
 member_name |              fantasy_book               | sci_fi_book | comedy_book 
-------------+-----------------------------------------+-------------+-------------
 Nishchay    | Harry Potter and the Philosophers Stone | 1984        | Yesplease



Q51 Find all members who have borrowed books authored by 'J.K. Rowling'.
Ans 

SELECT distinct m.member_name
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Book b ON t.isbn = b.isbn
JOIN Author a ON b.author_id = a.author_id
WHERE a.author_name = 'J.K. Rowling';

output:
 member_name 
-------------
 Deepin
 Nishchay
 Pragya



 Q52 Find all books that are currently not available.
 Ans: 

 SELECT *
FROM Book
WHERE available_quantity = 0;

output:
  isbn  |    title    | author_id | genre_id | quantity | available_quantity | section_id 
--------+-------------+-----------+----------+----------+--------------------+------------
 978090 | Enders Game |         1 |        5 |        1 |                  0 |          5
 978990 | The Shining |         5 |        2 |        1 |                  0 |          2



Q53 Update the phone number of a member.
Ans:

UPDATE Member
SET phone_no = '9999999999'
WHERE member_name = 'Nishchay';

output:
UPDATE 1



Q54 Find the most popular book genre based on the number of transactions.
Ans: 

SELECT g.genre_name, COUNT(t.transaction_id) AS transaction_count
FROM Transaction t
JOIN Book b ON t.isbn = b.isbn
JOIN Genre g ON b.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY transaction_count DESC
LIMIT 1;

output:
 genre_name | transaction_count 
------------+-------------------
 Comedy     |                 4



Q55 Add 5 more copies of '1984' to the library stock.
Ans:

UPDATE Book
SET quantity = quantity + 5, available_quantity = available_quantity + 5
WHERE title = '1984';

output:
UPDATE 1



Q56 List all books with their authors and genres.
Ans:

SELECT b.title, a.author_name, g.genre_name
FROM Book b
JOIN Author a ON b.author_id = a.author_id
JOIN Genre g ON b.genre_id = g.genre_id;

output:
                  title                  |  author_name  |   genre_name    
-----------------------------------------+---------------+-----------------
 Harry Potter and the Deathly Hallows    | J.K. Rowling  | Fantasy
 Harry Potter and the Philosophers Stone | J.K. Rowling  | Fantasy
 1984                                    | George Orwell | Horror
 The Shining                             | Stephan King  | Horror
 Bird Box                                | Stephan King  | Horror
 Dracula                                 | J.K. Rowling  | Horror
 Pride and Prejudice                     | MS chauhan    | Literature
 Inception                               | George Orwell | Literature
 Catch-22                                | Amy Poehler   | Comedy
 Bossypants                              | J.K. Rowling  | Comedy
 Yesplease                               | J.K. Rowling  | Comedy
 Enders Game                             | J.K. Rowling  | Science Fiction



Q57 List all books that have never been issued
Ans:

SELECT b.title
FROM Book b
LEFT JOIN Transaction t ON b.isbn = t.isbn
WHERE t.isbn IS NULL;

output:
                title                 
--------------------------------------
 Catch-22
 The Shining
 Enders Game
 Pride and Prejudice
 Dracula
 Harry Potter and the Deathly Hallows
 Bird Box



Q58 List all authors with the number of books they have in the library.
Ans:

SELECT a.author_name, COUNT(b.isbn) AS book_count
FROM Author a
JOIN Book b ON a.author_id = b.author_id
GROUP BY a.author_name;

output:
  author_name  | book_count 
---------------+------------
 MS chauhan    |          1
 George Orwell |          2
 Stephan King  |          2
 J.K. Rowling  |          6
 Amy Poehler   |          1



Q59 List all transactions along with the book title and member name.
Ans: 

SELECT t.transaction_id, m.member_name, b.title, t.issuedate, t.returndate
FROM Transaction t
JOIN Member m ON t.member_id = m.member_id
JOIN Book b ON t.isbn = b.isbn;

output:
 transaction_id | member_name |                  title                  | issuedate  | returndate 
----------------+-------------+-----------------------------------------+------------+------------
              2 | Nishchay    | 1984                                    | 2024-05-05 | 2024-05-30
              1 | Nishchay    | Harry Potter and the Philosophers Stone | 2024-05-01 | 2024-05-15
              3 | Pragya      | Inception                               | 2024-04-08 | 2024-05-19
              4 | Deepin      | Yesplease                               | 2024-05-13 | 2024-06-10
              5 | Nishchay    | Yesplease                               | 2024-03-25 | 2024-07-25
              6 | Pragya      | Yesplease                               | 2024-05-22 | 2024-06-26
              7 | Deepin      | Bossypants                              | 2024-01-26 | 2024-02-09
              8 | Pragya      | Inception                               | 2024-04-05 | 2024-07-11



Q60 List the fines that are still unpaid along with the member and book details.
Ans:

SELECT f.fine_id, m.member_name, b.title, f.fine_amount, f.fine_date
FROM Fine f
JOIN Transaction t ON f.transaction_id = t.transaction_id
JOIN Member m ON t.member_id = m.member_id
JOIN Book b ON t.isbn = b.isbn
WHERE f.payment_status = 'Unpaid';

output:
 fine_id | member_name |                  title                  | fine_amount | fine_date  
---------+-------------+-----------------------------------------+-------------+------------
       1 | Nishchay    | Harry Potter and the Philosophers Stone |       25.00 | 2024-05-20




Q61 list all books along with their authors, genres, and the section they belong to, sorted by the author name.
Ans: 

SELECT b.title AS book_title,
    a.author_name,
    g.genre_name,
    s.section_name
FROM Book b
JOIN Author a ON b.author_id = a.author_id
JOIN Genre g ON b.genre_id = g.genre_id
JOIN Section s ON b.section_id = s.section_id
ORDER BY a.author_name;

output:
               book_title                |  author_name  |   genre_name    |      section_name       
-----------------------------------------+---------------+-----------------+-------------------------
 Catch-22                                | Amy Poehler   | Comedy          | Comedy Section
 Inception                               | George Orwell | Literature      | Literature Section
 1984                                    | George Orwell | Horror          | Horror Section
 Enders Game                             | J.K. Rowling  | Science Fiction | Science Fiction Section
 Harry Potter and the Deathly Hallows    | J.K. Rowling  | Fantasy         | Fantasy Section
 Dracula                                 | J.K. Rowling  | Horror          | Horror Section
 Yesplease                               | J.K. Rowling  | Comedy          | Comedy Section
 Bossypants                              | J.K. Rowling  | Comedy          | Comedy Section
 Harry Potter and the Philosophers Stone | J.K. Rowling  | Fantasy         | Fantasy Section
 Pride and Prejudice                     | MS chauhan    | Literature      | Literature Section
 The Shining                             | Stephan King  | Horror          | Horror Section
 Bird Box                                | Stephan King  | Horror          | Horror Section




Q61 What is the total number of books available in each section, and which section has the highest total quantity of books.
Ans:

SELECT 
    s.section_name,
    SUM(b.quantity) AS total_books
FROM Book b
JOIN Section s ON b.section_id = s.section_id
GROUP BY s.section_name
ORDER BY total_books DESC;

output:
      section_name       | total_books 
-------------------------+-------------
 Comedy Section          |          48
 Horror Section          |          23
 Literature Section      |           9
 Fantasy Section         |           8
 Science Fiction Section |           1




Q62 Write a query to ensure that no book is issued more than its available quantity.
Ans: 

SELECT 
    b.title,
    b.available_quantity,
    COUNT(t.isbn) AS issued_count
FROM Book b
LEFT JOIN Transaction t ON b.isbn = t.isbn
GROUP BY b.title, b.available_quantity
HAVING COUNT(t.isbn) > b.available_quantity;



Q63 create an index to optimize the search for books by title and author.
Ans:

CREATE INDEX idx_book_title_author 
ON Book (title, author_id);



Q64 Find the members who have issued books in the last 2 month and the count of books issued by each
Ans:

SELECT 
    m.member_name,
    COUNT(t.transaction_id) AS books_issued
FROM Transaction t
JOIN Member m ON t.member_id = m.member_id
WHERE t.issuedate >= CURRENT_DATE - INTERVAL '2 month'
GROUP BY m.member_name;

output:
-------------+--------------
 Pragya      |            3
 Nishchay    |            2
 Deepin      |            1



Q65 Determine the most frequently issued book and the number of times it has been issued.
Ans: 

SELECT 
    b.title,
    COUNT(t.transaction_id) AS issue_count
FROM Transaction t
JOIN Book b ON t.isbn = b.isbn
GROUP BY b.title
ORDER BY issue_count DESC
LIMIT 1;

output:
   title   | issue_count 
-----------+-------------
 Yesplease |           3



Q66 Create a view that shows detailed transaction history including member name, book title, issue date, return date, librarian name, and fine amount if any.
Ans: 

CREATE VIEW TransactionHistory AS
SELECT 
    t.transaction_id,
    m.member_name,
    b.title AS book_title,
    t.issuedate,
    t.returndate,
    l.librarian_name,
    COALESCE(f.fine_amount, 0) AS fine_amount
FROM Transaction t
JOIN Member m ON t.member_id = m.member_id
JOIN Book b ON t.isbn = b.isbn
JOIN Librarian l ON t.librarian_id = l.librarian_id
LEFT JOIN Fine f ON t.transaction_id = f.transaction_id;

output:
 SELECT * from TransactionHistory;

 transaction_id | member_name |               book_title                | issuedate  | returndate | librarian_name | fine_amount 
----------------+-------------+-----------------------------------------+------------+------------+----------------+-------------
              1 | Nishchay    | Harry Potter and the Philosophers Stone | 2024-05-01 | 2024-05-15 | Dinesh         |       25.00
              1 | Nishchay    | Harry Potter and the Philosophers Stone | 2024-05-01 | 2024-05-15 | Dinesh         |       15.00
              2 | Nishchay    | 1984                                    | 2024-05-05 | 2024-05-30 | Dinesh         |           0
              5 | Nishchay    | Yesplease                               | 2024-03-25 | 2024-07-25 | Kavita         |           0
              8 | Pragya      | Inception                               | 2024-04-05 | 2024-07-11 | Kavita         |           0
              6 | Pragya      | Yesplease                               | 2024-05-22 | 2024-06-26 | Jitender       |           0
              4 | Deepin      | Yesplease                               | 2024-05-13 | 2024-06-10 | Jitender       |           0
              3 | Pragya      | Inception                               | 2024-04-08 | 2024-05-19 | Kavita         |           0
              7 | Deepin      | Bossypants                              | 2024-01-26 | 2024-02-09 | Jitender       |           0



Q67 find the number of books issued and returned by each member along with their names.
Ans: 

SELECT 
    m.member_name,
    COUNT(t.transaction_id) FILTER (WHERE t.returndate IS NULL) AS books_issued,
    COUNT(t.transaction_id) FILTER (WHERE t.returndate IS NOT NULL) AS books_returned
FROM Transaction t
JOIN Member m ON t.member_id = m.member_id
GROUP BY m.member_name;

output:
 member_name | books_issued | books_returned 
-------------+--------------+----------------
 Pragya      |            0 |              3
 Nishchay    |            0 |              3
 Deepin      |            0 |              2



Q68 Write a query to search for books by a specific keyword in the title and author name.
Ans: 
SELECT 
    b.title,
    a.author_name,
    b.isbn
FROM Book b
JOIN Author a ON b.author_id = a.author_id
WHERE b.title ILIKE '%cept%' OR a.author_name ILIKE '%vit%';

output:
   title   |  author_name  |  isbn  
-----------+---------------+--------
 Inception | George Orwell | 978009



Q69 Generate a report showing the total number of books issued by genre within a specific date range.
Ans: 

SELECT 
    g.genre_name,
    COUNT(t.transaction_id) AS total_issues
FROM Transaction t
JOIN Book b ON t.isbn = b.isbn
JOIN Genre g ON b.genre_id = g.genre_id
WHERE t.issuedate BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY g.genre_name
ORDER BY total_issues DESC;

output:
 genre_name | total_issues 
------------+--------------
 Comedy     |            4
 Literature |            2
 Fantasy    |            1
 Horror     |            1



Q70 Write a query to mark all fines as "Paid" for a specific member.
Ans: 

UPDATE Fine f
SET payment_status = 'Paid'
FROM Transaction t
JOIN Member m ON t.member_id = m.member_id
WHERE f.transaction_id = t.transaction_id
AND m.member_name = 'Nishchay';

output:
UPDATE 2



Q71 Write an optimized query to find the top 5 most frequently issued books.
Ans: 

SELECT 
    b.title,
    COUNT(t.transaction_id) AS issue_count
FROM Transaction t
JOIN Book b ON t.isbn = b.isbn
GROUP BY b.title
ORDER BY issue_count DESC
LIMIT 5;

output: 
                  title                  | issue_count 
-----------------------------------------+-------------
 Yesplease                               |           3
 Inception                               |           2
 1984                                    |           1
 Bossypants                              |           1
 Harry Potter and the Philosophers Stone |           1



Q72 Find members who have borrowed all books by a specific author.
Ans: 

SELECT m.member_name
FROM Member m
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM Book b
        WHERE b.author_id = (SELECT author_id FROM Author WHERE author_name = 'George Orwell')
        AND NOT EXISTS (
            SELECT 1
            FROM Transaction t
            WHERE t.member_id = m.member_id
            AND t.isbn = b.isbn
        )
    );

output:
 member_name 
-------------
(0 rows)



Q73 Find the librarian who has handled the most transactions.
Ans: 

SELECT 
    l.librarian_name,
    COUNT(t.transaction_id) AS transactions_handled
FROM Transaction t
JOIN Librarian l ON t.librarian_id = l.librarian_id
GROUP BY l.librarian_name
ORDER BY transactions_handled DESC
LIMIT 1;

output: 
 librarian_name | transactions_handled 
----------------+----------------------
 Kavita         |                    3



Q74 Find all books that have sequels (e.g., "Harry Potter" series) and list them in order.
Ans: 

WITH RECURSIVE BookSeries AS (
    SELECT 
        b.isbn,
        b.title,
        b.author_id,
        b.genre_id,
        b.quantity,
        b.available_quantity,
        b.section_id,
        1 AS series_order
    FROM Book b
    WHERE b.title LIKE 'Harry Potter%'
    UNION ALL
    SELECT 
        b.isbn,
        b.title,
        b.author_id,
        b.genre_id,
        b.quantity,
        b.available_quantity,
        b.section_id,
        bs.series_order + 1
    FROM Book b
    JOIN BookSeries bs ON b.title LIKE 'Harry Potter%'
    WHERE b.title > bs.title
)
SELECT *
FROM BookSeries
ORDER BY series_order;

output:
  isbn  |                  title                  | author_id | genre_id | quantity | available_quantity | section_id | series_order 
--------+-----------------------------------------+-----------+----------+----------+--------------------+------------+--------------
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1 |            1
 978054 | Harry Potter and the Deathly Hallows    |         1 |        1 |        3 |                  3 |          1 |            1
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1 |            2



Q75 Ensure that no two members can have the same phone number or email address.
Ans: 

ALTER TABLE Member
ADD CONSTRAINT unique_phone_email UNIQUE (phone_no, email);



Q76 Calculate the average number of books borrowed per member.
Ans: 

SELECT AVG(borrowed_books) AS avg_books_borrowed
FROM (
    SELECT m.member_id, COUNT(t.transaction_id) AS borrowed_books
    FROM Member m
    LEFT JOIN Transaction t ON m.member_id = t.member_id
    GROUP BY m.member_id
) AS member_borrow_stats;



Q77 Rank members based on the number of books borrowed.
Ans: 

SELECT 
    m.member_name,
    COUNT(t.transaction_id) AS books_borrowed,
    RANK() OVER (ORDER BY COUNT(t.transaction_id) DESC) AS borrow_rank
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
GROUP BY m.member_name;

output:
 member_name | books_borrowed | borrow_rank 
-------------+----------------+-------------
 Pragya      |              3 |           1
 Nishchay    |              3 |           1
 Deepin      |              2 |           3



Q78 Find the member who has the most fines and the total amount of fines they have paid.
Ans:

SELECT 
    m.member_name,
    COUNT(f.fine_id) AS total_fines,
    SUM(f.fine_amount) AS total_fine_amount
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Fine f ON t.transaction_id = f.transaction_id
GROUP BY m.member_name
ORDER BY total_fine_amount DESC
LIMIT 1;

output:
 member_name | total_fines | total_fine_amount 
-------------+-------------+-------------------
 Nishchay    |           2 |             40.00



Q79 List members who have borrowed books from more than one genre.
Ans: 

SELECT m.member_name
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Book b ON t.isbn = b.isbn
GROUP BY m.member_name
HAVING COUNT(DISTINCT b.genre_id) > 1;

output:
 member_name 
-------------
 Nishchay
 Pragya



Q80 Correct the nationality of 'George Orwell' to 'British' in the Author table
Ans:

UPDATE Author
SET nationality = 'British'
WHERE author_name = 'George Orwell';



Q81 Generate a matrix of all possible combinations of authors and genres.
Ans:

SELECT 
    a.author_name,
    g.genre_name
FROM Author a
CROSS JOIN Genre g;

output:
  author_name  |   genre_name    
---------------+-----------------
 J.K. Rowling  | Fantasy
 MS chauhan    | Fantasy
 Amy Poehler   | Fantasy
 Stephan King  | Fantasy
 George Orwell | Fantasy
 J.K. Rowling  | Horror
 MS chauhan    | Horror
 Amy Poehler   | Horror
 Stephan King  | Horror
 George Orwell | Horror
 J.K. Rowling  | Literature
 MS chauhan    | Literature
 Amy Poehler   | Literature
 Stephan King  | Literature
 George Orwell | Literature
 J.K. Rowling  | Comedy
 MS chauhan    | Comedy
 Amy Poehler   | Comedy
 Stephan King  | Comedy
 George Orwell | Comedy
 J.K. Rowling  | Science Fiction
 MS chauhan    | Science Fiction
 Amy Poehler   | Science Fiction
 Stephan King  | Science Fiction
 George Orwell | Science Fiction



Q82 Find books that have been issued more than once within the same month.
Ans: 

SELECT 
    t1.isbn,
    COUNT(t1.transaction_id) AS issue_count
FROM Transaction t1
JOIN Transaction t2 ON t1.isbn = t2.isbn 
WHERE DATE_PART('month', t1.issuedate) = DATE_PART('month', t2.issuedate)
  AND t1.transaction_id <> t2.transaction_id
GROUP BY t1.isbn
HAVING COUNT(t1.transaction_id) > 1;

output:
  isbn  | issue_count 
--------+-------------
 978009 |           2
 978076 |           2



Q83 Calculate the median fine amount.
Ans:

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY fine_amount) AS median_fine
FROM Fine;

output:
 median_fine 
-------------
          20



Q84 Create a pivot table showing the number of books issued per genre each month.
Ans: 

SELECT 
    g.genre_name,
    DATE_TRUNC('month', t.issuedate) AS month,
    COUNT(t.transaction_id) AS books_issued
FROM Transaction t
JOIN Book b ON t.isbn = b.isbn
JOIN Genre g ON b.genre_id = g.genre_id
GROUP BY g.genre_name, DATE_TRUNC('month', t.issuedate)
ORDER BY month;

output:
 genre_name |           month           | books_issued 
------------+---------------------------+--------------
 Comedy     | 2024-01-01 00:00:00+05:30 |            1
 Comedy     | 2024-03-01 00:00:00+05:30 |            1
 Literature | 2024-04-01 00:00:00+05:30 |            2
 Comedy     | 2024-05-01 00:00:00+05:30 |            2
 Fantasy    | 2024-05-01 00:00:00+05:30 |            1
 Horror     | 2024-05-01 00:00:00+05:30 |            1



Q85 Find all members whose email domain is 'gmail.com'.
Ans:

SELECT 
    member_name,
    email
FROM Member
WHERE email LIKE '%@gmail.com';

output:
 member_name |            email             
-------------+------------------------------
 Naman       | namandua9@gmail.com
 Pragya      | Pragya@gmail.com
 Deepin      | deepin@gmail.com
 Nishchay    | nishugupta123gupta@gmail.com



Q86 Create a report showing the status of book availability.
Ans: 

SELECT 
    title,
    quantity,
    available_quantity,
    CASE 
        WHEN available_quantity = 0 THEN 'Out of Stock'
        WHEN available_quantity < quantity / 2 THEN 'Limited Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM Book;

output:
                  title                  | quantity | available_quantity | stock_status 
-----------------------------------------+----------+--------------------+--------------
 Harry Potter and the Philosophers Stone |        5 |                  4 | In Stock
 Harry Potter and the Deathly Hallows    |        3 |                  3 | In Stock
 Yesplease                               |       15 |                 10 | In Stock
 Bossypants                              |       14 |                 13 | In Stock
 Inception                               |        7 |                  5 | In Stock
 Enders Game                             |        1 |                  0 | Out of Stock
 Dracula                                 |        3 |                  2 | In Stock
 Bird Box                                |        7 |                  6 | In Stock
 The Shining                             |        1 |                  0 | Out of Stock
 Pride and Prejudice                     |        2 |                  2 | In Stock
 Catch-22                                |       19 |                 19 | In Stock
 1984                                    |       12 |                 12 | In Stock



Q87 Find the average, minimum, and maximum fine amounts for each member.
Ans:

SELECT 
    m.member_name,
    AVG(f.fine_amount) AS avg_fine,
    MIN(f.fine_amount) AS min_fine,
    MAX(f.fine_amount) AS max_fine
FROM Fine f
JOIN Transaction t ON f.transaction_id = t.transaction_id
JOIN Member m ON t.member_id = m.member_id
GROUP BY m.member_name;

output:
 member_name |      avg_fine       | min_fine | max_fine 
-------------+---------------------+----------+----------
 Nishchay    | 20.0000000000000000 |    15.00 |    25.00



Q88 Calculate the correlation between the quantity and available quantity of books.
Ans: 

SELECT CORR(quantity, available_quantity) AS correlation
FROM Book;

output:
    correlation     
--------------------
 0.9743657607140666



Q89 Identify gaps in the transaction history for a particular member.
Ans:

SELECT 
    t1.member_id,
    t1.returndate AS prev_return_date,
    t2.issuedate AS next_issue_date,
    t2.issuedate - t1.returndate AS gap_days
FROM Transaction t1
JOIN Transaction t2 ON t1.member_id = t2.member_id AND t1.transaction_id < t2.transaction_id
WHERE t1.returndate < t2.issuedate
ORDER BY t1.member_id, gap_days DESC;

output:
    t1.member_id, gap_days DESC;
 member_id | prev_return_date | next_issue_date | gap_days 
-----------+------------------+-----------------+----------
         3 | 2024-05-19       | 2024-05-22      |        3



Q90 Find books that are either in the Fantasy genre or the Horror genre but not in both.
Ans: 

SELECT b.title
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Fantasy'
UNION
SELECT b.title
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Horror'
EXCEPT
SELECT b.title
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Fantasy'
INTERSECT
SELECT b.title
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Horror';

output:
                  title                  
-----------------------------------------
 1984
 The Shining
 Harry Potter and the Deathly Hallows
 Bird Box
 Harry Potter and the Philosophers Stone
 Dracula



Q91 Aggregate book titles issued to each member into an array.
Ans: 

SELECT 
    m.member_name,
    ARRAY_AGG(b.title) AS books_issued
FROM Transaction t
JOIN Member m ON t.member_id = m.member_id
JOIN Book b ON t.isbn = b.isbn
GROUP BY m.member_name;

output:
 member_name |                        books_issued                        
-------------+------------------------------------------------------------
 Deepin      | {Yesplease,Bossypants}
 Pragya      | {Inception,Yesplease,Inception}
 Nishchay    | {1984,"Harry Potter and the Philosophers Stone",Yesplease}



Q92 Perform a full outer join to find all members and transactions, including those without matches.
Ans:

SELECT 
    m.member_name,
    t.transaction_id,
    b.title,
    t.issuedate,
    t.returndate
FROM Member m
FULL OUTER JOIN Transaction t ON m.member_id = t.member_id
LEFT JOIN Book b ON t.isbn = b.isbn;

output:
 member_name | transaction_id |                  title                  | issuedate  | returndate 
-------------+----------------+-----------------------------------------+------------+------------
 Nishchay    |              2 | 1984                                    | 2024-05-05 | 2024-05-30
 Nishchay    |              1 | Harry Potter and the Philosophers Stone | 2024-05-01 | 2024-05-15
 Pragya      |              3 | Inception                               | 2024-04-08 | 2024-05-19
 Deepin      |              4 | Yesplease                               | 2024-05-13 | 2024-06-10
 Nishchay    |              5 | Yesplease                               | 2024-03-25 | 2024-07-25
 Pragya      |              6 | Yesplease                               | 2024-05-22 | 2024-06-26
 Deepin      |              7 | Bossypants                              | 2024-01-26 | 2024-02-09
 Pragya      |              8 | Inception                               | 2024-04-05 | 2024-07-11
 Naman       |                |                                         |            | 



Q93 Categorize members based on the total fines they have paid.
Ans:

SELECT 
    m.member_name,
    SUM(f.fine_amount) AS total_fines,
    CASE 
        WHEN SUM(f.fine_amount) > 100 THEN 'High Payer'
        WHEN SUM(f.fine_amount) BETWEEN 50 AND 100 THEN 'Medium Payer'
        ELSE 'Low Payer'
    END AS fine_category
FROM Member m
JOIN Transaction t ON m.member_id = t.member_id
JOIN Fine f ON t.transaction_id = f.transaction_id
GROUP BY m.member_name;

output:
 member_name | total_fines | fine_category 
-------------+-------------+---------------
 Nishchay    |       40.00 | Low Payer



Q94 Use UNION ALL to combine results from different genres and group them.
Ans:

SELECT 'Fantasy' AS genre, COUNT(*) AS book_count
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Fantasy'
UNION ALL
SELECT 'Horror', COUNT(*)
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Horror';

output:
  genre  | book_count 
---------+------------
 Fantasy |          2
 Horror  |          4



Q95  Use a lateral join to find the first issued book for each member.
Ans:

SELECT 
    m.member_name,
    first_issue.*
FROM 
    Member m,
    LATERAL (
        SELECT 
            t.issuedate,
            b.title
        FROM Transaction t
        JOIN Book b ON t.isbn = b.isbn
        WHERE t.member_id = m.member_id
        ORDER BY t.issuedate
        LIMIT 1
    ) AS first_issue;

output:
 member_name | issuedate  |   title    
-------------+------------+------------
 Pragya      | 2024-04-05 | Inception
 Deepin      | 2024-01-26 | Bossypants
 Nishchay    | 2024-03-25 | Yesplease



Q96 Use the FILTER clause to calculate aggregate values conditionally.
Ans:

SELECT 
    member_id,
    COUNT(*) FILTER (WHERE issuedate >= '2024-01-01') AS issued_this_year,
    COUNT(*) FILTER (WHERE issuedate < '2024-01-01') AS issued_last_year
FROM Transaction
GROUP BY member_id;

output:
 member_id | issued_this_year | issued_last_year 
-----------+------------------+------------------
         3 |                3 |                0
         4 |                2 |                0
         1 |                3 |                0



Q97 Retrieve the details of all books that are currently borrowed and overdue for return.
Ans:

SELECT b.*
FROM Book b
JOIN Transaction t ON b.isbn = t.isbn
WHERE t.returndate < CURRENT_DATE;

output:
  isbn  |                  title                  | author_id | genre_id | quantity | available_quantity | section_id 
--------+-----------------------------------------+-----------+----------+----------+--------------------+------------
 978014 | 1984                                    |         2 |        2 |       12 |                 12 |          2
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1
 978009 | Inception                               |         2 |        3 |        7 |                  5 |          3
 978077 | Bossypants                              |         1 |        4 |       14 |                 13 |          4



Q98 Retrieve the details of books that have been borrowed less than three times.
Ans: 

SELECT b.*
FROM Book b
JOIN (
    SELECT isbn, COUNT(*) AS borrow_count
    FROM Transaction
    GROUP BY isbn
) AS book_counts ON b.isbn = book_counts.isbn
WHERE book_counts.borrow_count < 3;

output:
  isbn  |                  title                  | author_id | genre_id | quantity | available_quantity | section_id 
--------+-----------------------------------------+-----------+----------+----------+--------------------+------------
 978077 | Bossypants                              |         1 |        4 |       14 |                 13 |          4
 978009 | Inception                               |         2 |        3 |        7 |                  5 |          3
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1
 978014 | 1984                                    |         2 |        2 |       12 |                 12 |          2



Q99 Find the genres where the total available quantity of books is less than 10.
Ans:

SELECT 
    g.genre_name,
    SUM(b.available_quantity) AS total_available_quantity
FROM Book b
JOIN Genre g ON b.genre_id = g.genre_id
GROUP BY g.genre_name
HAVING SUM(b.available_quantity) < 10;

output:
   genre_name    | total_available_quantity 
-----------------+--------------------------
 Fantasy         |                        7
 Literature      |                        7
 Science Fiction |                        0



Q100 Determine the total number of transactions made each month.
Ans:

SELECT 
    EXTRACT(MONTH FROM issuedate) AS month,
    COUNT(*) AS total_transactions
FROM Transaction
GROUP BY month
ORDER BY month;

output:
 month | total_transactions 
-------+--------------------
     1 |                  1
     3 |                  1
     4 |                  2
     5 |                  4


