require_relative 'ship'

class Battleship < Ship

	def initialize
		@length = 4
  	@fill_char = 'B'
  	super
	end
end