# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'graphics'

class GraphicsTest < Test::Unit::TestCase
	def test_point1d
		assert_raise(RuntimeError) { Point1d[1.0] }
		assert_raise(RuntimeError) { Point1d['1'] }
	end
	
	def test_shape1d
		assert_equal(shape1d?(Range1d[1,2]), true)
		assert_equal(shape1d?(Union1d[Range1d[1..2], Range1d[1,2]]), true)
		assert_equal(shape1d?(Union1d[Union1d[Range1d[1,2], Range1d[1, 2]], Range1d[1,2]]), true)
		assert_equal(shape1d?(1), false)
	end
	
	def test_shape2d
		assert_equal(shape2d?(Range2d[Range1d[1,2], Range1d[1,2]]), true)
	end
	
	def test_include
		assert_equal(shape_include?(Range1d[1,3], 2), true)
		assert_equal(shape_include?(Range2d[Range1d[1,5], Range1d[1,5]], Point2d[2,2]), true)
		assert_raise(RuntimeError) { shape_include?(1, 1) }
	end
end
