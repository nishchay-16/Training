--------------------- DATE / TIME / DATE-TIME METHODS IN RUBY -----------------------

<---------- TIME CLASS METHODS ------>
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



<-------------- DATE CLASS METHODS ----------------->
Class Date provides methods for storing and manipulating calendar dates.
Class Date handles only dates.
A Date object, once created, is immutable, and cannot be modified.

1) Date.new(year, month, day) -> Creates a new Date object with the specified year, month, and day.
Example:
require 'date'
date = Date.new(2024, 7, 10)
puts date         # Output: 2024-07-10

2) Date.httpdate -> Parses a date/time string in the HTTP-date format.
Example:
require 'date'
date = Date.httpdate("Sun, 06 Nov 1994 08:49:37 GMT")
puts date         # Output: 1994-11-06

3) Date._httpdate -> Returns the parsed date as a hash from the HTTP-date string.
Example:
require 'date'
hash = Date._httpdate("Sun, 06 Nov 1994 08:49:37 GMT")
puts hash         # Output: {:year=>1994, :mon=>11, :mday=>6, :hour=>8, :min=>49, :sec=>37, :zone=>"GMT"}

4) Date.iso8601 -> Parses a date/time string in the ISO 8601 format.
Example:
require 'date'
date = Date.iso8601("2024-07-10")
puts date         # Output: 2024-07-10

5) Date._iso8601 -> Returns the parsed date as a hash from the ISO 8601 string.
Example: 
require 'date'
hash = Date._iso8601("2024-07-9")
puts hash         # Output: {:year=>2024, :mon=>7, :mday=>9}

6) Date.jisx0301 -> Parses a date/time string in the JIS X 0301 format.
Example: 
require 'date'
date = Date.jisx0301("H26.07.10")
puts date         # Output: 2014-07-10

7) Date._jisx0301 -> Returns the parsed date as a hash from the JIS X 0301 string.
Example:
require 'date'
hash = Date._jisx0301("H26.07.9")
puts hash          # Output: {:year=>2014, :mon=>7, :mday=>9, :era=>"H"}

8) Date._parse(string) -> Returns a hash of values parsed from the string (e.g., 'yyyy-mm-dd').
Example:
require 'date'
hash = Date._parse("2024-07-10")
puts hash           # Output: {:year=>2024, :mon=>7, :mday=>10}

9) Date.parse(string) -> Returns a new Date object with values parsed from the string.
Example:
require 'date'
date = Date.parse("2024-07-10")
puts date           # Output: 2024-07-10

10) Date.rfc2822 -> Parses a date/time string in the RFC 2822 format.
Example:
require 'date'
date = Date.rfc2822("Sun, 06 Nov 1994 08:49:37 GMT")
puts date           # Output: 1994-11-06

11) Date._rfc2822 -> Returns the parsed date as a hash from the RFC 2822 string.
Example:
require 'date'
hash = Date._rfc2822("Sun, 06 Nov 1994 08:49:37 GMT")
puts hash           # Output: {:wday=>0, :mday=>6, :mon=>11, :year=>1994, :hour=>8, :min=>49, :sec=>37, :zone=>"GMT", :offset=>0} 

12) Date.rfc3339 -> Parses a date/time string in the RFC 3339 format.
Example:
require 'date'
Date.rfc3339('2024-07-09T12:00:00+02:00')
puts date           # Output: 2024-07-09

13) Date._rfc3339 -> Returns the parsed date as a hash from the RFC 3339 string.
Example:
require 'date'
parsed_data = Date._rfc3339('2024-07-09T12:00:00+02:00')
puts parsed_data   # Output: {:year=>2024, :mon=>7, :mday=>9, :hour=>12, :min=>0, :sec=>0, :zone=>"+02:00", :offset=>7200}

14) Date.strptime(string, format = '%F') ->  Returns a new Date object with values parsed from the string in the specified format.
Example:
require 'date'
date = Date.strptime('2024-07-11', '%Y-%m-%d')
puts date          # Output: 2024-07-11

15) Date._strptime(string, format = '%F') -> Returns a hash value of the parsed values from the string in the specified format.
Example:
require 'date'
parsed_data = Date._strptime('2024-07-11', '%Y-%m-%d')
puts parsed_data   # Output: { year: 2024, mon: 7, mday: 11 }

16) Date.xmlschema(string) -> Parses a date/time string in the XML date format.
Example:
require 'date'
date = Date.xmlschema('2024-07-09')
puts date          # Output: 2024-07-09

