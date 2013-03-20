require_relative 'grid_cell'
require_relative 'carrier'
require_relative 'battleship'
require_relative 'destroyer'
require_relative 'submarine'
require_relative 'patrol_boat'

class Board

	attr_accessor :grid

	NUM_SHIPS = 5
	BOARD_DIM = 10
	ROW = ['A','B','C','D','E','F','G','H','I','J']
	COLUMN = ['1','2','3','4','5','6','7','8','9','10']

	def initialize
		@grid = Array.new(BOARD_DIM).map! {Array.new(BOARD_DIM).map! {GridCell.new}}
	end

		def to_s
			row_letter = ('A'..'Z').to_a
			i = 0
			puts "  1 2 3 4 5 6 7 8 9 10".colorize(:green)
			@grid.each do |row|
				print row_letter[i].colorize(:green) + ' '
				row.each {|cell| print cell.to_s + ' '}
				print "\n"
				i += 1
			end
	end

	def place_ship(ship, start_position, orientation)
		row = start_position[:row]
		column = start_position[:column]
		ship.length.times do
			if orientation == :horizontal
				self.grid[row][column].ship = ship
				self.grid[row][column].status = :occupied
				column += 1
			else
				self.grid[row][column].ship = ship
				self.grid[row][column].status = :occupied
				row += 1
			end
		end
	end

	#validate ship placement remains within board
	def valid_coordinates?(ship, start_position, orientation)
		if orientation == :horizontal
			(start_position[:column] + ship.length) <= BOARD_DIM
		else
			(start_position[:row] + ship.length) <= BOARD_DIM
		end
	end

	#validate ship placement conflicts with another placed ship
	def check_clearance?(ship, start_position, orientation)
		row = start_position[:row]
		column = start_position[:column]
		ship.length.times do
			if self.grid[row][column].ship
				return false
			elsif orientation == :horizontal
				column += 1
			else
				row += 1
			end
		end
		return true
	end
end