class Array
	def to_int
		reverse = self.reverse
		acc = 0
		reverse.each_with_index { |obj,index| acc += obj * (10 ** index) }
		acc
	end
	
	def even_only
		self.select { |num| num.even? }
	end
	
	def flatten
		acc = []
		self.each { |obj| obj.array? ? acc.concat(obj.flatten) : acc.concat([obj]) }
		acc
	end
	
	def no_of_leaves
		acc = 0
		self.each { |obj| acc += (obj.array? ? obj.no_of_leaves : 1) }
		acc
	end
	
	def each_pair
		check_pre(block_given?)
		self.each { |obj| if obj.array? and obj.size == 2 then yield(obj[0], obj[1]) end }
	end
end