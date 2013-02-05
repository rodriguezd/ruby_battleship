require_relative 'grid_cell'
require_relative 'ship'

class Board

	attr_accessor :grid

	NUM_SHIPS = 5
	BOARD_DIM = 10
	ROW = ['A','B','C','D','E','F','G','H','I','J']
	COLUMN = ['1','2','3','4','5','6','7','8','9','10']

	def initialize
		@grid = Array.new(BOARD_DIM).map! {Array.new(BOARD_DIM).map! {Grid_Cell.new}}
	end

		#print board grid
		def to_s
		row_letter = ('A'..'Z').to_a
		i = 0
		puts "  1 2 3 4 5 6 7 8 9 10"
		@grid.each do |row|
			print row_letter[i] + ' '
			row.each {|cell| print cell.to_s + ' '}
			print "\n"
			i += 1
		end
	end

	#validate ship placement remains within board
	def valid_coordinates?(ship, start_position, orientation)
		if orientation == :horizontal
			(start_position[:column] + Ship::LENGTH[ship]) <= BOARD_DIM
		else
			(start_position[:row] + Ship::LENGTH[ship]) <= BOARD_DIM
		end
	end

	#validate ship placement conflicts with another placed ship
	def check_clearance?(ship, start_position, orientation)
		length = Ship::LENGTH[ship]
		row = start_position[:row]
		column = start_position[:column]
		length.times do
			if self.grid[row][column].status != :open
				return false
			elsif orientation == :horizontal
				column += 1
			else
				row += 1
			end
		end
		return true
	end

	# method currently not used
	# def hit_or_miss(cell)
	# 	if @grid[cell[:row], cell[:column]].status == :open
	# 	   return :miss
	# 	 elsif @grid[cell[:row], cell[:column]].status == :hit ||
	# 	 	   @grid[cell[:row], cell[:column]].status == :miss
	# 	 	   return :called
	# 	 else
	# 	 	@grid[cell[:row], cell[:column]].status = :hit
	# 	 	return :hit
	# 	 end
	# end

end
