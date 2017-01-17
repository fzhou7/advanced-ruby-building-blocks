module Enumerable
	def my_each
		for i in self
			yield(i)
		end
	end

	def my_each_with_index
		i=0
		for i in (0...self.length)
			yield(self[i], i)
		end
	end

	def my_select
		if self.is_a? Array
			selected = []
			self.my_each do |x|
				selected << x if yield(x)
			end
			selected
		elsif self.is_a? Hash
			selected_hash = {}
			self.my_each do |key,value|
				selected_hash[key] = value if yield(key,value)
			end
			selected_hash
		end
	end

	def my_all?
		self.my_each {|i| return false if !yield(i) }
	end

	def my_any?
		out = false
		self.my_each {|i| out=true if yield(i)}
		out
	end

	def my_none?
		out=false
		self.my_each {|i| out=true if yield(i)}
		out

	end

	def my_count
		count=0
		self.my_each {count+=1}
		count
	end

	def my_map
		if self.is_a? Array
			out = []
			self.my_each {|i| out << i if yield(i)}
			out
		elsif self.is_a? Hash
			out = {}
			self.my_each {|key, value| out[key] = value if yield(key, value)}
			out
		end
	end

	def my_map_proc (proc)
		if self.is_a? Array
			out = []
			self.my_each {|i| out << proc.call(i)}
			out
		elsif self.is_a? Hash
			out = {}
			self.my_each {|key, value| out[key] = value if proc.call(key, value)}
		end
	end


	def my_inject
		out=self.first
		first = true
=begin
		for i in (1...self.size)
			out = yield(out, self[i])
		end
=end
		self.each do |i|
			if first
				first = false
			else
				out = yield(out, i)
			end
		end

		out
	end

end

def multiply_els arr
	arr.my_inject {|sum, num| num * sum}
end


#Tests
[1,2,3].my_each {|i| puts i}
{:greeting => 'hi', :farewell => 'bye'}.my_each {|key,value| puts "#{key}: #{value}"}
[1,2,3].my_each_with_index {|i,k| puts "#{k}: #{i}"}
puts ([1,2,3,4,5].my_select { |i| i % 2 != 0 }).to_s
h = {4 => 6, 3 => 1}
puts h.my_select {|key,value| key > value }
puts [1,2,'hi',3].my_all? {|x| x.is_a? Integer}
puts [1,2,'hi'].my_any? {|x| x.is_a? String}
puts [1,2,'hi'].my_none? {|x| x.is_a? Hash}
puts [1,2,'hi'].my_count
puts ([1,2,'hi'].my_map {|x| x.is_a? Integer}).to_s
puts ({hi: "bye", "there" => 5, course: "era", 4 => 14}.my_map {|key, value| key.is_a? Symbol})
puts [1,2,3,4,5].my_inject {|sum, num| sum + num}
puts (1..5).my_inject {|sum, num| sum+num }
puts [1,2,3,4,5].my_inject {|sum, num| num - sum}
puts (1..5).my_inject {|sum,num| num-sum}
puts multiply_els([2,4,5])