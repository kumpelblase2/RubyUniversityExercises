$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"
require "min_max"

# Calculates the sum of the biggest two square numbers
# larger_sum_square ::= Int x Int x Int -> Nat ::
# Test (1, 2, 3) => 13, (3, 2, 1) => 13, (3, 2, 3) => 18,
# (-1, 2, -3) => 5, (-1, -2, -3) => 5,
# (1.0, 1, 2) => Err, ('1', 2, 3) => Err
def larger_sum_square(in_val1, in_val2, in_val3)
	check_pre(((in_val1.int?) and (in_val2.int?) and (in_val3.int?)))
	square_sum(get_largest_two(in_val1, in_val2, in_val3))
end

# Gets the largets two numbers from the given three.
# The result is not ordered.
# get_largest_two ::= Int x Int x Int -> Int ::
# Test (1, 2, 3) => [2, 3], (2, 2, 3) => [2, 3],
# (-1, 0, 1) => [0, 1], (-4, -2, 1) => [-2, 1],
# ('1', 1, 2) => Err, (0.0, 1.0, 2.0) => Err
def get_largest_two(in_val1, in_val2, in_val3)
	check_pre(((in_val1.int?) and (in_val2.int?) and (in_val3.int?)))
	if(in_val1 >= in_val3 and in_val2 >= in_val3) then [in_val1, in_val2]
  elsif(in_val1 >= in_val2 and in_val3 >= in_val2) then [in_val1, in_val3]
  elsif(in_val3 >= in_val1 and in_val2 >= in_val1) then [in_val2, in_val3]
  else check_pre(false)
  end
end

# Calcualtes the sum of the square of each number.
# square_sum ::= IntArr -> Nat ::
# Test (1, 1) => 2, (2, 2) => 8, (1, 2) => 5, (3, 4) => 25
# (1.0, 2) => Err, ('1', 2) => Err
def square_sum(in_biggest_array)
  first, second = in_biggest_array
	check_pre(((first.int?) and (second.int?)))
	square(first) + square(second)
end

def square(in_value)
	check_pre((in_value.int?))
	in_value ** 2
end