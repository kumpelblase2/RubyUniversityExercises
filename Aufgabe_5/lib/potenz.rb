def potenz(in_number, in_potenz)
	potenz0(0, in_number, in_potenz)
end

def potenz0(in_acc, in_number, in_potenz)
	in_potenz == 0 ? in_acc : potenz0(in_acc * in_number, in_number, in_potenz - 1)
end

def potenz_(in_number, in_potenz)
	acc = 1
	while(in_potenz >= 1)
		acc *= in_number
		in_potenz -= 1
	end
	acc
end