<------------------------POSTGRESQL FUNCTIONS------------------------->

FUNCTIONS (also referred to as STORED PROCEDURES) are a way to encapsulate SQL code and business logic.
They can take arguments, perform operations, and return results.
PostgreSQL supports functions written in various languages, including SQL, PL/pgSQL (a procedural language for PostgreSQL).

    CREATE A FUNCTION:-
        syntax:
                CREATE [OR REPLACE] FUNCTION function_name (arguments) 
                RETURNS return_datatype AS $variable_name$
                    DECLARE
                        declaration;
                        [...]
                    BEGIN
                        < function_body >
                        [...]
                        RETURN { variable_name | value }
                    END; LANGUAGE plpgsql;

        where,
        function_name: It is the name of the function.
        arguments: It is a list of input parameters that the function takes.
        return_datatype: It is the data type that the function returns.
        function_body: It is the code that the function executes.
        plpgsql: It is a procedural language for PostgreSQL.


    DROP A FUNCTION:-
        syntax: DROP FUNCTION function_name (arguments);




DATE & TIME FUNCTIONS :-

1)AGE:-
    It returns the difference between two dates.
    command: SELECT AGE('2020-01-01'::date, '2019-01-01'::date);
    output: 1 year

    * AGE(timestamp):
        It returns the difference between current timestamp and the given timestamp.
        command: SELECT AGE(timestamp '1957-06-13');
        output:  66 years 11 mons 15 days

    * AGE(timestamp, timestamp):
        It returns the difference between two given timestamps.
        command: SELECT AGE(timestamp '2001-04-10', timestamp '1957-06-13');
        output:  43 years 9 mons 27 days



2) CURRENT DATE/TIME:-

    * CURRENT_DATE:-
        It returns the current date.
        command: SELECT CURRENT_DATE;
        output:  current_date 
                --------------
                  2024-05-28

    * CURRENT_TIME:-
        It returns the current time.
        command: SELECT CURRENT_TIME;
        output:      current_time      
                -----------------------
                 13:27:50.615611+05:30

    * CURRENT_TIMESTAMP:-
        It returns the current timestamp.
        command: SELECT CURRENT_TIMESTAMP;
        output:         current_timestamp         
                ----------------------------------
                 2024-05-28 13:28:09.164961+05:30

    * LOCALTIME:-
        It returns the current time in the local time zone.
        command: SELECT LOCALTIME;
        output:     localtime    
                -----------------
                 13:28:29.028227

    * LOCALTIMESTAMP:-
        It returns the current timestamp in the local time zone.
        command: SELECT LOCALTIMESTAMP;
        output:        localtimestamp       
                ----------------------------
                 2024-05-28 13:28:36.421944

    * NOW:-
        It returns the current timestamp in the local time zone.
        command: SELECT NOW();
        output:                now                
                ----------------------------------
                 2024-05-28 13:29:01.862886+05:30

    * TRANSACTION_TIMESTAMP:-
        It returns the timestamp of the current transaction.
        command: SELECT TRANSACTION_TIMESTAMP();
        output:       transaction_timestamp      
                ---------------------------------
                 2024-05-28 13:32:00.06546+05:30
    
    * STATEMENT_TIMESTAMP:-
        It returns the timestamp of the current statement.
        command: SELECT STATEMENT_TIMESTAMP();
        output:        statement_timestamp        
                ----------------------------------
                 2024-05-28 13:31:43.740932+05:30


    * CLOCK_TIMESTAMP:-     
        It returns the timestamp of the current clock.
        command: SELECT CLOCK_TIMESTAMP();
        output:          clock_timestamp          
                ----------------------------------
                 2024-05-28 13:31:28.569498+05:30

    * TIMEOFDAY:-       
        It returns the current time in the local time zone.
        command: SELECT TIMEOFDAY();
        output:               timeofday              
                -------------------------------------
                 Tue May 28 13:31:13.274481 2024 IST



3) DATE_PART:-
        It returns the specified part of a date.

        valid field names :
        century, 
        day, 
        decade, 
        dow, 
        doy, 
        epoch, 
        hour, 
        isodow, 
        isoyear, 
        microseconds, 
        millennium, 
        milliseconds, 
        minute, 
        month, 
        quarter, 
        second, 
        timezone, 
        timezone_hour, 
        timezone_minute, 
        week, 
        year

    * DATE_PART('field', timestamp):
        command: SELECT date_part('day', TIMESTAMP '2001-02-16 20:38:40');
        output: 16

        command: SELECT date_part('century', TIMESTAMP '2001-02-16 20:38:40');
        output: 21

    * DATE_PART('field',interval):
        command: SELECT date_part('day', interval '5 days');
        output: 5   

        command: SELECT date_part('hour', INTERVAL '4 hours 3 minutes');
        output: 4
        
    * DATE_TRUNC('field', timestamp):
        It is used to truncate a timestamp or date to a specified level of precision. 

            command: SELECT date_trunc('day', TIMESTAMP '2001-02-16 20:38:40');
            output: 2001-02-16 00:00:00

            command: SELECT date_trunc('minute', TIMESTAMP '2001-02-16 20:38:40');
            output: 2001-02-16 20:38:00

            command: SELECT date_trunc('month', TIMESTAMP '2001-02-16 20:38:40');
            output: 2001-02-01 00:00:00 



