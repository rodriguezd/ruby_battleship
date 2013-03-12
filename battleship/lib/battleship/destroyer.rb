require_relative 'ship'

class Destroyer < Ship

	attr_accessor :length, :fill_char

	def initialize
		@length = 3
  	@fill_char = 'D'
  	super
	end

end