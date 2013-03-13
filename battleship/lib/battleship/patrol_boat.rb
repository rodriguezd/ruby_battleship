require_relative 'ship'

class PatrolBoat < Ship

	attr_accessor :length, :fill_char

	def initialize
		@length = 2
  	@fill_char = 'P'
  	super
	end

end