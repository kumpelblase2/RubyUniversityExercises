$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

CONSTANT = Math.sqrt(25 + 10.0 * Math.sqrt(5))

def pentadodekaeder_surface(in_edge_length)
  check_pre((in_edge_length.nat?))
  return 12 * pentagon_surface(in_edge_length)
end

def pentagon_surface(in_edge_length)
  check_pre((in_edge_length.nat?))
  return ((in_edge_length ** 2) / 4.0) * CONSTANT
end