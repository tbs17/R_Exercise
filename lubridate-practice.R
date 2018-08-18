library(lubridate)
dt=as_datetime(1511870400)
dt #[1] "2017-11-28 12:00:00 UTC"
as_date(17498) #[1] "2017-11-28"
hms::as.hms(85) #00:01:25

# ---convert strings or numbers to date-times

# the below will transform the iso8601 datetime format to the universal format which is yyyy-mm-dd hh:mm:ss
ymd_hms('2017-11-28T14:02:00')
# [1] "2017-11-28 14:02:00 UTC"

ydm_hms('2017-22-12 10:00:00')
# [1] "2017-12-22 10:00:00 UTC"
mdy_hms('11/28/2017 1:02:03')
# [1] "2017-11-28 01:02:03 UTC"
dmy_hms('1 Jan 2017 23:59:59')
# [1] "2017-01-01 23:59:59 UTC"

ymd(20170131)
# [1] "2017-01-31"
mdy('July 4th,2000')
# [1] "2000-07-04"

dmy("4th of July '99")
# [1] "1999-07-04"

yq('2001:Q3')
# [1] "2001-07-01"
hms::hms(seconds =0,minutes = 1,hours = 2)
# 02:01:00

date_decimal(2017.5) #convert decimal year to year-month-day
# [1] "2017-07-02 12:00:00 UTC"
now()
# [1] "2018-08-14 22:53:41 EDT"
today()
# [1] "2018-08-14"
fast_strptime('9/1/01','%y/%m/%d')
# [1] "2009-01-01 UTC"

# parse_date_time allows you to specify an order to parse the date time object
parse_date_time('9/1/01','y/m/d')

x <- c("09-01-01", "09-01-02", "09-01-03")
parse_date_time(x, "ymd")
parse_date_time(x, "y m d")
parse_date_time(x, "%y%m%d")
# [1] "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"


# --get and set components---
# use an accessor function to get a component
d='2017-11-28'
day(d) #28

dt='2018-01-31 11:59:59'
dt1='2018-03-31 11:59:59'
date(dt) #[1] "2018-01-31"
year(dt) #2018
isoyear(dt) #to get the ISO 8601 year:2018
epiyear(dt)#2018: to get the epidemiological year

month(dt)#1
day(dt) #31
wday(dt) #4
qday(dt1) #90: day of quarter
hour(dt) #11
minute(dt)
second(dt)
week(dt) #5
isoweek(dt)
epiweek(dt)
quarter(dt,with_year = FALSE) #1
semester(dt) #1
am(dt)
pm(dt) #FALSE
dst(dt) #is it daylight savings? FALSE
leap_year(year(dt)) #FALSE

# for the update to work, you will have to make sure dt is a date/time format
dt=ymd_hms(dt)
update(dt,year=2010,month=2,day=1)

# [1] "2010-02-01 12:01:59 UTC"

#  ---Round Date-times----------
# round down to nearest unit

floor_date(dt,unit = 'month') #round down to nearest unit
# [1] "2018-01-01 UTC"

round_date(dt,unit = 'month') #round up
# [1] "2018-02-01 UTC"

ceiling_date(dt,unit = 'month') #round up
# [1] "2018-02-01 UTC"
rollback(dt)#roll back to the last day of previous month
# [1] "2017-12-31 11:59:59 UTC"

# =====Stamp Date-times===
# stamp() derive a template from an example string and return a new function that will apply the template to date-times

sf=stamp('Created Sunday, Jan 17, 1999 3:34') #you gotta make sure they are the correct date time format though. if it's 199999, the template won't generate
#  apply the template to any dates and it will turn into the same format
sf(ymd('2010-04-05')) 
# # [1] "Created Monday, Apr 05, 2010 00:00"
# ===R recognizes ~600 times zones and use UTC to avoid Daylight Savings===
# OlsonNames() returns a list of valid time zone name
# find the time in a different time zone
with_tz(dt,'US/Pacific')
# [1] "2018-01-31 03:59:59 PST"
force_tz(dt,'US/Pacific') #force to get the same clock time with the changed timezone
# [1] "2018-01-31 11:59:59 PST"


