def fibonacci1(in_number)
	in_number == 0 or in_number == 1 ? in_number : fibonacci(in_number - 1) + fibonacci(in_number - 2)
end

def fibonacci(in_number)
	fibonacci0(in_number - 1, 1, 0)
end

def fibonacci0(in_counter, in_acc, in_acc2)
	in_counter <= 1 ? in_acc + in_acc2 : fibonacci0(in_counter - 1, in_acc + in_acc2, in_acc)
end

def fibonacci_(in_number)
	acc = 1
	acc2 = 0
	while(in_number >= 1)
		acc2 = acc
		acc += acc2
		in_number -= 1
	end
	
	acc + acc2
end