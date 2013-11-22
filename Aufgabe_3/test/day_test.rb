# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'day'

class DayTest < Test::Unit::TestCase	
	def test_day
		assert_equal(day?(DayNum[1]), true)
		assert_equal(day?(DayNum[3]), true)
		assert_equal(day?(DayNum[7]), true)
		assert_equal(day?(DaySym[:Mo]), true)
		assert_equal(day?(DaySym[:So]), true)
		assert_equal(day?(DaySym[:Mi]), true)
	end
	
	def test_day_succ
		assert_equal(day_succ(DaySym[:Mo]), DaySym[:Di])
		assert_equal(day_succ(DaySym[:So]), DaySym[:Mo])
		assert_equal(day_succ(DaySym[:Mi]), DaySym[:Do])
		assert_equal(day_succ(DayNum[1]), DayNum[2])
		assert_equal(day_succ(DayNum[3]), DayNum[4])
		assert_equal(day_succ(DayNum[7]), DayNum[1])
	end
	
	def test_day_pred
		assert_equal(day_pred(DaySym[:Mo]), DaySym[:So])
		assert_equal(day_pred(DaySym[:So]), DaySym[:Sa])
		assert_equal(day_pred(DaySym[:Mi]), DaySym[:Di])
		assert_equal(day_pred(DayNum[1]), DayNum[7])
		assert_equal(day_pred(DayNum[3]), DayNum[2])
		assert_equal(day_pred(DayNum[7]), DayNum[6])
	end

	def test_day_conversion
		assert_equal(to_day(DaySym[:Mo], DayNum[2]), DaySym[:Di])
		assert_equal(to_day(DaySym[:Mo], DaySym[:Di]), DaySym[:Di])
		assert_equal(to_day(DayNum[1], DaySym[:Mo]), DayNum[1])
		assert_equal(to_day(DayNum[1], DayNum[2]), DayNum[2])
	end

	def test_day_shift
		assert_equal(day_shift(DaySym[:Mo], 1), DaySym[:Di])
		assert_equal(day_shift(DayNum[2], 1), DayNum[3])
		assert_equal(day_shift(DaySym[:Mi], -1), DaySym[:Di])
		assert_equal(day_shift(DayNum[2], -1), DayNum[1])
	end
end
