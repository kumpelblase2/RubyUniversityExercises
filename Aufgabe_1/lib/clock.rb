$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Defines how many seconds are one minute
MINUTE_IN_SECONDS = 60
# Defines how many minutes are an hour
HOUR_IN_MINUTES = 60
# Define how many hours are one day
DAY_IN_HOURS = 24
# Define how many seconds are one hour
HOUR_IN_SECONDS = HOUR_IN_MINUTES * MINUTE_IN_SECONDS
# Define how many seconds are one day
DAY_IN_SECONDS = DAY_IN_HOURS * HOUR_IN_MINUTES * MINUTE_IN_SECONDS
# Define all allowed hours
ALLOWED_HOURS   = 0...DAY_IN_HOURS
# Define all allowed minutes
ALLOWED_MINUTES = 0...HOUR_IN_MINUTES
# Define all allowed seconds
ALLOWED_SECONDS = 0...MINUTE_IN_SECONDS

# Adds two times with the format of an array with size 3 and [hours, minutes, seconds].
# An operator can be either 1 or -1 representing addition or substraction of the two times.
# Lastly the format has to be either 12 hours or 24 hours
# add_time ::= DayTime x DayTime x Operator x Format -> DayTime ::
# Test ([1, 0, 1], [1, 0, 1]) => [2, 0, 2], ([2, 59, 1], [0, 1, 59]) => [3, 1, 0],
# ([25, 0, 1], [1, 0, 1]) => Err, ("", [1, 0, 1]) => Err
def add_time(in_time1, in_time2, operator = 1, format = DAY_IN_HOURS)
  check_pre(((day_time?(in_time1)) and
              (day_time?(in_time2)) and
              (operator?(operator)) and
              (format?(format))))
  sec_to_array(add_sec(to_day_sec(in_time1), to_day_sec(in_time2), operator), format)
end

def day_time?(in_time)
  if not (in_time.array? and in_time.size == 3) then
    return false
  end

  hour, min, sec = in_time
  ALLOWED_HOURS === hour and ALLOWED_MINUTES === min and ALLOWED_SECONDS === sec
end

def operator?(operator)
  operator == 1 or operator == -1
end

def format?(format)
  format == 12 or format == 24
end

def to_day_sec(in_time)
  hour, min, sec = in_time
  sec + (min * MINUTE_IN_SECONDS) + (hour * HOUR_IN_SECONDS)
end

def add_sec(in_seconds1, in_seconds2, operator)
  added = (in_seconds1 + in_seconds2 * operator) % DAY_IN_SECONDS
  (added < 0 ? DAY_IN_SECONDS - added : added)
end

def sec_to_array(in_seconds, format)
  min, sec   = in_seconds.divmod(MINUTE_IN_SECONDS)
  hours, min_rest = min.divmod(HOUR_IN_MINUTES)
  [hours % format, min_rest, sec]
end