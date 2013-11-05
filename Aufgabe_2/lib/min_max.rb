$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Returns the smaller number of the two
# min_int ::= Int x Int -> Int ::
# Test (1, 2) => 1, (3, 2) => 2, (-1, 2) => -1,
# (1.0, 1) => Err, ('1', 2) => Err
def min_int(in_first, in_second)
	check_pre(((in_first.int?) and (in_second.int?)))
	(in_first > in_second ? in_second : in_first)
end

# Returns the bigger number of the two
# max_int ::= Int x Int -> Int ::
# Test (1, 2) => 2, (3, 2) => 3, (-1, 2) => 2,
# (1.0, 1) => Err, ('1', 2) => Err
def max_int(in_first, in_second)
	check_pre(((in_first.int?) and (in_second.int?)))
	(in_first > in_second ? in_first : in_second)
end

# check if the number is between the provided lower end and upper end
# within? ::= Int x Int x Int -> Bool ::
# Test (1, 0, 3) => true, (3, 2, 4) => true, (-1, 0, 1) => false,
# (1.0, 1, 2) => Err, ('1', 0, 2) => Err
def within?(in_val, in_lower, in_upper)
	check_pre(((in_val.int?) and (in_lower.int?) and (in_upper.int?) and (in_lower < in_upper)))
	Range.new(in_lower, in_upper) === in_val
end