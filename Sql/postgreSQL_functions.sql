<------------------------POSTGRESQL FUNCTIONS------------------------->

FUNCTIONS (also referred to as STORED PROCEDURES) are a way to encapsulate SQL code and business logic.
They can take arguments, perform operations, and return results.
PostgreSQL supports functions written in various languages, including SQL, PL/pgSQL (a procedural language for PostgreSQL).


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

    * CURRENT_TIME:-
        It returns the current time.
        command: SELECT CURRENT_TIME;

    * CURRENT_TIMESTAMP:-
        It returns the current timestamp.
        command: SELECT CURRENT_TIMESTAMP;

    * LOCALTIME:-
        It returns the current time in the local time zone.
        command: SELECT LOCALTIME;

    * LOCALTIMESTAMP:-
        It returns the current timestamp in the local time zone.
        command: SELECT LOCALTIMESTAMP;

    * NOW:-
        It returns the current timestamp in the local time zone.
        command: SELECT NOW();

    * TRANSACTION_TIMESTAMP:-
        It returns the timestamp of the current transaction.
        command: SELECT TRANSACTION_TIMESTAMP();
    
    * STATEMENT_TIMESTAMP:-
        It returns the timestamp of the current statement.
        command: SELECT STATEMENT_TIMESTAMP();

    * CLOCK_TIMESTAMP:-     
        It returns the timestamp of the current clock.
        command: SELECT CLOCK_TIMESTAMP();

    * TIMEOFDAY:-       
        It returns the current time in the local time zone.
        command: SELECT TIMEOFDAY();



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

