class Hash
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.hash? and self.size == in_obj.size and self.each { |key, value| in_obj.has_key?(key) and in_obj[key] == value })
	end
end