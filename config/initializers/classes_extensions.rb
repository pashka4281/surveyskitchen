class Array
	def mean 
	  inject(0.0) { |result, el| result + el } / size
	end
end