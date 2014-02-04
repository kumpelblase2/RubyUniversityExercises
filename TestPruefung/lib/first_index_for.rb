$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

module Enumerable
	# Gets the first index where the given block evaluates true for the value at that index
	# Returns nil if theres no index fulfilling the criteria.
	# Enumberable x Block(Any -> Bool) -> Nat || Nil
	def first_index_for
		check_pre((block_given?))
		self.each_with_index { |elem, index| if yield(elem) then return index end }
		nil
	end
end