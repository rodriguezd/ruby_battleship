require_relative 'ship'

class Submarine < Ship

	def initialize
		@length = 3
  	@fill_char = 'S'
  	super
	end

end