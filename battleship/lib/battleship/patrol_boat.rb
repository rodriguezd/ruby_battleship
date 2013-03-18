require_relative 'ship'

class PatrolBoat < Ship

	def initialize
		@length = 2
  	@fill_char = 'P'
  	super
	end

end