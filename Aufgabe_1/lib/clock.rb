$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Defines how many seconds are one minute
MINUTE_IN_SECONDS = 60
# Defines how many minutes are an hour
HOUR_IN_MINUTES = 60

# add_time : Adds a specific amount of time to the current or given time and
#			 returns the resulting time in seconds or as an array.
# in_to_add : Integer -> The time to add
# in_current_time : Integer|Array -> The time to add to. If nil, the current time will be used.
#									 It can also be an array with size 3 and with the format [hours, minutes, seconds].
# as_array : Boolean -> Whether the resulting time should be printed out as an array or as seconds.
# Return: Result in seconds or as an array.
def add_time(in_to_add, in_current_time = 0, as_array = false)
	if in_current_time == nil then
		in_current_time = Time.new().to_i
	elsif in_current_time.is_a?(Array) then
		in_current_time = array_to_sec(in_current_time)
	end
	
	check_pre((in_current_time.nat?))
	if in_to_add.is_a?(Array) then
		in_to_add = array_to_sec(in_to_add)
	end
	
	check_pre(((in_to_add.is_a?(Fixnum))))
	if in_to_add < 0 then
		check_pre((in_to_add.abs <= in_current_time))
	end
	
	if as_array then
		secs_to_array(in_current_time + in_to_add)
	else
		in_current_time + in_to_add
	end
end

# print_time : Prints the time out in an array format.
# in_time : Integer|Array -> The time to print out. If an array is provided, it has to be in the format [hours, minutes, seconds]
# twelve_hout : Boolean -> Whether the output format should be in twelve hour format or not.
# Return: nothing
def print_time(in_time, twelve_hour = false)
	if not in_time.is_a?(Array) then
		in_time = secs_to_array(in_time)
	end
	
	puts (twelve_hour ? in_time[0] % 12 : in_time[0]) + ":" + in_time[1] + ":" + in_time[2]
end

# array_to_sec : Converts an array into its respective presentation as seconds
#				 It has to be in the format [hours, minutes, seconds]
# in_time_array : Array -> Array of time
# Return: Integer
def array_to_sec(in_time_array)
	check_pre(((in_time_array.is_a?(Array)) and (in_time_array.size == 3) and (in_time_array.all? {|i| i.nat?})))
	sec = in_time_array[2]
	sec += in_time_array[1] * MINUTE_IN_SECONDS
	sec += (in_time_array[0] * HOUR_IN_MINUTES) * MINUTE_IN_SECONDS
	return sec
end

# secs_to_array : Converts a time in seconds into an array in the format [hours, minutes, seconds]
# in_time_sec : Integer -> The time in seconds
# Return: Array
def secs_to_array(in_time_sec)
	check_pre((in_time_sec.nat?))
	time_array = Array.new(3)
	time_array[2] = in_time_sec % 60
	remaining = in_time_sec / 60
	time_array[1] = remaining % 60
	remaining = remaining / 60
	time_array[0] = remaining % 24
	return time_array
end