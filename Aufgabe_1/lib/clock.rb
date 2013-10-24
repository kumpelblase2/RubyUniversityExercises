$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

$MINUTE_IN_SECONDS = 60
$HOUR_IN_MINUTES = 60

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

def print_time(in_time, twelve_hour = false)
	if not in_time.is_a?(Array) then
		in_time = secs_to_array(in_time)
	end
	
	puts (twelve_hour ? in_time[0] % 12 : in_time[0]) + ":" + in_time[1] + ":" + in_time[2]
end

def array_to_sec(in_time_array)
	check_pre(((in_time_array.is_a?(Array)) and (in_time_array.size == 3) and (in_time_array.all? {|i| i.nat?})))
	sec = in_time_array[2]
	sec += in_time_array[1] * $MINUTE_IN_SECONDS
	sec += (in_time_array[0] * $HOUR_IN_MINUTES) * $MINUTE_IN_SECONDS
	return sec
end

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