require './grid_cell'
require './ship'

class Board

	attr_accessor :grid

	def initialize(player)
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

	def valid_coordinates?(ship, start_position, orientation)
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

	def hit_miss (cell)
		if @grid[cell[:row], cell[:column]].status == :open
		   return :miss
		 elsif @grid[cell[:row], cell[:column]].status == :hit ||
		 	   @grid[cell[:row], cell[:column]].status == :miss
		 	   return :called
		 else
		 	@grid[cell[:row], cell[:column]].status = :hit
		 	return :hit
		 end
	end

end

if __FILE__ == $0
	s = Ship.new(:player, :patrol)
	a = Board.new
	a.to_s
	s.place_ship(a, {:row => 3, :column => 0}, :horizontal)
	a.to_s


end