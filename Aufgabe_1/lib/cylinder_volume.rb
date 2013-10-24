$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"


# Calcualtes the volume of a cylinder
# cylinder_volume ::= Float x Float ->? Float :::: (in_heigth, in_length) ::
# (in_radius >= 0) :: (in_heigth >= 0) ::
# Test (1, 1) ~> 6.2831853, (5, 5) ~> 157.079632
# ('1', '2') => Err
def cylinder_volume(in_radius, in_height)
  check_pre(((in_radius >= 0) and (in_height >= 0)))
	ground_surface(in_radius) * in_height
end

# Calculates the ground surface for a cylinder
# ground_surface ::= Float ->? Float :::: (in_radius) ::
# (in_radius >= 0) ::
# Test (1) ~> 6.2831853, (0) => 0
# ('1') => Err
def ground_surface(in_radius)
  check_pre((in_radius >= 0))
	return in_radius * 2 * Math::PI
end