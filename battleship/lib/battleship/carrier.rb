require_relative 'ship'

class Carrier < Ship

	def initialize
		@length = 5
  	@fill_char = 'C'
  	super
	end

end

if __FILE__ == $0
	c = Carrier.new
	puts c.length
	puts c.fill_char
	puts c.hits
	puts c.sunk?
end