PostgreSQL :-->
It is a powerful, open-source object-relational database management system (ORDBMS).
It has a strong reputation for reliability, feature robustness, and performance. 

How to enter postgres terminal in terminal:- 
   command:  psql -U postgres


1)Creating and Managing Databases ---->

    Create a new database:-
        command: CREATE DATABASE <database_name>;

    List all databases:-
        command:  \l

    Connect to a database:-
        command: \c <database_name>

    DROP DATABASE mydatabase;
        command: DROP DATABASE <database_name>;


2)Creating and Managing Tables ---->

    Create a new table:-
        CREATE TABLE <table_name> (
          id SERIAL PRIMARY KEY,
          name VARCHAR(100),
          email VARCHAR(100) UNIQUE
        );

    List all tables:-
        command: \dt

    Describe a table (show table schema):-
        command: \d <table_name>

    Drop a table:-
        command: DROP TABLE <table_name>;


3)Inserting, Updating & Deleting Data ---->

    Insert data into a table:-
        command: INSERT INTO <table_name> (name, email) 
                 VALUES ('Nishchay', 'nishchay.gupta@berylsystems.com'),
                        ('Naman', 'naman.dua@berylsystems.com');
    
    Update data in a table:- 
        command: UPDATE <table_name> 
                 SET email = 'nishugupta123gupta@gmail.com' 
                 WHERE name = 'Nishchay';

    Delete data from a table:-
        command: DELETE FROM <table_name> 
                 WHERE name = 'Nishchay';


4)Constraints ----->

    UNIQUE:- It ensures that all values in a column are unique.
        command: CREATE TABLE <table_name> (
                    user_id INT PRIMARY KEY,
                    email VARCHAR(100) UNIQUE
                 );

    NOT NULL:- It ensures that a column cannot have a NULL value.
        command: CREATE TABLE <table_name> (
                    id INT NOT NULL,
                    first_name VARCHAR(50) NOT NULL,
                    last_name VARCHAR(50) NOT NULL
                 );

    DEFAULT:- It provides a default value for a column when none is specified.
        command: CREATE TABLE <table_name> (
                    id INT PRIMARY KEY,
                    name VARCHAR(100),
                    price DECIMAL(10, 2) DEFAULT 0.00
                 );

    PRIMARY KEY:- It uniquely identifies each record in a table. A primary key column cannot have NULL values and must contain unique values.
        command: CREATE TABLE <table_name> (
                    id INT PRIMARY KEY,
                    date DATE NOT NULL
                 );

    FOREIGN KEY:- It ensures the referential integrity of the data in one table to match values in another table.
        command: CREATE TABLE booking (
                    user_id INT , 
                    ticket_id INT, 
                    constraint fk_user FOREIGN KEY(user_id) REFERENCES users(user_id),
                    constraint fk_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)
                 );

    CHECK:- It ensures that all values in a column satisfy a specific condition.
        command: CREATE TABLE users (
                    id INT PRIMARY KEY,
                    age INT CHECK (age >= 18)
                );


5)Alter Tables ---->

    Add a new column:-
        command: ALTER TABLE <table_name>
                 ADD <column_name> <datatype> <constraint>;

    Drop a column:- 
        command: ALTER TABLE <table_name>
                 DROP COLUMN <column_name>;

    Modify a column:-
        command: ALTER TABLE <table_name>
                 MODIFY COLUMN <column_name> <datatype> <constraint>;

    Rename a column:- 
        command: ALTER TABLE <table_name>
                 RENAME COLUMN <old_column_name> TO <new_column_name>;

    Rename a table:- 
        command: ALTER TABLE <old_table_name>
                 RENAME TO <new_table_name>;

    Adding constraint to table:-
        command: ALTER TABLE <table_name>
                 ADD CONSTRAINT <constraint_name> <constraint_type> <column_name>;

    Drop constraint from table:-
        command: ALTER TABLE <table_name>
                 DROP CONSTRAINT <constraint_name>;

    Changing column position:-
        command: ALTER TABLE <table_name>
                 MODIFY COLUMN <column_name> <datatype> <constraint> AFTER <another_column>;

    Enable constraint:-
        command: ALTER TABLE <table_name>
                 ENABLE CONSTRAINT <constraint_name>;

    Disable constraint:-
        command: ALTER TABLE <table_name>
                 DISABLE CONSTRAINT <constraint_name>;


