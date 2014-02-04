class Hash
	def add_counts(in_hash)
		check_pre((in_hash.hash?))
		self.each_value { |value| check_pre(value.int?) }
		in_hash.each_value { |value| check_pre(value.int?) }
		
		self.merge(in_hash) { |key, old, new|
			check_pre(((old.int?) and (new.int?)))
			old + new
		}
	end
end