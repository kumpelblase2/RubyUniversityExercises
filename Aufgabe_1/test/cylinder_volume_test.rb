# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'cylinder_volume'

class CylinderVolumeTest < Test::Unit::TestCase
	def test_cylinder_volume
		assert_equal(2*Math::PI, cylinder_volume(1, 1))
	end
	
	def test_ground_surface
		assert_equal(2*Math::PI, ground_surface(1))
	end
end
