class Ship

	#ship type and length
	types = {'carrier': 5,
			 'battleship': 4,
			 'destroyer': 3,
			 'submarine': 3,
			 'patrol': 2}

	attr_accessor :player, :type, :position, :hits, :sunk

	def initialize(player, type)
		@player = player
		@type = type
		@position = []
		@hits = 0
		@sunk = false
	end

	def sunk?
		@sunk
	end

end