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
	end
	
	def test_day_sym
		assert_equal(day_sym?(:Mo), true)
		assert_equal(day_sym?(:Di), true)
		assert_equal(day_sym?(:So), true)
		assert_equal(day_sym?(:Th), false)
		assert_equal(day_sym?(:A), false)
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
	end
	
	def test_day_succ
		assert_equal(day_succ(1), 2)
		assert_equal(day_succ(2), 3)
		assert_equal(day_succ(6), 7)
		assert_equal(day_succ(7), 1)
		assert_equal(day_succ(:Mo), :Di)
		assert_equal(day_succ(:Fr), :Sa)
		assert_equal(day_succ(:So), :Mo)
	end
	
	def test_day_pred
		assert_equal(day_pred(1), 7)
		assert_equal(day_pred(2), 1)
		assert_equal(day_pred(6), 5)
		assert_equal(day_pred(7), 6)
		assert_equal(day_pred(:Mo), :So)
		assert_equal(day_pred(:Fr), :Do)
		assert_equal(day_pred(:So), :Sa)
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
end
