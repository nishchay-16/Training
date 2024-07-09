--------------------- DATE / TIME / DATE-TIME METHODS IN RUBY -----------------------

* TIME CLASS METHODS :
The Time class in Ruby represents dates and times. 
Its part of the core Ruby library and provides various methods for working with dates and times.

1) Time.new -> Creates a new instance of Time with the current time.
Example:
time = Time.new
puts time         # Output: 2024-07-09 18:22:54 +0530

2) Time.now -> Returns the current time. Its an alias for Time.new.
Example: 
time_now = Time.now
puts time_now    # Output: 2024-07-09 18:29:08 +0530

3) Time.year -> Returns the year of the Time object.
Example:
time = Time.now
year = time.year
puts year        # Output: 2024 

4) Time.month -> Returns the month (1-12) of the Time object.
Example: 
time = Time.now
month = time.month
puts month       # Output: 7

5) Time.day -> Returns the day of the month (1-31) of the Time object.
Example: 
time = Time.now
day = time.day
puts day         # Output: 9

6) Time.wday -> Returns the day of week (0-6, Sunday is 0) of the Time object.
Example: 
time = Time.now
day_of_week = time.wday
puts day_of_week  # Output: 2

7) Time.yday -> Returns the day of year (1-366) of the Time object.
Example: 
time = Time.now
day_of_year = time.yday
puts day_of_year  # Output: 191

8) Time.hour -> Returns the hour (0-23) of the Time object.
Example:
time = Time.now
hour = time.hour
puts hour         # Output: 18

9) Time.min -> Returns the minute (0-59) of the Time object.
Example:
time = Time.now
minute = time.min
puts minute          # Output: 33

10) Time.sec -> Returns the second (0-59) of the Time object.
Example:
time = Time.now
second = time.sec
puts second          # Output: 25

11) Time.usec -> Returns the microsecond (0-999999) of the Time object.
Example:
time = Time.now
microsecond = time.usec
puts microsecond     # Output: 772101

12) Time.zone -> Returns the time zone name associated with the Time object.
Example:
time = Time.now
zone = time.zone
puts zone           # Output: IST

13) Time.local(y,m,d,h,min,sec) -> Returns a new Time object representing the given local time.
Example:
local_time = Time.local(2024, 7, 9, 15, 0, 0)
puts local_time     # Output: 2024-07-09 15:00:00 +0530

14) Time.utc(y,m,d,h,min,sec) -> Returns a new Time object representing the given UTC time.
Example:
utc_time = Time.utc(2024, 7, 9, 13, 0, 0)
puts utc_time        # Output: 2024-07-09 13:00:00 UTC

15) Time.gm(y,m,d,h,min,sec) -> Alias for time.utc. Returns a new Time object representing the given Greenwich Mean Time (GMT)
Example:
gmt_time = Time.gm(2024, 7, 9, 13, 0, 0)
puts gmt_time        # Output: 2024-07-09 13:00:00 UTC

16) Time.now.strftime("%Y-%m-%d %H:%M:%S") ->  Formats the Time object into a string using the specified format.
Example:
time = Time.now
formatted_time = time.strftime("%Y-%m-%d %H:%M:%S")
puts formatted_time  # Output: 2024-07-09 18:31:34

17) Time.utc? -> Checks if the Time object is in UTC (Coordinated Universal Time) format.
Example:
time = Time.now
is_utc = time.utc?
puts is_utc           # Output: false 

18) Time.localtime -> Converts the Time object to local time zone.
Example:
utc_time = Time.utc(2024, 7, 9, 13, 0, 0)
local_time = utc_time.localtime
puts local_time        # Output: 2024-07-09 18:30:00 +0530

19) Time.gmtime -> Converts the Time object back to UTC (Coordinated Universal Time).
Example;
local_time = Time.local(2024, 7, 9, 15, 0, 0)
utc_time = local_time.gmtime
puts utc_time         # Output: 2024-07-09 09:30:00 UTC

20) Time.getlocal -> Returns a new Time object in the local time zone.
Example:
time = Time.now.utc
local_time = time.getlocal
puts local_time       # Output: 2024-07-09 18:32:10 +0530

21) Time.getutc -> Returns a new Time object in UTC (Coordinated Universal Time).
Example:
time = Time.now
utc_time = time.getutc
puts utc_time        # Output: 2024-07-09 13:02:22 UTC
