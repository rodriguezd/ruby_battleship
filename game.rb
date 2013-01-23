require './player'
require './board'

class Game

	attr_accessor :player

	# def initialize

	# end

	@opponent = Player.new('Opponent')

	def play
		puts "Let's play some Battleship!\n"
		set_player
		place_carrier(@player)
		# place_battleship(@player)
		# place_destroyer(@player)
		# place_submarine(@player)
		# place_patrol(@player)
		# play_rounds(@player)
	end

	def set_player
		print "Enter name: "
		name = gets.chomp
		@player = Player.new(name)
	end

	def place_carrier(player)
		valid = false
		while valid == false do
			position = {}
			while valid == false do
				print "Carrier orientation: horizaontal(H) or vertical(V)? "
				input = gets.chomp.rstrip.upcase
				if input == 'H'
					orientation = :horizontal
					valid = true
				elsif input == 'V'
					orientation = :vertical
					valid = true
				else
					puts "Invalid orientation entry."
				end
			end

			valid = false
			while valid == false do
				print "Carrier starting position: "
				input = gets.chomp.rstrip.upcase
				position[:row] = Board::ROW.rindex(input.split(//, 2)[0])
				position[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
				if (0..9).include?(position[:row]) && (0..9).include?(position[:column])
					valid = true
				else
					puts "Invalid coordinates."
				end
			end

			valid = false
			if player.board.valid_coordinates?(:carrier, position, orientation) && player.board.check_clearance?(:carrier, position, orientation)
				player.carrier.place_ship(player.board, position, orientation)
				valid = true
				@player.board.to_s
			else
				puts "Invalid position for ship."
			end
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

if __FILE__ == $0
	game = Game.new
	game.play
	# @player.board.to_s
end