17) Date._xmlschema(string) -> Returns the parsed date as a hash from the XML date string.
Example:
require 'date'
parsed_data = Date._xmlschema('2024-07-09')
puts parsed_data   # Output: { year: 2024, mon: 7, mday: 9 }

18) Date.commercial(yyyy, mm, dd) -> Returns a new Date object constructed from the arguments according to the Commercial Date format.
Example:
require 'date'
date = Date.commercial(2024, 28, 5)
puts date          # Output: 2024-07-12

19) Date.gregorian_leap?(year) or Date.leap?(year) -> Returns true if the specified year is a leap year.
Example:
require 'date'
leap_year = Date.leap?(2024)
puts leap_year     # Output: true

20) Date.jd(days) -> Creates a Date object based on the Julian Day Number (JD).
Example:
require 'date'
date = Date.jd(2459570)
puts date          # Output: 2021-12-21

21) Date.julian_leap?(year) -> Checks if the specified year is a leap year according to the Julian calendar.
Example:
require 'date'
leap_year = Date.julian_leap?(2024)
puts leap_year      # Output: true

22) Date.ordinal(year, yday) -> Returns a new Date object formed from the arguments (year and day of the year).
Example:
require 'date'
date = Date.ordinal(2024, 365)
puts date          # Output: 2024-12-30

23) Date.today > Returns a new Date object representing todays date.
Example:
require 'date'
today = Date.today
puts today          # Output: 2024-07-10

24) Date.valid_civil?(yyyy, mm, dd) or Date.valid_date?(yyyy, mm, dd) -> Checks if the specified date is valid.
Example:
require 'date'
valid = Date.valid_date?(2024, 7, 5)
puts valid          # Output: true

25) Date.valid_commercial?(cwyear, cweek, cwday) -> Returns true if the specified commercial date is valid.
Example:
require 'date'
valid = Date.valid_commercial?(2024, 28, 5)
puts valid           # Output: true

26) Date.valid_jd?(days) -> Checks if the specified Julian Day Number (JD) is valid.
Example:
require 'date'
valid = Date.valid_jd?(2459570)
puts valid            # Output: true

27) Date.valid_ordinal?(year, yday) -> Checks if the specified ordinal date is valid.
Example:
require 'date'
valid = Date.valid_ordinal?(2024, 191)
puts valid            # Output: true

28) date + days ->  Returns a new Date object that is days days after the current date.
Example:
require 'date'
date = Date.new(2024, 7, 10)
new_date = date + 5
puts new_date        # Output: 2024-07-15

29) date - days ->  Returns a new Date object that is days days before the current date.
Example:
require 'date'
past_date = Date.today - 3
puts past_date        # Output: 2024-07-07

30) date << n ->  Returns a new Date object that is n months before the current date.
Example:
require 'date'
earlier_date = Date.today << 2
puts earlier_date     # Output: 2024-05-10

31) date1 <=> date2 -> Returns -1 if date1 is before date2, 0 if date1 is equal to date2, and 1 if date1 is after date2.
Example:
require 'date'
date1 = Date.new(2024, 7, 9)
date2 = Date.new(2024, 7, 10)
comparison = date1 <=> date2
puts comparison       # Output: -1 

32) date1 === date2 -> Checks if two Date objects represent the same date.
Example:
require 'date'
date1 = Date.new(2024, 7, 9)
date2 = Date.new(2024, 7, 9)
comparison = date1 === date2
puts comparison        # Output: true

33) date >> n ->  Returns a new Date object that is n months after the current date.
Example:
require 'date'
future_date = Date.today >> 2
puts future_date       # Output: 2024-09-10

34) Date.ajd -> Returns the Julian Day Number (JD) for the current Date object.
Example:
require 'date'
ajd = Date.today.ajd
puts ajd               # Output: 4921003/2

35) Date.amjd -> Returns the Astronomical Modified Julian Day Number (AMJD) for the current Date object.
Example:
require 'date'
amjd = Date.today.amjd
puts amjd              # Output: 60501/1

36) Date.asctime or Date.ctime -> Equivalent to strftime('%a %b %e %T %Y'), returns a formatted string representing the date.
Example:
require 'date'
asctime = Date.today.asctime
puts asctime           # Output: "Wed Jul 10 00:00:00 2024"

37) Date.cwday -> Returns the commercial-date weekday index for the current Date object (1 for Monday).
Example:
require 'date'
cwday = Date.today.cwday
puts cwday             # Output: 3

38) Date.cweek -> Returns the commercial date week index for the current Date object (week of the year).
Example:
require 'date'
cweek = Date.today.cweek
puts cweek             # Output: 28

