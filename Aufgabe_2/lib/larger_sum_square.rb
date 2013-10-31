$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"
require "min_max"

def larger_sum_square(in_val1, in_val2, in_val3)
	check_pre(((in_val1.int?) and (in_val2.int?) and (in_val3.int?)))
	first, second = get_largest_two(in_val1, in_val2, in_val3)
	square_sum(first, second)
end

def get_largest_two(in_val1, in_val2, in_val3)
	check_pre(((in_val1.int?) and (in_val2.int?) and (in_val3.int?)))
	first = max_int(in_val1, in_val2)
	second = max_int(in_val2, in_val3)
	third = max_int(in_val3, in_val1)
	(first == second ? [first, third] : [first,second])
end

def square_sum(in_val1, in_val2)
	check_pre(((in_val1.int?) and (in_val2.int?)))
	square(in_val1) + square(in_val2)
end

def square(in_value)
	check_pre((in_value.int?))
	in_value ** 2
end