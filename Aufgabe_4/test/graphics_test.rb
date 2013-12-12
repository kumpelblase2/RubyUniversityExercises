# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'graphics'

class GraphicsTest < Test::Unit::TestCase
	P11 = Point1d[1]
	P12 = Point1d[2]
	P13 = Point1d[3]
	P14 = Point1d[4]
	R11 = Range1d[P11, P12]
	R12 = Range1d[P13, P14]
	R13 = Range1d[P11, P13]
	R14 = Range1d[P12, P14]
	U11 = Union1d[R11, R12]
	U12 = Union1d[R13, R14]
	U13 = Union1d[R11, R13]
	U14 = Union1d[R12, R14]
	
	P21 = Point2d[P11, P11]
	P22 = Point2d[P12, P12]
	P23 = Point2d[P13, P13]
	P24 = Point2d[P14, P14]
	R21 = Range2d[R11, R12]
	R22 = Range2d[R13, R14]
	R23 = Range2d[R12, R14]
	R24 = Range2d[R11, R13]
	U21 = Union2d[R21, R22]
	U22 = Union2d[R23, R24]
	U23 = Union2d[R21, R24]
	U24 = Union2d[R22, R23]
	
	def test_classes
		assert_nothing_raised(RuntimeError) {
			p = Point1d[1]
			p2 = Point1d[2]
			s = Range1d[p, p2]
			s2 = Range1d[p, p2]
			u = Union1d[s, s2]
			u2 = Union1d[u, u]
		}
		
		assert_nothing_raised(RuntimeError) {
			p3 = Point1d[1]
			p4 = Point1d[2]
			p = Point2d[Point1d[1],Point1d[1]]
			p2 = Point2d[Point1d[2],Point1d[2]]
			r = Range1d[p3, p4]
			s = Range2d[r, r]
			u = Union2d[s, s]
			u2 = Union2d[u, u]
		}
	end
	
	def test_creation_fail
		assert_raise(RuntimeError) { Point1d[1.0] }
		assert_raise(RuntimeError) { Point1d['1.0'] }
		assert_raise(RuntimeError) { Range1d[1, 1] }
		assert_raise(RuntimeError) { Range1d['Point1d[1]', 'Point1d[1]'] }
		assert_raise(ArgumentError) { Union1d[Range2d[Range1d[Point1d[1], Point1d[1]], Range1d[Point1d[1], Point1d[1]]]] }
		assert_raise(RuntimeError) { Point2d[1.0, 1.0] }
	end
	
	def test_equality
		assert_equal(true, P11 == P11)
		assert_equal(true, P11 == Point1d[1])
		assert_equal(true, R11 == Range1d[Point1d[1], Point1d[2]])
		assert_equal(false, P11 == Point1d[2])
		assert_equal(false, Range1d[Point1d[1], Point1d[1]] == R11)
		assert_equal(true, U11 == U11)
		assert_equal(false, U11 == R11)
		assert_equal(true, U11 == Union1d[R11, R12])
	end
end