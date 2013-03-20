require_relative 'ship'

class Carrier < Ship

	def initialize
		@length = 5
  	@fill_char = 'C'
  	super
	end
end