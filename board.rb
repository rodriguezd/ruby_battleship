class Board

	attr_accessor :player, :grid

	fill_char = {open: '+',
				 hit: 'X',
				 miss: '0',
				}

	def initialize(player)
		@player = player
		@grid = []
	end

	def hit?(cell)

	end

	def set_cell(cell, status)

	end

end