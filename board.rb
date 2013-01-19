require './grid_cell'

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
end

if __FILE__ == $0
a = Board.new
a.grid[2][1] = 'Z'
a.to_s
puts a.grid[2][1]
puts a.grid[3][1]
end