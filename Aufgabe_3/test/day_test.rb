# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'day'

class DayTest < Test::Unit::TestCase
	def test_day_num
		assert_equal(day_num?(1), true)
		assert_equal(day_num?(2), true)
		assert_equal(day_num?(7), true)
		assert_equal(day_num?(0), false)
		assert_equal(day_num?(8), false)
		assert_equal(day_num?(Daynum[1]), true)
		assert_equal(day_num?(Daynum[3]), true)
		assert_equal(day_num?(Daynum[7]), true)
		assert_raise(RuntimeError) { day_num?(Daynum[8]) }
		assert_raise(RuntimeError) { day_num?(Daynum[-1]) }
	end
	
	def test_day_sym
		assert_equal(day_sym?(:Mo), true)
		assert_equal(day_sym?(:Di), true)
		assert_equal(day_sym?(:So), true)
		assert_equal(day_sym?(:Th), false)
		assert_equal(day_sym?(:A), false)
		assert_equal(day_sym?(Daysym[:Mo]), true)
		assert_equal(day_sym?(Daysym[:So]), true)
		assert_equal(day_sym?(Daysym[:Mi]), true)
		assert_raise(RuntimeError) { day_sym?(Daysym[:MÖ]) }
		assert_raise(RuntimeError) { day_sym?(Daysym[:SI]) }
	end
	
	def test_day
		assert_equal(day?(1), true)
		assert_equal(day?(2), true)
		assert_equal(day?(7), true)
		assert_equal(day?(0), false)
		assert_equal(day?(8), false)
		assert_equal(day?(:Mo), true)
		assert_equal(day?(:Di), true)
		assert_equal(day?(:So), true)
		assert_equal(day?(:Th), false)
		assert_equal(day?(:A), false)
		assert_equal(day?(Daynum[1]), true)
		assert_equal(day?(Daynum[3]), true)
		assert_equal(day?(Daynum[7]), true)
		assert_equal(day?(Daysym[:Mo]), true)
		assert_equal(day?(Daysym[:So]), true)
		assert_equal(day?(Daysym[:Mi]), true)
	end
	
	def test_day_succ
		assert_equal(day_succ(1), 2)
		assert_equal(day_succ(2), 3)
		assert_equal(day_succ(6), 7)
		assert_equal(day_succ(7), 1)
		assert_equal(day_succ(:Mo), :Di)
		assert_equal(day_succ(:Fr), :Sa)
		assert_equal(day_succ(:So), :Mo)
		assert_equal(day_succ(Daysym[:Mo]), Daysym[:Di])
		assert_equal(day_succ(Daysym[:So]), Daysym[:Mo])
		assert_equal(day_succ(Daysym[:Mi]), Daysym[:Do])
		assert_equal(day_succ(Daynum[1]), Daynum[2])
		assert_equal(day_succ(Daynum[3]), Daynum[4])
		assert_equal(day_succ(Daynum[7]), Daynum[1])
	end
	
	def test_day_pred
		assert_equal(day_pred(1), 7)
		assert_equal(day_pred(2), 1)
		assert_equal(day_pred(6), 5)
		assert_equal(day_pred(7), 6)
		assert_equal(day_pred(:Mo), :So)
		assert_equal(day_pred(:Fr), :Do)
		assert_equal(day_pred(:So), :Sa)
		assert_equal(day_pred(Daysym[:Mo]), Daysym[:So])
		assert_equal(day_pred(Daysym[:So]), Daysym[:Sa])
		assert_equal(day_pred(Daysym[:Mi]), Daysym[:Di])
		assert_equal(day_pred(Daynum[1]), Daynum[7])
		assert_equal(day_pred(Daynum[3]), Daynum[2])
		assert_equal(day_pred(Daynum[7]), Daynum[6])
	end

	def test_day_succ_fail
		assert_raise(RuntimeError) { day_succ(8) }
		assert_raise(RuntimeError) { day_succ(0) }
		assert_raise(RuntimeError) { day_succ(:Ma) }
		assert_raise(RuntimeError) { day_succ(:Si) }
	end

	def test_day_pred_fail
		assert_raise(RuntimeError) { day_pred(8) }
		assert_raise(RuntimeError) { day_pred(0) }
		assert_raise(RuntimeError) { day_pred(:Ma) }
		assert_raise(RuntimeError) { day_pred(:Si) }
	end

	def test_day_conversion
		assert_equal(to_day(:Mo, Daysym[:Di]), :Di)
		assert_equal(to_day(:Di, Daysym[:Di]), :Di)
		assert_equal(to_day(:Mo, :Mo), :Mo)
		assert_equal(to_day(:Mo, 2), :Di)
		assert_equal(to_day(:Mo, Daynum[3]), :Mi)
		assert_equal(to_day(1, Daysym[:Di]), 2)
		assert_equal(to_day(1, Daysym[:Fr]), 5)
		assert_equal(to_day(1, 2), 2)
		assert_equal(to_day(1, :Fr), 5)
		assert_equal(to_day(1, Daynum[3]), 3)
		assert_equal(to_day(Daysym[:Mo], :Mo), Daysym[:Mo])
		assert_equal(to_day(Daysym[:Mo], :Fr), Daysym[:Fr])
		assert_equal(to_day(Daysym[:Mo], 1), Daysym[:Mo])
		assert_equal(to_day(Daysym[:Mo], 7), Daysym[:So])
		assert_equal(to_day(Daysym[:Mo], Daynum[2]), Daysym[:Di])
		assert_equal(to_day(Daysym[:Mo], Daysym[:Di]), Daysym[:Di])
		assert_equal(to_day(Daynum[1], :Di), Daynum[2])
		assert_equal(to_day(Daynum[1], :So), Daynum[7])
		assert_equal(to_day(Daynum[1], 3), Daynum[3])
		assert_equal(to_day(Daynum[1], Daysym[:Mo]), Daynum[1])
		assert_equal(to_day(Daynum[1], Daynum[2]), Daynum[2])
	end

	def test_day_shift
		assert_equal(day_shift(:Mo, 7), :Mo)
		assert_equal(day_shift(:So, 1), :Mo)
		assert_equal(day_shift(Daysym[:Mo], 1), Daysym[:Di])
		assert_equal(day_shift(Daynum[2], 1), Daynum[3])

		assert_equal(day_shift(:Mo, -7), :Mo)
		assert_equal(day_shift(:Mo, -1), :So)
		assert_equal(day_shift(Daysym[:Mi], -1), Daysym[:Di])
		assert_equal(day_shift(Daynum[2], -1), Daynum[1])
	end
end
