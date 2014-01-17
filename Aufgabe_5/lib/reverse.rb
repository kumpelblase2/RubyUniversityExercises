$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

class List
	def reverse_endrec
		self.reverse_endrec_(List[], self)
	end
	
	def reverse_endrec_(in_acc, in_current)
		if in_current.empty? then return in_acc end
		reverse_endrec_(in_acc.prepend(in_current.first), in_current.rest)
	end
	
	def reverse_while
		acc = List[]
		list = self
		while not list.empty?
			acc.prepend(list.first)
			list = list.rest
		end
		acc
	end
	
	def reverse_reduce
		acc = List[]
		self.reduce(List[]) { |arg| acc.prepend(arg) }
		acc
	end
end