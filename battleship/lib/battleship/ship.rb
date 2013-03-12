class Ship

	attr_accessor :length, :hits, :fill_char

	def initialize
		@hits = 0
	end

	def hit
		@hits += 1
	end

	def sunk?
		@length == @hits
	end

	def to_s
		@fill_char
	end

end
