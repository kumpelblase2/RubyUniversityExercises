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
end
