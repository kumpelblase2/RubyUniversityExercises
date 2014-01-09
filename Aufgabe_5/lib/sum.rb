def sum(in_number)
	sum0(0, in_number)
end

def sum0(in_acc, in_number)
	(in_number <= 0 ? in_acc : sum0(in_acc + in_number, in_number - 1))
end

def sum_(in_number)
	acc = 0
	while(in_number > 0)
		acc += in_number
		in_number -= 1
	end
	acc
end