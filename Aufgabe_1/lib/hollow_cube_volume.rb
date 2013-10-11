$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Calculation of hollow cube volume
# hollow_cube_volume ::= Nat x Nat =>? Nat :: (in_length_outer, in_length_inner) ::::
# (in_length_outer >= in_length_inner) ::
# Test (3, 3) => 0, (3,2) => 19,
# (1,2) => Err, ("", 4) => Err

def hollow_cube_volume(in_length_outer, in_length_inner)
  if(in_length_outer < in_length_inner)
    raise("a is not >= b")
  elsif(in_length_outer < 0 or in_length_inner < 0)
    raise("either a or b < 0")
  end

  volume_a = in_length_outer * in_length_outer * in_length_outer
  volume_b = in_length_inner * in_length_inner * in_length_inner
  volume_a - volume_b
end