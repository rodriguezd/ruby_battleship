class Player

	attr_accessor :name, :ships_left

	def initialize(name)
		@name = name
		@ships_left = 5
	end

	def to_s
		@name
	end

end