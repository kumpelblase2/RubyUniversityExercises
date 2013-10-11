$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Calculates the volume of a hollow cube with the given amount of dimensions
# hollow_cube_volume ::= Nat x Nat x Nat =>? Nat :: (in_length_outer, in_length_inner, in_dimensions) ::::
# (in_length_outer >= in_length_inner) :: (in_dimensions >= 0) ::
# Test (3, 3) => 0, (3,2) => 19,
# (1,2) => Err, ("", 4) => Err
# (3, 3, 0) => 0, (4, 3, 4) => 175
# (1, 1, -1) => Err, (-1, 1, 2) => Err
def hollow_cube_volume(in_length_outer, in_length_inner, in_dimensions = 3)
  check_pre(((in_length_outer.nat?) and 
				(in_length_inner.nat?) and 
				(in_dimensions.nat?) and
				(in_length_outer >= in_length_inner)))
  volume_a = cube_volume(in_length_outer, in_dimensions)
  volume_b = cube_volume(in_length_inner, in_dimensions)
  volume_a - volume_b
end

# Calculates the volume of a cube in given dimensions
# By default, the dimensions are 3
# cube_volume ::= Nat x Nat => Nat :: (in_length, in_dimensions) ::::
# (in_length >= 0) :: (in_dumensions >= 0) ::
def cube_volume(in_length, in_dimensions = 3)
	check_pre(((in_length.nat?) and (in_dimensions.nat?)))
	if in_dimensions == 0 then
		return 0
	end
	
	return in_length ** in_dimensions
end