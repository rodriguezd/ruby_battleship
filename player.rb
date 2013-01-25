require './board'
require './ship'

class Player

	attr_accessor :name, :board, :ships_left, :target_board
	attr_reader :carrier, :battleship, :destroyer, :submarine, :patrol

	def initialize(name)
		@name = name
		@board = Board.new
		@target_board = Board.new
		@carrier = Ship.new(:carrier)
		@battleship = Ship.new(:battleship)
		@destroyer = Ship.new(:destroyer)
		@submarine = Ship.new(:submarine)
		@patrol = Ship.new(:patrol)
		@ships_left = 5
	end

	def to_s
		@name
	end

	def take_shot

	end

end