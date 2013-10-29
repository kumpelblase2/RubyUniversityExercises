# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'min_max'

class MinMaxTest < Test::Unit::TestCase
	def test_min_int
		assert_equal(min_int(1, 2), 1)
		assert_equal(min_int(-5, 2), -5)
		assert_equal(min_int(5, 2), 2)
		assert_equal(min_int(12, 12), 12)
		assert_equal(min_int(0, 1), 0)
		assert_raise(RuntimeError) { min_int(1.0, 1.0) }
		assert_raise(RuntimeError) { min_int('1', 1) }
	end
	
	def test_max_int
		assert_equal(max_int(1, 2), 2)
		assert_equal(max_int(-5, 2), 2)
		assert_equal(max_int(5, 2), 5)
		assert_equal(max_int(12, 12), 12)
		assert_equal(max_int(0, 1), 1)
		assert_raise(RuntimeError) { max_int(1.0, 1.0) }
		assert_raise(RuntimeError) { max_int('1', 1) }
	end
	
	def test_within
		assert_equal(within?(1, 0, 2), true)
		assert_equal(within?(2, -1, 2), true)
		assert_equal(within?(1, 2, 4), false)
		assert_raise(RuntimeError) { within?(1.0, 0, 2) }
	end
end
