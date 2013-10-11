# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'hollow_cube_volume'

class HollowCubeVolumeTest < Test::Unit::TestCase
  def test_hollow_cube_volume
    assert_equal(hollow_cube_volume(3,3), 0)
    assert_equal(hollow_cube_volume(3,2), 19)
    assert_raise(RuntimeError) { |i| hollow_cube_volume(1, 2) }
    assert_not_equal(hollow_cube_volume(3,3), 1)
  end
  
  def test_hollow_cube_multi_dimension
	assert_equal(0, hollow_cube_volume(3, 3, 0))
	assert_equal(hollow_cube_volume(3, 3), hollow_cube_volume(3, 3, 3))
	assert_equal(256 - 81, hollow_cube_volume(4, 3, 4))
	assert_raise(RuntimeError) { |i| hollow_cube_volume(-1, 1, 0)}
  end
  
  def test_cube_volume
	assert_equal(0, cube_volume(0))
	assert_equal(0, cube_volume(3, 0))
	assert_equal(27, cube_volume(3))
	assert_equal(8, cube_volume(2))
	assert_equal(4, cube_volume(2, 2))
	assert_raise(RuntimeError) { |i| cube_volume(-1)}
  end
end