39) Date.cwyear -> Returns the commercial date year for the current Date object.
Example:
require 'date'
cwyear = Date.today.cwyear
puts cwyear            # Output: 2024

40) Date.day or Date.mday ->  Returns the day of the month for the current Date object (1 to 31).
Example:
require 'date'
day = Date.today.day
puts day               # Output:10

41) Date.friday? ->  Returns true if the current Date object represents a Friday
Example:
require 'date'
is_friday = Date.today.friday?
puts is_friday         # Output: false

42) Date.gregorian? -> Determines if the current Date object falls within the Gregorian calendar system.
Example:
require 'date'
is_gregorian = Date.new(2024, 7, 20).gregorian?
puts is_gregorian      # Output: true

43) Date.inspect -> Returns a string representing the Date object for inspection purposes.
Example:
require 'date'
inspected_date = Date.today.inspect
puts inspected_date    # Output: "#<Date: 2024-07-10 ((2460502j,0s,0n),+0s,2299161j)>"

44) Date.jd -> Returns the Julian Day Number (JD) for the current Date object.
Example:
require 'date'
jd_number = Date.new(2024, 7, 10).jd
puts jd_number          # Output: 2460502

45) Date.julian? -> Checks if the current Date object falls within the Julian calendar system.
Example:
require 'date'
is_julian = Date.new(1582, 10, 4).julian?
puts is_julian          # Output: true 

46) Date.ld -> Returns the Lilian Day Number (LD), which is the number of days since the beginning of the Gregorian calendar (October 15, 1582).
Example:
require 'date'
ld_number = Date.new(2024, 7, 9).ld
puts ld_number         # Output: 161342 

47) Date.mjd -> Returns the Modified Julian Day Number (MJD) for the current Date object.
Example:
require 'date'
mjd_number = Date.new(2024, 7, 9).mjd
puts mjd_number        # Output: 60501 

48) Date.mon or Date.month ->  Returns the month of the year for the current Date object (1 to 12).
Example:
require 'date'
month = Date.new(2024, 5, 20).month
puts month             # Output: 5 

49) Date.next or Date.succ -> Returns a new Date object representing the following day.
Example:
require 'date'
tomorrow = Date.today.next
puts tomorrow          # Output: 2024-07-11

50) Date.next_day or Date.next_month or Date.next_year -> Returns a new Date object with the respective increment (day, month, or year).
Example:
require 'date'
next_week = Date.today.next_day(7)
puts next_week         # Output: 2024-07-17

51) Date.prev_day or Date.prev_month or Date.prev_year -> Returns a new Date object with the respective decrement (day, month, or year).
Example:
require 'date'
last_month = Date.today.prev_month
puts last_month        # Output: 2024-06-10

52) Date.step(limit, step = 1) { |date| ... } -> Iterates over dates, starting from self, up to limit, stepping by step.
Example:
require 'date'
Date.new(2024, 7, 1).step(Date.new(2024, 7, 31), 7) do |date|
  puts date
end
# Output: 
2024-07-01
2024-07-08
2024-07-15
2024-07-22
2024-07-29

53) Date.to_date -> Returns a date object that represents the current Date object.
Example:
require 'date'
today = Date.today
date_object = today.to_date
puts date_object         # Output: 2024-07-10

54) Date.to_datetime -> Returns a DateTime object with the same value as the current Date object (time is set to midnight).
Example:
require 'date'
today = Date.today
datetime_object = today.to_datetime
puts datetime_object      # Output: 2024-07-10T00:00:00+00:00

55) Date.to_s -> Returns the Date object as a string in ISO 8601 format (YYYY-MM-DD).
Example:
require 'date'
today = Date.today
date_string = today.to_s
puts date_string          # Output:  "2024-07-10" 

56) Date.to_time ->  Returns a new Time object with the same value as the current Date object (time is set to midnight).
Example:
require 'date'
today = Date.today
time_object = today.to_time
puts time_object         # Output: T2024-07-10 00:00:00 +0530

57) Date.wday -> Returns the day of the week index for the current Date object (0 for Sunday, 1 for Monday, etc.).
Example:
require 'date'
weekday_index = Date.new(2024, 7, 10).wday
puts weekday_index       # Output: 3

58) Date.yday -> Returns the day of the year for the current Date object (1 to 366).
Example:
require 'date'
day_of_year = Date.new(2024, 7, 9).yday
puts day_of_year         # Output: 192

59) Date.year -> Returns the year for the current Date object.
Example:
require 'date'
year = Date.new(2024, 7, 9).year
puts year                # Output: 2024

