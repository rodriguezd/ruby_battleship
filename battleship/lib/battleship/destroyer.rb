require_relative 'ship'

class Destroyer < Ship

	def initialize
		@length = 3
  	@fill_char = 'D'
  	super
	end

end