require './grid_cell'
require './ship'

class Board

	attr_accessor :grid

	def initialize
		@grid = Array.new(10).map! {Array.new(10).map! {Grid_Cell.new}}
	end

	# def set_cell(cell, status)
	# end

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

	def valid_coordintes?(ship, start_position, orientation)
		if orientation == :horizontal
			# puts "row length: " + (start_position[:column] + ship.length).to_s
			(start_position[:column] + ship.length) < 10
		else
			# puts "column length: " + (start_position[:row] + ship.length).to_s
			(start_position[:row] + ship.length) < 10
		end
	end

	def check_clearance? (ship, start_position, orientation)
		clear = false
		length = ship.length
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
		true
	end

	def place_ship (ship, start_position, orientation)


	end
end

if __FILE__ == $0
	s = Ship.new(:player, :carrier)
	a = Board.new
	a.grid[5][9].hit
	a.to_s
	if a.valid_coordintes?(s, {:row => 4, :column => 4}, :horizontal)
		puts "VC: True"
		if a.check_clearance?(s, {:row => 4, :column => 4}, :horizontal)
		puts "CC: True"
		else
		puts "CC: False"
		end
	else
		puts "VC: False"
	end


end