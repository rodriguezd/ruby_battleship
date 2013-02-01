class Ship

	LENGTH = {:carrier => 5,
			      :battleship => 4,
			      :destroyer => 3,
			      :submarine => 3,
			      :patrol => 2}

	attr_accessor :type, :length, :hits

	def initialize(type)
		@type = type
		@length = LENGTH[type]
		@hits = 0
	end

	def place_ship(board, start_position, orientation)
		row = start_position[:row]
		column = start_position[:column]
		@length.times do
			if orientation == :horizontal
				board.grid[row][column].status = @type
				column += 1
			else
				board.grid[row][column].status = @type
				row += 1
			end
		end
	end

	def sunk?
		@length == @hits
	end

	def hit
		@hits += 1
	end

	def to_s
		"#{@board}'s #{@type}"
	end

end
