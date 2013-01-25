class Ship

	LENGTH = {:carrier => 5,
			      :battleship => 4,
			      :destroyer => 3,
			      :submarine => 3,
			      :patrol => 2}

	attr_accessor :type, :length, :hits

	def initialize(type)
		@type = type
		@length = LENGTH[type]
		@hits = 0
	end

	def place_ship(board, start_position, orientation)

		row = start_position[:row]
		column = start_position[:column]
		@length.times do
			if orientation == :horizontal
				board.grid[row][column].ship = self
				board.grid[row][column].status = @type
				column += 1
			else
				board.grid[row][column].ship = self
				board.grid[row][column].status = @type
				row += 1
			end
		end
	end


	# def deploy_ship(player)
	# 	valid = false
	# 	while valid == false do
	# 		position = {}
	# 		while valid == false do
	# 			print "#{@type.capitalize} orientation: horizaontal(H) or vertical(V)? "
	# 			input = gets.chomp.rstrip.upcase
	# 			if input == 'H'
	# 				orientation = :horizontal
	# 				valid = true
	# 			elsif input == 'V'
	# 				orientation = :vertical
	# 				valid = true
	# 			else
	# 				puts "Invalid orientation entry."
	# 			end
	# 		end

	# 		valid = false
	# 		while valid == false do
	# 			print "#{@type.capitalize} starting position: "
	# 			input = gets.chomp.rstrip.upcase
	# 			position[:row] = Board::ROW.rindex(input.split(//, 2)[0])
	# 			position[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
	# 			if (0..9).include?(position[:row]) && (0..9).include?(position[:column])
	# 				valid = true
	# 			else
	# 				puts "Invalid coordinates."
	# 			end
	# 		end

	# 		valid = false
	# 		if player.board.valid_coordinates?(@type, position, orientation) &&
	# 			 player.board.check_clearance?(@type, position, orientation)
	# 				ship.place_ship(player.board, position, orientation)
	# 				valid = true
	# 				player.board.to_s
	# 		else
	# 			puts "Invalid position for ship."
	# 		end
	# 	end
	# end

	def sunk?
		@length == @hits
	end

	def hit
		@hits += 1
	end

	def to_s
		"#{@board}'s #{@type}"
	end

end

if __FILE__ == $0
	a = Ship.new(:player, :carrier)
	puts a
	puts a.type
	puts a.length
	puts a.sunk?

end