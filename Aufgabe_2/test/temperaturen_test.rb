# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'temperaturen'

class TemperaturenTest < Test::Unit::TestCase
	def test_zu_warm
		assert_equal(zu_warm?(10), false)
		assert_equal(zu_warm?(25), true)
		assert_equal(zu_warm?(22), false)
		assert_raise(RuntimeError) { zu_warm?(1.0) }
	end
	
	def test_zu_kalt
		assert_equal(zu_kalt?(10), true)
		assert_equal(zu_kalt?(16), false)
		assert_equal(zu_kalt?(26), false)
		assert_raise(RuntimeError) { zu_kalt?(1.0) }
	end
	
	def test_angenehm
		assert_equal(angenehm?(10), false)
		assert_equal(angenehm?(16), true)
		assert_equal(angenehm?(22), true)
		assert_equal(angenehm?(23), false)
		assert_raise(RuntimeError) { angenehm?(1.0) }
	end
	
	def test_unangenehm
		assert_equal(unangenehm?(10), true)
		assert_equal(unangenehm?(23), true)
		assert_equal(unangenehm?(17), false)
		assert_equal(unangenehm?(22), false)
	end
end