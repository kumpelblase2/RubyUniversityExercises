# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'weekday'

class WeekdayTest < Test::Unit::TestCase	
	def test_sym
		assert_raise(RuntimeError) { DaySym[1] }
		assert_raise(RuntimeError) { DaySym[:Si] }
		assert_raise(RuntimeError) { DaySym["1"] }
		
		assert_equal(true, DaySym[:Mo] == DaySym[:Mo])
		assert_equal(false, DaySym[:Mo] == DaySym[:Di])
		assert_equal(DaySym[:Di], DaySym[:Mo].succ)
		assert_equal(DaySym[:Mo], DaySym[:Di].pred)
		assert_equal(DayNum[1], DaySym[:Mo].to_day_num)
	end
	
	def test_num
		assert_raise(RuntimeError) { DayNum[9] }
		assert_raise(RuntimeError) { DayNum['1'] }
		assert_raise(RuntimeError) { DayNum[:Di] }
		
		assert_equal(true, DayNum[1] == DayNum[1])
		assert_equal(false, DayNum[1] == DayNum[2])
		assert_equal(DayNum[2], DayNum[1].succ)
		assert_equal(DayNum[1], DayNum[2].pred)
		assert_equal(DaySym[:Mo], DayNum[1].to_day_sym)
	end
end
