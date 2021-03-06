class GridCell

	attr_accessor :status, :ship

	FILL_CHAR = {:open => '+',
			   			 :hit => 'X',
			   			 :miss => '0'}

	def initialize(status = :open, ship = nil)
		@status = status
		@ship = ship
	end

	def to_s
		if @ship && @status != :hit
			@ship.to_s
		elsif @status == :hit
			FILL_CHAR[@status].colorize(:light_red)
		elsif @status == :miss
			FILL_CHAR[@status].colorize(:yellow)
		else
			FILL_CHAR[@status]
		end
	end

	def hit
		@status = :hit
	end

	def miss
		@status = :miss
	end
end