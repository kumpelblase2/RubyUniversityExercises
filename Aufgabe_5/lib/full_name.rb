class Object
	def full_name?; false end
end

class FullName
		include Comparable
	
	def self.[](*in_args) check_inv(self.new(*in_args)) end
	def full_name?; true end
	
	def initialize(in_first, in_last)
		@first = in_first
		@last = in_last
	end
	
	def invariant?() self.first_name.string? and self.last_name.string? end
	
	def first_name
		@first
	end
	
	def last_name
		@last
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.full_name? and self.first_name == in_obj.first_name and self.last_name == in_obj.last_name)
	end
	
	def <=>(in_obj)
		check_pre((in_obj.full_name?))
		val = self.first_name <=> in_obj.first_name
		if val == 0 then self.last_name <=> in_obj.last_name else val end
	end
end