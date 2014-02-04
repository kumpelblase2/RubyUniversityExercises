# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'first_index_for'

class FirstIndexForTest < Test::Unit::TestCase
	def first_index_for_test
		assert_equal(1, (5..10).first_index_for { |i| i / 2 == 0 })
		assert_equal(9, (1..50).first_index_for { |i| i * 2 >= 20})
		assert_equal(3, List[1, 2, 3, 4].first_index_for { |i| i ** 2 > 10 })
		assert_equal(nil, List[1, 3, 4].first_index_for { |i| i == 2 })
		assert_raise(RuntimeException) { '1'.first_index_for { |i| i == 1} }
		assert_raise(RuntimeException) { List[1, 2].first_index_for }
	end
end
