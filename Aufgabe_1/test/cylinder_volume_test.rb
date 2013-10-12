# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'cylinder_volume'

class CylinderVolumeTest < Test::Unit::TestCase
	def test_cylinder_volume
		assert_in_delta(6.2831853, cylinder_volume(1, 1), 0.001)
		assert_in_delta(157.079632, cylinder_volume(5, 5), 0.001)
	  assert_raise(RuntimeError) { |i| cylinder_volume('1', '2') }
	end
	
	def test_ground_surface
		assert_in_delta(6.2831853, ground_surface(1), 0.001)
		assert_in_delta(31.415926, ground_surface(5), 0.001)
    assert_raise(RuntimeError) { |i| ground_surface('1') }
	end
end
