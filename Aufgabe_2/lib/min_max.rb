$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

def min_int(in_first, in_second)
	check_pre(((in_first.int?) and (in_second.int?)))
	(in_first > in_second ? in_second : in_first)
end

def max_int(in_first, in_second)
	check_pre(((in_first.int?) and (in_second.int?)))
	(in_first > in_second ? in_first : in_second)
end

def within?(in_val, in_lower, in_upper)
	check_pre(((in_val.int?) and (in_lower.int?) and (in_upper.int?) and (in_lower < in_upper)))
	Range.new(in_lower, in_upper) === in_val
end