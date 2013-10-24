# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'pentadodekaeder_surface'

class PentadodekaederSurfaceTest < Test::Unit::TestCase
  def test_pentadodekaeder_surface
    assert_equal(0.0, pentadodekaeder_surface(0))
    assert_in_delta(185.8115, pentadodekaeder_surface(3), 0.0001)
    assert_in_delta(743.24623, pentadodekaeder_surface(6), 0.0001)
    assert_raise(RuntimeError) { pentadodekaeder_surface(-1) }
    assert_raise(RuntimeError) { pentadodekaeder_surface('1') }
    assert_not_equal(1, pentadodekaeder_surface(4))
  end
  
  def test_pentagon_surface
	  assert_equal(0, pentagon_surface(0))
	  assert_in_delta(15.4842, pentagon_surface(3), 0.0001)
	  assert_in_delta(27.5276, pentagon_surface(4), 0.0001)
	  assert_in_delta(6.8819, pentagon_surface(2), 0.0001)
	  assert_raise(RuntimeError) { pentagon_surface(-1) }
    assert_raise(RuntimeError) { pentagon_surface('1') }
  end
end