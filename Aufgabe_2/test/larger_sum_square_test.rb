# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'larger_sum_square'

class LargerSumSquareTest < Test::Unit::TestCase
	def test_square_sum
		assert_equal(square_sum(1, 1), 2)
		assert_equal(square_sum(2, 1), 5)
		assert_equal(square_sum(-1, 2), 5)
		assert_raise(RuntimeError) { square_sum('1', 1) }
		assert_raise(RuntimeError) { square_sum(1.0, 1) }
	end
	
	def test_get_largest_tow
		assert_equal(get_largest_two(1, 2, 3), [2, 3])
		assert_equal(get_largest_two(1, 2, 90), [2, 90])
		assert_equal(get_largest_two(3, 2, 3), [3, 3])
		assert_equal(get_largest_two(-5, -1, 3), [-1, 3])
		assert_equal(get_largest_two(-1, -1, -1), [-1, -1])
		assert_equal(get_largest_two(-1, 2, -1), [2, -1])
		assert_raise(RuntimeError) { get_largest_two('1', 1, 1) }
		assert_raise(RuntimeError) { get_largest_two(1.0, 1, 1) }
	end
	
	def test_larger_sum_square
		assert_equal(larger_sum_square(1, 2, 3), square_sum(2, 3))
		assert_equal(larger_sum_square(3, 2, 1), square_sum(2, 3))
		assert_equal(larger_sum_square(3, 2, 3), square_sum(3, 3))
		assert_equal(larger_sum_square(-1, 2, -3), square_sum(-1, 2))
		assert_equal(larger_sum_square(-1, -2, -3), square_sum(-2, -1))
	end
end
