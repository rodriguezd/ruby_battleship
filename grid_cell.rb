class Grid_Cell

	attr_accessor :status

#cell fill characters
FILL_CHAR = {:open => '+',
			   		 :hit => 'X',
			   		 :miss => '0',
			   		 :carrier => 'C',
			  		 :battleship => 'B',
			  		 :destroyer => 'D',
			  		 :submarine => 'S',
			  		 :patrol => 'P'}

	def initialize(status = :open)
		@status = status
	end

	def to_s
		FILL_CHAR[@status]
	end

	def hit
		@status = :hit
	end

	def miss
		@status = :miss
	end

end
