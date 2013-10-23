# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'clock'

class ClockTest < Test::Unit::TestCase
	def test_array_to_secs
		assert_equal(array_to_sec([0, 0, 0]), 0)
		assert_equal(array_to_sec([0, 2, 0]), 120)
		assert_equal(array_to_sec([1, 0, 0]), 3600)
		assert_equal(array_to_sec([23, 59, 59]), 86399)
		assert_raise(RuntimeError) {array_to_sec([0, 0])}
		assert_raise(RuntimeError) {array_to_sec(1)}
		assert_raise(RuntimeError) {array_to_sec(-1)}
		assert_not_equal(array_to_sec([0, 0, 1]), 0)
	end
	
	def test_secs_to_array
		assert_equal(secs_to_array(0), [0, 0, 0])
		assert_equal(secs_to_array(120), [0, 2, 0])
		assert_equal(secs_to_array(86399), [23, 59, 59])
		assert_raise(RuntimeError) {secs_to_array(-1)}
		assert_raise(RuntimeError) {secs_to_array([1])}
		assert_not_equal(secs_to_array(120), [0, 0, 120])
	end
	
	def test_add_time
		assert_equal(add_time(120), 120)
		assert_equal(add_time(120, 120), 240)
		assert_equal(add_time(0, nil), Time.new().to_i)
		assert_equal(add_time(0, 120), 120)
		assert_raise(RuntimeError) {add_time(-120)}
		assert_raise(RuntimeError) {add_time(0, 'a')}
	end
end
