# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'endrec'

class EndrecTest < Test::Unit::TestCase
	def endrec_test
		puts "test"
		assert_equal(2, List['a', 1].size_endrec)
		assert_equal(5, List['b', List[1, 2, 3]].size_endrec)
		assert_equal(0, List[].size_endrec)
		assert_equal(2, List[List[List[]]].size_endrec)
	end
end