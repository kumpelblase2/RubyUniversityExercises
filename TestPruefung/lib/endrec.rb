$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Gets the size of the list using an endrecursion
# List -> Integer
def size_endrec(in_list)
	check_pre((in_list.list?))
	size_endrec0(0, in_list)
end

def size_endrec0(acc, in_list)
	in_list.empty? ? acc : size_endrec0(acc + 1, in_list.rest)
end