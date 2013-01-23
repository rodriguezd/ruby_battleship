class Game

	attr_accessor :player

	def initialize

	end

	@opponent = Player.new('Opponent')

	def play
		puts "Let's play some Battleship!\n"
		set_player
		place_carrier
		place_battleship
		place_destroyer
		place_submarine
		place_patrol
		play_rounds
	end

	def set_player
		puts "Enter name: "
		name = gets.chomp
		@player = Player.new(name)
	end

	def place_carrier(player)
		position = {}
		puts "Carrier orientation: horizaontal(H) or vertical(V)? "
		orientation = gets.chomp.upcase
		puts "Carrier starting position: "
		input = gets.chomp.upcase
		position[:row] = input.shift
		position[:column] = input

		if player.board.validate_coordinates?(:carrier, position, orientation)
			if player.board.check_clearance(:carrier, position, orientation)
				player.carrier.place_ship(position, orientation)
			else

			end
		else

		end
	end

	def place_battleship(player, start_position, orientation)

	end

	def place_destroyer(player)

	end

	def place_submarine(player)

	end

	def place_patrol(player)

	end

end