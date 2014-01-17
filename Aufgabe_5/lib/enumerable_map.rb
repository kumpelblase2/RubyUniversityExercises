module Enumerable
	def map
		hash = {}
		self.each_with_index { |item, index| hash[index] = item }
		hash
	end
	
	def freq_count
		hash = {}
		self.each { |item| if hash.has_key?(item) then hash[item] = hash[item] + 1 else hash[item] = 1 end }
		hash
	end
end