# =====math with date-times=====

# maths with date-times relies on the timeline, which behaves inconsistently.

# --- Timeline affected by daylights  savings time and leap year---
nor=ymd_hms('2018-01-01 01:30:00',tz='US/Eastern')
nor #[1] "2018-01-01 01:30:00 EST"

# ::daylight savings time starts: spring forward::

gap=ymd_hms('2018-03-11 01:30:00',tz='US/Eastern')
gap #[1] "2018-03-11 01:30:00 EST"

# :::daylight savings time ends (fall back)
lap=ymd_hms('2018-11-04 00:30:00',tz='US/Eastern')
lap #[1] "2018-11-04 00:30:00 EST"

# :::leap year and leap seconds
leap=ymd('2019-03-01')
leap #[1] "2019-03-01"

# ----periods: tracks changes in clock times, ignoring time line irregulariteis-----

nor+minutes(90) #[1] "2018-01-01 03:00:00 EST"
gap+minutes(90) #[1] "2018-03-11 03:00:00 EDT" , EDT is Eastern Daylight Savings Time
lap+minutes(90) #[1] "2018-11-04 02:00:00 EST"
leap+years(1) #[1] "2020-03-01"

# ----duration: tracks the passage of physical time, factoring in the irregularities------

# using dminutes() which is duration function to factor in the irregularities and tracks the physical time passage
nor+dminutes(90) #[1] "2018-01-01 03:00:00 EST"
gap+dminutes(90) #[1] "2018-03-11 04:00:00 EDT"
lap+dminutes(90) #[1] "2018-11-04 01:00:00 EST" 
leap+dyears(1) #[1] "2020-02-29"

# ----interval:also reflect time irregularities,but show as bounded by start and end date-times-----
interval(nor,nor+minutes(90)) #[1] 2018-01-01 01:30:00 EST--2018-01-01 03:00:00 EST
interval(gap,gap+minutes(90)) #[1] 2018-03-11 01:30:00 EST--2018-03-11 03:00:00 EDT
interval(lap,lap+minutes(90)) #[1] 2018-11-04 00:30:00 EDT--2018-11-04 02:00:00 EST
interval(leap,leap+years(1)) #[1] 2019-03-01 UTC--2020-03-01 UTC

i1=interval(nor,nor+dminutes(90)) #[1] 2018-01-01 01:30:00 EST--2018-01-01 03:00:00 EST
i2=interval(gap,gap+dminutes(90)) #[1] 2018-03-11 01:30:00 EST--2018-03-11 04:00:00 EDT
i3=interval(lap,lap+dminutes(90)) #[1] 2018-11-04 00:30:00 EDT--2018-11-04 01:00:00 EST
i4=interval(leap,leap+dyears(1)) #[1] 2019-03-01 UTC--2020-02-29 UTC

# :::not all years are 365 days due to leap years and not all minutes are 60 seconds due to leap seconds::::
jan31=ymd(20180131)#[1] "2018-01-31"

jan31
jan31+months(1) #[1] NA

# due to the leap year and seconds, we need to create imaginary date by using %m+% and %m-% to roll imaginary dates to the last day of the prvious month
jan31%m+%months(1) #[1] "2018-02-28" this is only applied when you plus a month to feburary
jan31-months(1) #works same as jan31%m-%months(1)
add_with_rollback(jan31,months(1),roll_to_first = TRUE) #will roll imaginary dates to the first day of the new month
# [1] "2018-03-01"


# ::::period is represented by the pluralized form of a time unit::::
p=months(3)+days(12)
p #[1] "3m 12d 0H 0M 0S"
years(1)
months(1)
weeks(1)
days(1)
hours(1)
minutes(1)
seconds(1)
milliseconds(1) #[1] "0.001S"
nanoseconds(1) #[1] "1e-09S"
picoseconds(1) #[1] "1e-12S"

period(5,unit='years') #[1] "5y 0m 0d 0H 0M 0S"

