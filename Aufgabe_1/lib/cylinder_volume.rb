$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Calcualtes the volume of a cylinder
# cylinder_volume ::= Nat x Nat ->? Nat :::: (in_heigth, in_length) ::
# (in_radius >= 0) :: (in_heigth >= 0) ::
# Test (1, 1) => 2*Math::PI, 
#
def cylinder_volume(in_radius, in_heigth)
	ground_surface(in_radius) * in_heigth
end

# Calculates the ground surface for a cylinder
# ground_surface ::= Nat ->? Nat :::: (in_radius) ::
# (in_radius >= 0) ::
# Test (1) => 2*Math::PI
def ground_surface(in_radius)
	return in_radius * 2 * Math::PI
end