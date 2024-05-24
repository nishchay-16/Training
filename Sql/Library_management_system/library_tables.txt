CREATING A LIBRARY DATABASE MANAGEMENT SYSTEM USING POSTGRESQL.


!----------------------------CREATION OF DATABASE----------------------------!

command:-  create database Library; (create database)

command:- \l (show all databses)
                             List of databases
   Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges   
-----------+----------+----------+---------+-------+-----------------------
 library   | postgres | UTF8     | C       | C     | 
 postgres  | postgres | UTF8     | C       | C     | 
 railway   | postgres | UTF8     | C       | C     | 
 template0 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
 template1 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres



!----------------------------CREATION OF TABLES------------------------------!

CREATE TABLE Author (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(100),
    nationality VARCHAR(100)
);

CREATE TABLE Genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50)
);

CREATE TABLE Section (
    section_id SERIAL PRIMARY KEY,
    section_name VARCHAR(100),
    capacity INT
);

CREATE TABLE Book (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    genre_id INT,
    quantity INT,
    available_quantity INT,
    section_id INT,
    FOREIGN KEY (author_id) REFERENCES Author(author_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id)
);

CREATE TABLE Member (
    member_id SERIAL PRIMARY KEY,
    member_name VARCHAR(100),
    dob DATE,
    phone_no VARCHAR(20),
    email VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE Librarian (
    librarian_id SERIAL PRIMARY KEY,
    librarian_name VARCHAR(100),
    email VARCHAR(255),
    phone_no VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Transaction (
    transaction_id SERIAL PRIMARY KEY,
    member_id INT,
    isbn VARCHAR(20),
    issuedate DATE,
    returndate DATE,
    librarian_id INT,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (isbn) REFERENCES Book(isbn),
    FOREIGN KEY (librarian_id) REFERENCES Librarian(librarian_id)
);

CREATE TABLE Fine (
    fine_id SERIAL PRIMARY KEY,
    transaction_id INT,
    fine_amount DECIMAL(10,2),
    fine_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (transaction_id) REFERENCES Transaction(transaction_id)
);


Output:-
                       List of relations
 Schema |              Name              |   Type   |  Owner   
--------+--------------------------------+----------+----------
 public | author                         | table    | postgres
 public | author_author_id_seq           | sequence | postgres
 public | book                           | table    | postgres
 public | fine                           | table    | postgres
 public | fine_fine_id_seq               | sequence | postgres
 public | genre                          | table    | postgres
 public | genre_genre_id_seq             | sequence | postgres
 public | librarian                      | table    | postgres
 public | librarian_librarian_id_seq     | sequence | postgres
 public | member                         | table    | postgres
 public | member_member_id_seq           | sequence | postgres
 public | section                        | table    | postgres
 public | section_section_id_seq         | sequence | postgres
 public | transaction                    | table    | postgres
 public | transaction_transaction_id_seq | sequence | postgres



!---------------------------------INSERTING DATA INTO TABLES---------------------------!

1) TABLE (author)---->
 author_id |  author_name  | nationality 
-----------+---------------+-------------
         1 | J.K. Rowling  | British
         2 | George Orwell | African
         3 | MS chauhan    | Indian
         4 | Amy Poehler   | American
         5 | Stephan King  | American

command:-
INSERT INTO Author (Author_name, Nationality)
VALUES
    ('J.K. Rowling', 'British'),
    ('George Orwell', 'African'),
    ('MS chauhan','Indian'),
    ('Amy Poehler', 'American'),
    ('Stephan King','American');


2) TABLE (section)---->
 section_id |      section_name       | capacity 
------------+-------------------------+----------
          1 | Fantasy Section         |      100
          2 | Horror Section          |       50
          3 | Literature Section      |      500
          4 | Comedy Section          |       65
          5 | Science Fiction Section |       80

command:-
INSERT INTO Section (Section_Name, capacity)
VALUES
    ('Fantasy Section', 100),
    ('Horror Section',50),
    ('Literature Section', 500),
    ('Comedy Section',65),
    ('Science Fiction Section', 80);


3) TABLE (genre)---->
 genre_id |   genre_name    
----------+-----------------
        1 | Fantasy
        2 | Horror
        3 | Literature
        4 | Comedy
        5 | Science Fiction

command:-
INSERT INTO Genre (Genre_Name)
VALUES
    ('Fantasy'),
    ('Horror'),
    ('Literature'),
    ('Comedy'),
    ('Science Fiction');


4) TABLE (book) --->
  isbn  |                  title                  | author_id | genre_id | quantity | available_quantity | section_id 
--------+-----------------------------------------+-----------+----------+----------+--------------------+------------
 978055 | Harry Potter and the Philosophers Stone |         1 |        1 |        5 |                  4 |          1
 978054 | Harry Potter and the Deathly Hallows    |         1 |        1 |        3 |                  3 |          1
 978014 | 1984                                    |         2 |        2 |        7 |                  7 |          2
 978076 | Yesplease                               |         1 |        4 |       15 |                 10 |          4
 978077 | Bossypants                              |         1 |        4 |       14 |                 13 |          4
 978009 | Inception                               |         2 |        3 |        7 |                  5 |          3
 978090 | Enders Game                             |         1 |        5 |        1 |                  0 |          5
 977101 | Dracula                                 |         1 |        2 |        3 |                  2 |          2
 977000 | Bird Box                                |         5 |        2 |        7 |                  6 |          2
 978990 | The Shining                             |         5 |        2 |        1 |                  0 |          2
 990208 | Pride and Prejudice                     |         3 |        3 |        2 |                  2 |          3
 975987 | Catch-22                                |         4 |        4 |       19 |                 19 |          4

