def bubble_sort array
	n = array.length-1
	iterated = 0

	n.times do
		swapped = false
		for i in (1..n)
			if array[i] < array[i-1]
				
				temp = array[i]
				array[i] = array[i-1]
				array[i-1] = temp
	
				swapped = true
			end
		end
		break if swapped == false
		n-=1
		iterated += 1
	end
	puts array.to_s
	puts "Iterated #{iterated} times"
end

def bubble_sort_by array
	n = array.length-1

	n.times do
		swapped = false
		for i in (1..n)
			compare = yield(array[i-1], array[i])
			if compare>0
				temp = array[i]
				array[i] = array[i-1]
				array[i-1] = temp

				swapped = true
			end
		end
		break if swapped == false
		n-=1
	end
	puts array.to_s
end