i1=interval(nor,nor+dminutes(90)) #[1] 2018-01-01 01:30:00 EST--2018-01-01 03:00:00 EST
i2=interval(gap,gap+dminutes(90)) #[1] 2018-03-11 01:30:00 EST--2018-03-11 04:00:00 EDT
i3=interval(lap,lap+dminutes(90)) #[1] 2018-11-04 00:30:00 EDT--2018-11-04 01:00:00 EST
i4=interval(leap,leap+dyears(1)) #[1] 2019-03-01 UTC--2020-02-29 UTC
as.period(i1) #[1] "1H 30M 0S"
as.period(i2) #[1] "2H 30M 0S"
as.period(i3) #[1] "30M 0S"
is.period(i4) #[1] FALSE

dur1=nor+dminutes(90) #[1] "2018-01-01 03:00:00 EST"
dur2=gap+dminutes(90) #[1] "2018-03-11 04:00:00 EDT"
dur3=lap+dminutes(90) #[1] "2018-11-04 01:00:00 EST" 
dur4=leap+dyears(1) #[1] "2020-02-29"

as.period(dur1) #error message, can't convert duration to period


# :::durations are stored as seconds and difftime is a class of durations found in base R::::

dd=ddays(14)
dd #[1] "1209600s (~2 weeks)"

dyears(1) #[1] "31536000s (~52.14 weeks)"
dmonths(1) #no dmonths
dweeks(1) #[1] "604800s (~1 weeks)"
ddays(1) #[1] "86400s (~1 days)"
dhours(1) #[1] "3600s (~1 hours)"
dminutes(1)
dseconds(1)#[1] "1s"
dmilliseconds(1) #[1] "0.001S"
dnanoseconds(1) #[1] "1e-09S"
dpicoseconds(1) #[1] "1e-12S"
duration(5,unit='years') #[1] "157680000s (~5 years)"
as.duration(i1) #[1] "157680000s (~5 years)"
is.duration(i1) #[1] FALSE
is.difftime(i1) #[1] FALSE
make_difftime(99999) #Time difference of 1.157396 days

# ::::intervals: divid an inverval by a duration to dertermine its physical length:::::
# ::::intervals:divide an inverval by a period to determine its implied length in clock time::::

d=as_date(17498)
d #[1] "2017-11-28"
i=interval(ymd('2017-01-01'),d) #[1] 2017-01-01 UTC--2017-11-28 UTC
j=d%--%ymd('2017-12-31') #[1] 2017-11-28 UTC--2017-12-31 UTC

now() %within% i #[1] FALSE

int_start(i)=now()
i #[1] 2018-08-15 14:25:51 UTC--2017-11-28 UTC
int_end(i)=now()
i #[1] 2018-08-15 14:25:51 UTC--2018-08-15 14:26:19 UTC
int_aligns(i,j) #do two intervals share a boundary? : FALSE


# int_diff(): make the intervals that occur between the date-times in a vector
dt=as_datetime(1511870400)
dt #[1] "2017-11-28 12:00:00 UTC"
v=c(dt,dt+100,dt+1000) #the added 100 is 100 seconds
int_diff(v) #[1] 2018-01-31 11:59:59 UTC--2018-01-31 12:01:39 UTC 2018-01-31 12:01:39 UTC--2018-01-31 12:16:39 UTC

int_flip(i) #reverse the direction of an interval:[1] 2018-08-15 14:26:19 UTC--2018-08-15 14:25:51 UTC
int_standardize(i) #standardize normalize the interval where end date is always later :[1] 2018-08-15 14:25:51 UTC--2018-08-15 14:26:19 UTC
int_length(i) #the interval length in seconds:[1] 28.28862

int_shift(i,days(-1)) #shift the interval up or down by a timespan:[1] 2018-08-14 10:25:51 EDT--2018-08-14 10:26:19 EDT
as.interval(days(1),start = now()) #make an interval starting with now time and go forward 1 day
# [1] 2018-08-15 10:33:39 EDT--2018-08-16 10:33:39 EDT