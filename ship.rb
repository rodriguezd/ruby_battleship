class Ship

	@@length = {:carrier => 5,
			  :battleship => 4,
			  :destroyer => 3,
			  :submarine => 3,
			  :patrol => 2}

	attr_accessor :board, :type, :length, :position, :hits, :sunk

	def initialize(board, type)
		@board= board
		@type = type
		@length = @@length[type]
		@position = []
		@hits = 0
		@sunk = false
	end

	def sunk?
		@sunk
	end

	def to_s
		"#{@board}'s #{@type}"
	end

end

if __FILE__ == $0
	a = Ship.new(:player, :carrier)
	puts a
	puts a.type
	puts a.length
	puts a.sunk?

end