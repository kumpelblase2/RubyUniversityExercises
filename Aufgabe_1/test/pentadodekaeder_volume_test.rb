# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'hollow_cube_volume'

class PentadodekaederSurfaceTest < Test::Unit::TestCase
  def test_pentadodekaeder_surface
    assert_equal(pentadodekaeder_surface(0))
    assert_equal(pentadodekaeder_surface(0))
    assert_raise(RuntimeError) { |i| pentadodekaeder_surface(-1) }
    assert_not_equal(pentadodekaeder_surface(4))
  end
  
  def test_pentagon_surface
	  assert_equal(0, pentagon_surface(0))
	  assert_equal(0, pentagon_surface(3))
	  assert_equal(27, pentagon_surface(3))
	  assert_equal(8, pentagon_surface(2))
	  assert_equal(4, pentagon_surface(2))
	  assert_raise(RuntimeError) { |i| pentagon_surface(-1) }
  end
end