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

output:
 member_name |    dob     | age 
-------------+------------+-----
 Nishchay    | 2002-10-16 |  21
 Naman       | 2002-11-06 |  21
 Pragya      | 2004-01-24 |  20
 Deepin      | 2002-06-15 |  21


Q22 Find the name of the member who has borrowed the most books.
Ans: 