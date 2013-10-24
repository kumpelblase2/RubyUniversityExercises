$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Constant which is used to calculate the surface of a pentagon
CONSTANT = Math.sqrt(25 + 10.0 * Math.sqrt(5))

# Calcualtes the surface of a pentadodekaeder
# pentadodekaeder_surface ::= Float ->? Float :::: (in_edge_length) ::
# (in_edge_length >= 0) ::
# Test (3) ~> 185.811559, (6) ~> 743.24623
# ('1') => Err, (-1) => Err
def pentadodekaeder_surface(in_edge_length)
  check_pre(((in_edge_length.numeric?) and (in_edge_length >= 0)))
  return 12 * pentagon_surface(in_edge_length)
end

# Calcualtes the surface of a pentagon
# pentadodekaeder_surface ::= Float ->? Float :::: (in_edge_length) ::
# (in_edge_length >= 0) ::
# Test (3) ~> 15.4842, (4) ~> 27.5276, (2) ~> 6.8819
# ('1') => Err, (-1) => Err
def pentagon_surface(in_edge_length)
  check_pre(((in_edge_length.numeric?) and (in_edge_length >= 0)))
  return ((in_edge_length ** 2) / 4.0) * CONSTANT
end