4) EXTRACT:-
        It returns the specified part of a date.
        
    * EXTRACT(field FROM timestamp):
        command: SELECT EXTRACT('day' FROM TIMESTAMP '2001-02-16 20:38:40');
        output: 16  

    * EXTRACT(field FROM interval):     
        command: SELECT EXTRACT('day' FROM interval '5 days');
        output: 5
  


5) ISFINITE:-
        It returns true if the date is finite.
        command: SELECT ISFINITE('2020-01-01'::date);
                 SELECT ISFINITE(TIMESTAMP '2020-01-01');
        output: true
        
        command: SELECT ISFINITE('2020-01-32'::date);
        output: false

    * ISFINITE(date):
        It returns true if the date is infinite.
        command: SELECT ISFINITE('2020-01-01'::date);
        output: false

    * ISFINITE(timestamp):
        It returns true if the timestamp is finite.
        command: SELECT ISFINITE(TIMESTAMP '2020-01-01');
        output: true

    * ISFINITE(interval):
        It returns true if the interval is finite.
        command: SELECT ISFINITE(interval '5 days');
        output: true



6) JUSTIFY:-
        It returns the date with the specified number of months added.

    * JUSTIFY_DAYS(interval):
        It returns the date with the specified number of days added.
        command: SELECT JUSTIFY_DAYS(interval '5 days');
        output:  justify_days 
                --------------
                    5 days

    * JUSTIFY_HOURS(interval):
        It returns the date with the specified number of hours added.
        command: SELECT JUSTIFY_HOURS(interval '27 hours');
        output:  justify_hours  
                ----------------
                 1 day 03:00:00

    * JUSTIFY_INTERVAL(interval):
        It returns the date with the specified number of seconds added.
        command: SELECT JUSTIFY_INTERVAL(interval '5 seconds');
        output:  justify_interval 
                ------------------
                    5 seconds

        command:  SELECT justify_interval(interval '1 mon -1 hour');
        output:   justify_interval 
                 ------------------
                  29 days 23:00:00

        command: SELECT justify_interval(interval '1 year 2 mon -5 days +1 hour');
        output:        justify_interval        
                -------------------------------
                 1 year 1 mon 25 days 01:00:00



7)DATE ARITHMETIC:-
        It returns the date with the specified number of days added.
        command: SELECT '2020-01-01'::date + INTERVAL '5 days';
        output: 2020-01-06

        command: SELECT '2020-01-01'::date - INTERVAL '5 days';
        output: 2019-12-27




STRING FUNCTIONS:-

1) LENGTH:-
        It returns the length of the string.
        command: SELECT LENGTH('Naman');
        output: 5

2) UPPER:-
        It converts the string to uppercase.
        command: SELECT UPPER('Nishchay');
        output: NISHCHAY

3) LOWER:-
        It converts the string to lowercase.
        command: SELECT LOWER('Nishchay');
        output: nishchay

4) SUBSTR:-
        It returns the substring of the string.
        command: SELECT SUBSTR('Nishchay', 2, 3);
        output: ish

5) CONCAT:-
        It concatenates the string.
        command: SELECT CONCAT('Nishchay', 'Gupta');
        output: NishchayGupta

6) REPLACE:-
        It replaces the substring in the string.
        command: SELECT REPLACE('Nishchay', 'chay', 'Gupta');
        output: NishGupta

7) TRIM:-
        It removes the leading and trailing spaces from the string.
        command: SELECT TRIM('  Nishchay  ');
        output: Nishchay

8) LTRIM:-
        It removes the leading spaces from the string.
        command: SELECT LTRIM('  Nishchay  ');
        output: Nishchay

9) RTRIM:-
        It removes the trailing spaces from the string.
        command: SELECT RTRIM('  Nishchay  ');
        output: Nishchay 

10) POSITION:-
        It returns the position of the substring in the string.
        command: SELECT POSITION('chay' IN 'Nishchay');
        output: 4

11) REPEAT:-
        It repeats the string the specified number of times.
        command: SELECT REPEAT('Nishchay', 3);
        output: NishchayNishchayNishchay

12) REVERSE:-
        It reverses the string.
        command: SELECT REVERSE('Nishchay');
        output: yahtsiN

13) LEFT:-
        It returns the leftmost characters of the string.
        command: SELECT LEFT('Nishchay', 4);
        output: Nish

