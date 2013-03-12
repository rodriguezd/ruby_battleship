require_relative 'ship'

class Battleship < Ship

	attr_accessor :length, :fill_char

	def initialize
		@length = 4
  	@fill_char = 'B'
  	super
	end

end