6)Clauses ---->

    SELECT clause:-
        It is used to specify the columns to be returned in the query result.
        command: SELECT column1, column2 
                 FROM <table_name>;

    FROM clause:-
        It specifies the table or tables from which to retrieve the data.
        command: SELECT column1, column2 
                 FROM <table_name>;

    WHERE clause:-
        It filters the records to be returned based on specified conditions.
        command: SELECT column1, column2 
                 FROM <table_name> 
                 WHERE condition;

    INSERT clause:- 
        It adds new rows to a table.
        command: INSERT INTO <table_name> (column1, column2) 
                 VALUES (value1, value2);

    DELETE clause:-
        It removes rows from a table based on condition.
        command: DELETE FROM <table_name>
                 WHERE condition;
    
    UPDATE clause:-
        It modifies the existing rows in table based on condition.
        command: UPDATE table_name 
                 SET column1 = value1, column2 = value2 
                 WHERE condition;

    GROUP BY clause:-
        It group rows that have the same values in specified columns into summary rows.
        command: SELECT column1, COUNT(*) 
                 FROM <table_name>
                 GROUP BY column1;
    
    HAVING clause:-
        It filters groups based on specified conditions and used with GROUP BY clause.
        command: SELECT column1, COUNT(*) 
                 FROM <table_name> 
                 GROUP BY column1 
                 HAVING COUNT(*) > 1;
    
    ORDER BY clause:- 
        It sorts the result set in ascending or descending order.
        command: SELECT column1, column2 
                 FROM <table_name>
                 ORDER BY column1 ASC, column2 DESC;
    
    LIMIT clause:-
        It limits the number of rows returned by the query.
        command: SELECT column1, column2 
                 FROM <table_name>
                 LIMIT number_of_rows;
    
    OFFSET clause:-
        It skips a specified number of rows before beginning to return the rows.
        command: SELECT column1, column2 
                 FROM <table_name> 
                 OFFSET number_of_rows;

    UNION clause:-
        It combines the result sets of two or more SELECT statements, removing duplicates.
        command: SELECT column1 FROM table1
                 UNION
                 SELECT column1 FROM table2;

    UNION ALL Clause:-
        It combines the result sets of two or more SELECT statements, including duplicates.
        command: SELECT column1 FROM table1
                 UNION ALL
                 SELECT column1 FROM table2;
    
    EXCEPT clause:-
        It returns the result set of the first SELECT statement that do not appear in second SELECT statement.
        command: SELECT column1 FROM table1
                 EXCEPT
                 SELECT column1 FROM table2;

    INTERSECT clause:-
        It returns the result set that is intersection of result sets of two SELECT statements.
        command: SELECT column1 FROM table1
                 INTERSECT
                 SELECT column1 FROM table2;

7) Views ----->
    Views are virtual tables that are based on the result of a SELECT query. 
    They do not store data physically but allow us to look at the data stored in tables.
    
    Creating a View:-
        command: CREATE VIEW <view_name> AS
                 SELECT column1, column2, ...
                 FROM <table_name>
                 WHERE condition;

    Updating a View:-
        command: UPDATE <view_name>
                 SET age = 17
                 WHERE user_id = 1802;

    Deleting rows from View:-
        command: DELETE FROM <view_name>
                 WHERE condition;

    Droping a View:-
        command: DROP VIEW <view_name>;


8) Schema ---->
        A schema is a named collection of tables. 
        A schema can also contain views, indexes, sequences, data types, operators, and functions. 
        It allows many users to use one database without interfering with each other.
        t organizes database objects into logical groups to make them more manageable.

    Create schema:-
        command: CREATE SCHEMA <schema_name>;

    Drop a schema:-
        command: DROP SCHEMA <schema_name>;

    Create a table in schema:-
        command: Create table myschema.company(
                    ID   INT              NOT NULL,
                    NAME VARCHAR (20)     NOT NULL,
                    AGE  INT              NOT NULL,
                    ADDRESS  CHAR (25),
                    SALARY   DECIMAL (18, 2),
                    PRIMARY KEY (ID)
                 );
    

9)TRANSACTIONS ---->
        It is a unit of work performed against a database .
	    It can be a unit or sequence of work accomplished in logical order, either manually or automatically.
        It is the propagation of one or more changes to the database
	    It is important to control transaction to ensure high data integrity and to handle database errors.

	Properties of transaction (ACID PROPERTIES):
			Atomicity - Ensures that all operations within the work unit are completed successfully otherwise, the transaction is aborted at the point of failure and previous operations are rolled back to their former state.
			Consistency - Ensures that the database properly changes states upon a successfully committed transaction.
			Isolation - Enables transactions to operate independently of and transparent to each other.
			Durabilty - Ensures that the result or effect of a committed transaction persists in case of a system failure

	Transaction Control Commands (used uith INSERT , UPDATE, DELETE):
			BEGIN TRANSACTION - It is used to start a transaction.
					command:  BEGIN | BEGIN TRANSACTION

			COMMIT -  It is used to save changes after the last commit .
                      It is the transactional command used to save changes invoked by a transaction to the database.
                      It saves all transactions to the database since the last COMMIT or ROLLBACK command.
					command:  COMMIT | END TRANSACTION

			ROLLBACK - It is used to rollback to the last commit.
                       It is the transactional command used to undo transactions that have not already been saved to the database.
					command:  ROLLBACK;


