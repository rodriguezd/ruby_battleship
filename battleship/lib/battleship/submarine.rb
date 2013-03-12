require_relative 'ship'

class Submarine < Ship

	attr_accessor :length, :fill_char

	def initialize
		@length = 3
  	@fill_char = 'S'
  	super
	end

end