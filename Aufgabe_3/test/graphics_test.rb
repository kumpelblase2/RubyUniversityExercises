# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'graphics'

class GraphicsTest < Test::Unit::TestCase	
	def test_shape1d
		assert_equal(shape1d?(Range1d[1,2]), true)
		assert_equal(shape1d?(Union1d[Range1d[1,2], Range1d[1,2]]), true)
		assert_equal(shape1d?(Union1d[Union1d[Range1d[1,2], Range1d[1, 2]], Range1d[1,2]]), true)
		assert_equal(shape1d?(1), false)
	end
	
	def test_shape2d
		assert_equal(shape2d?(Range2d[Range1d[1,2], Range1d[1,2]]), true)
    assert_equal(shape2d?(Union2d[Range2d[Range1d[1,2], Range1d[1,2]], Range2d[Range1d[1,2], Range1d[1,2]]]), true)
	end
	
	def test_include
		assert_equal(shape_include?(Range1d[1,3], 2), true)
		assert_equal(shape_include?(Range2d[Range1d[1,5], Range1d[1,5]], Point2d[1,2]), true)
		assert_raise(RuntimeError) { shape_include?(1, 1) }
	end
	
	def test_translate
		assert_equal(translate(Range1d[1, 2], 1), Range1d[2, 3])
		assert_equal(translate(Range1d[999, 1000], 1), Range1d[1000, 1001])
		assert_equal(translate(Range2d[Range1d[1, 2], Range1d[1, 2]], Point2d[1, 1]), Range2d[Range1d[2, 3], Range1d[2, 3]])
	end
	
	def test_bounds
		assert_equal(bounds(Range1d[1, 2]), Range1d[1,2])
		assert_equal(bounds(Union1d[Range1d[1, 2], Range1d[2, 3]]), Range1d[1, 3])
		assert_equal(bounds(Range2d[Range1d[1, 2], Range1d[1, 2]]), Range2d[Range1d[1,2], Range1d[1,2]])
		assert_equal(bounds(Union2d[Range2d[Range1d[1,2], Range1d[1,2]], Range2d[Range1d[2,3], Range1d[2,3]]]), Range2d[Range1d[1,3], Range1d[1,3]])
	end
	
	def test_equal_dim
		assert_equal(true, equal_by_dim?(Range1d[1,2], Range1d[4, 3]))
		assert_equal(true, equal_by_dim?(Union1d[Range1d[1,2], Range1d[2,3]], Range1d[1,2]))
		assert_equal(false, equal_by_dim?(Range1d[1,2], Range2d[Range1d[1,2], Range1d[2,3]]))
	end
end