10)TRIGGERS ---->
        These are database callback functions , which are automatially performed when a specific event occurs in the database.
        If multiple triggers of the same kind are defined for the same event, they will be fired in alphabetical order by name.
        A trigger that is marked FOR EACH ROW is called once for every row that the operation modifies.

        command: CREATE  TRIGGER trigger_name [BEFORE|AFTER|INSTEAD OF] event_name
                 ON table_name
                [
                    -- Trigger logic goes here....
                ];

        example: CREATE TRIGGER example_trigger 
                 AFTER INSERT ON COMPANY
                 FOR EACH ROW 
                 EXECUTE PROCEDURE auditlogfunc();

        above example contains function auditlogfunc() which is a trigger function and has definition-
            CREATE OR REPLACE FUNCTION auditlogfunc() RETURNS TRIGGER AS <example_table>
                BEGIN
                    INSERT INTO AUDIT(EMP_ID, ENTRY_DATE) VALUES (new.ID, current_timestamp);
                    RETURN NEW;
                END;
            <example_table> LANGUAGE plpgsql;

        Listing Triggers:-
            command:  \d+ trigger_name;
                      SELECT * FROM trigger_name;

        Dropping Triggers:-
            command:  DROP TRIGGER trigger_name;

        
11)INDEXES ---->
        They are special lookup tables that the database search engine can use to speed up data retrieval.
        They are used to increase the performance of queries.
        An index is a pointer to data in a table.
        An index helps to speed up SELECT queries and WHERE clauses; 
        however, it slows down data input, with UPDATE and INSERT statements.

        Creating a index:-
            command: CREATE INDEX index_name 
                     ON table_name (column1, column2, ...);

        Dropping an index:-
            command: DROP INDEX index_name;

    Types:-
        * Single-Column Indexes ->
            It is one that is created based on only one table column.
            command: CREATE INDEX index_name
                     ON table_name (column_name);

        * Multi-Column Indexes ->
            It is one that is created based on more than one table column.
            command: CREATE INDEX index_name
                     ON table_name (column1, column2, ...);

        * Unique Indexes ->
            It is a special index that ensures that all values in a column are unique.
            It does not allow any duplicate values to be inserted into the table.
            command: CREATE UNIQUE INDEX index_name
                     ON table_name (column_name);
        
        * Partial Indexes ->
            It is an index built over a subset of a table; the subset is defined by a conditional expression (called the predicate of the partial index).
            The index contains entries only for those table rows that satisfy the predicate
            command: CREATE INDEX index_name
                     ON table_name (conditional_expression);
            example: CREATE INDEX index_name
                     ON table_name (title LIKE '%the%');

        * Implicit Indexes ->
            It is an index created automatically by the database engine.
            command: CREATE INDEX index_name
                     ON table_name USING btree (column_name);
            example: CREATE INDEX salary_index 
                     ON employees (salary);

    B-tree is a self-balancing tree data structure that maintains sorted data and allows for efficient insertion, deletion, and search operations.


12) LOCKS ---->
        It is a mechanism that the database engine uses to prevent concurrent access to a table.
        Locks are also known as Exclusive Locks or Write Locks 
        It is used to prevent users from modifying a row or an entire table.

        command:  LOCK [ TABLE ] <table_name> 
                  IN lock_mode

            lock_mode − The lock mode specifies which locks this lock conflicts with.
                        If no lock mode is specified, then ACCESS EXCLUSIVE, the most restrictive mode, is used.
                        Possible values are: 
                                ACCESS SHARE, 
                                ROW SHARE, 
                                ROW EXCLUSIVE, 
                                SHARE UPDATE EXCLUSIVE, 
                                SHARE, 
                                SHARE ROW EXCLUSIVE, 
                                EXCLUSIVE, 
                                ACCESS EXCLUSIVE.

            * There is no UNLOCK TABLE command; locks are always released at the transaction end.

            DEADLOCKS: It occurs when two transactions are waiting for each other to finish .
            ADVISORY LOCKS: It is a lock mechanism that prevents deadlocks.

            example: BEGIN;
                     LOCK TABLE company1 
                     IN ACCESS EXCLUSIVE MODE;


13) 