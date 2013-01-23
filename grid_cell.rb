class Grid_Cell

	attr_accessor :ship, :status

@@FILL_CHAR = {:open => '+',
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
		@@FILL_CHAR[@status]
	end

	def hit
		@status = :hit
	end

	def hit?
		@status == :hit
	end

	def miss
		@status = :miss
	end

end

if __FILE__ == $0
	a = Grid_Cell.new
	b = Grid_Cell.new
	c = Grid_Cell.new
	b.hit
	puts a.status
	puts b.status
	puts c.status
end
