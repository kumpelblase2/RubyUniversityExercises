$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

class List
	def +(in_list)
		check_pre(in_list.list?)
		in_list.prepend(self)
	end
end