command:-
INSERT INTO Book (ISBN, Title, Author_ID, Genre_ID, Quantity, Available_Quantity, Section_ID)
VALUES
    ('978055', 'Harry Potter and the Philosophers Stone', 1, 1, 5, 4, 1),
    ('978054', 'Harry Potter and the Deathly Hallows', 1, 1, 3, 3, 1),
    ('978014', '1984', 2, 2, 7, 7, 2),
    ('978076', 'Yesplease', 1, 4, 15, 10, 4),
    ('978077', 'Bossypants', 1, 4, 14, 13, 4),
    ('978009', 'Inception', 2, 3, 7, 5, 3)
    ('978090', 'Enders Game', 1, 5, 1, 0, 5),
    ('977101', 'Dracula', 1,2, 3, 2, 2),
    ('977000', 'Bird Box', 5, 2, 7, 6, 2)
    ('978990', 'The Shining', 5, 2, 1, 0, 2),
    ('990208', 'Pride and Prejudice', 3,3, 2, 2, 3),
    ('975987', 'Catch-22', 4, 4, 19, 19, 4);


5) TABLE (member) --->
 member_id | member_name |    dob     |  phone_no  |            email             |         address          | occupation 
-----------+-------------+------------+------------+------------------------------+--------------------------+------------
         1 | Nishchay    | 2002-10-16 | 9588169118 | nishugupta123gupta@gmail.com | #494 sector-6 karnal     | student
         2 | Naman       | 2002-11-06 | 1234567889 | namandua9@gmail.com          | #2046 sector-7 faridabad | trainee
         3 | Pragya      | 2004-01-24 | 9555599999 | Pragya@gmail.com             | gharaunda                | housewife
         4 | Deepin      | 2002-06-15 | 7777558888 | deepin@gmail.com             | ambala cant              | business

command:-
INSERT INTO Member (Member_Name, DOB, Phone_No, Email, Address)
VALUES
    ('Nishchay', '2002-10-16', '9588169118', 'nishugupta123gupta@gmail.com', '#494 sector-6 karnal','student'),
    ('Naman','2002-11-06','1234567889','namandua9@gmail.com','#2046 sector-7 faridabad','trainee'),
    ('Pragya', '2004-01-24', '9555599999', 'Pragya@gmail.com', 'gharaunda','housewife'),
    ('Deepin','2002-06-15','7777558888','deepin@gmail.com','ambala cant','business');


6) TABLE (librarian)--->
 librarian_id | librarian_name |       email        |  phone_no  |    address     
--------------+----------------+--------------------+------------+----------------
            1 | Dinesh         | dinesh@gmail.com   | 9876543210 | 456 sonipat
            2 | Kavita         | kavita@gmail.com   | 9876543221 | 456 panipat
            3 | Jitender       | jitender@gmail.com | 6666677777 | 321 chandigarh

command:-
INSERT INTO Librarian (Librarian_Name, Email, Phone_No, Address)
VALUES
    ('Dinesh', 'dinesh@gmail.com', '9876543210', '456 sonipat'),
    ('Kavita','kavita@gmail.com','9876543221','456 panipat'),
    ('Jitender','jitender@gmail.com','6666677777','321 chandigarh');


7) TABLE (transaction)--->
 transaction_id | member_id |  isbn  | issuedate  | returndate | librarian_id 
----------------+-----------+--------+------------+------------+--------------
              2 |         1 | 978014 | 2024-05-05 | 2024-05-30 |            1
              1 |         1 | 978055 | 2024-05-01 | 2024-05-15 |            1
              3 |         3 | 978009 | 2024-04-08 | 2024-05-19 |            2
              4 |         4 | 978076 | 2024-05-13 | 2024-06-10 |            3
              5 |         1 | 978076 | 2024-03-25 | 2024-07-25 |            2
              6 |         3 | 978076 | 2024-05-22 | 2024-06-26 |            3
              7 |         4 | 978077 | 2024-01-26 | 2024-02-09 |            3
              8 |         3 | 978009 | 2024-04-05 | 2024-07-11 |            2

command:- 
INSERT INTO Transaction (Member_ID, ISBN, IssueDate, ReturnDate, Librarian_ID)
VALUES
    (1, '978055', '2024-05-01', '2024-05-15', 1),
    (1, '978014', '2024-05-05', '2024-05-30', 1),
    (3, '978009', '2024-04-08', '2024-05-19', 2),
    (4, '978076', '2024-05-13', '2024-06-10', 3),
    (1, '978076', '2024-03-25', '2024-07-25', 2),
    (3, '978076', '2024-05-22', '2024-06-26', 3),
    (4, '978077', '2024-01-26', '2024-02-09', 3),
    (3, '978009', '2024-04-05', '2024-07-11', 2);


8) TABLE (fine) ---->
 fine_id | transaction_id | fine_amount | fine_date  | payment_status 
---------+----------------+-------------+------------+----------------
       1 |              1 |       25.00 | 2024-05-20 | Unpaid
       2 |              1 |       15.00 | 2024-05-23 | Paid

command:-
INSERT INTO Fine (transaction_id, fine_amount, fine_date, payment_status)
VALUES
    (1, 25.00, '2024-05-20', 'Unpaid'),
    (1, 15.00, '2024-05-23', 'Paid');



