$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

class Set
	def superset?(in_set)
		check_pre((in_set.set?))
		in_set.each { |obj| self.include?(obj) }
	end
	
	def ==(in_set)
		self.equal?(in_set) or (in_set.set? and in_set.length == self.length and in_set.each { |obj| self.include?(obj) })
	end
end