14) RIGHT:-
        It returns the rightmost characters of the string.
        command: SELECT RIGHT('Nishchay', 3);
        output: hay

15) RPAD:-
        It pads the string with spaces to the specified length.
        command: SELECT RPAD('Nishchay', 10, '*');
        output:  Nishchay**

16) LPAD:-
        It pads the string with spaces to the specified length.
        command: SELECT LPAD('Nishchay', 10, '*');
        output: **Nishchay

17) CHAR_LENGTH:-   
        It returns the length of the string.
        command: SELECT CHAR_LENGTH('Nishchay');
        output: 8 

18) CONCAT_WS:-
        It concatenates the string with the specified separator.
        command: SELECT CONCAT_WS('-', 'Nishchay', 'Gupta');
        output: Nishchay-Gupta

19) BIT_LENGTH:-
        It returns the length of the string in bits.
        command: SELECT BIT_LENGTH('Nishchay');
        output: 64

20) ASCII:-
        It returns the ASCII value of the first character in the string.
        command: SELECT ASCII('Nishchay');
        output: 78




MATHEMATICAL FUNCTIONS:-

1) ABS:-
        It returns the absolute value of the number.
        command: SELECT ABS(-10);
        output: 10

2) SQRT:-
        It returns the square root of the number.
        command: SELECT SQRT(25);
        output: 5

3) CEIL or CEILING:-
        It returns the smallest integer that is greater than or equal to the number.
        command: SELECT CEIL(10.5);
        output: 11

4) FLOOR:-
        It returns the largest integer that is less than or equal to the number.
        command: SELECT FLOOR(10.5);
        output: 10

5) Round:-
        It rounds the number to the specified number of decimal places.
        command: SELECT ROUND(10.5);
        output: 11

6) TRUNC:-
        It truncates the number to the specified number of decimal places.
        command: SELECT TRUNC(10.5);
        output: 10  

7) MOD:-
        It returns the remainder of the division of the two numbers.
        command: SELECT MOD(10, 3);
        output: 1

8) POWER or POW :- 
        It returns the result of raising the first number to the power of the second number.
        command: SELECT POWER(2, 3);
        output: 8

        command: SELECT POW(2, 3);
        output: 8

9) RANDOM:-
        It returns a random number between 0 and 1.
        command: SELECT RANDOM();
        output: 0.4610965802828153

10) RADIANS:-
        It returns the angle in radians.
        command: SELECT RADIANS(90);
        output: 1.5707963267948966

11) DEGREES:-
        It returns the angle in degrees.
        command: SELECT DEGREES(1.5707963267948966);
        output: 90

12) PI:-
        It returns the value of pi.
        command: SELECT PI();
        output: 3.141592653589793

13) LEAST:-
        It returns the smallest value of the two numbers.
        command: SELECT LEAST(10, 20);
        output: 10

14) GREATEST:-
        It returns the largest value of the two numbers.
        command: SELECT GREATEST(10, 20);
        output: 20

15) COT:-
        It returns the cotangent of the angle.
        command: SELECT COT(45);
        output: 0.6420926159343307

16) SIN:-
        It returns the sine of the angle.
        command: SELECT SIN(45);
        output: 0.5253219888177297

17) COS:-
        It returns the cosine of the angle.
        command: SELECT COS(45);
        output: 0.5253219888177297

18) TAN:-
        It returns the tangent of the angle.
        command: SELECT TAN(45);
        output: 1.6197751905438613




AGGREGATE FUNCTIONS:-

1) AVG:-
        It returns the average of the numbers.
        command: SELECT avg(salary) FROM employees;  

2) COUNT:-
        It returns the number of rows in the table.
        command: SELECT COUNT(*) FROM employees;

3) MAX:-
        It returns the maximum value in the column.
        command: SELECT MAX(salary) FROM employees;

4) MIN:-
        It returns the minimum value in the column.
        command: SELECT MIN(salary) FROM employees; 

5) SUM:-
        It returns the sum of the values in the column.
        command: SELECT SUM(salary) FROM employees; 



        
CONDITIONAL EXPRESSIONS:-
        It is used to evaluate a condition and return a value based on the result of the condition.
        
1) CASE:-
        It is used to evaluate a condition and return a value based on the result of the condition.
        command: SELECT 
                    CASE 
                        WHEN salary > 1000 THEN 'High' 
                        WHEN salary > 500 THEN 'Medium' 
                        ELSE 'Low' 
                    END 
                 FROM employees;

2) COALESCE:-
        It returns the first non-null value in the list.
        command: SELECT COALESCE(NULL, NULL, 'Nishchay', NULL, 'Gupta');
        output: Nishchay

3) NULLIF:-
        It returns NULL if the two values are equal, otherwise it returns the first value.
        command: SELECT NULLIF(10, 10);
        output: NULL

        command: SELECT NULLIF(10, 5);
        output: 10