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
		deploy_ship(@player, @player.carrier)
		deploy_ship(@player, @player.battleship)
		deploy_ship(@player, @player.destroyer)
		deploy_ship(@player, @player.submarine)
		deploy_ship(@player, @player.patrol)
		# play_rounds(@player)
	end

	def set_player
		print "Enter name: "
		name = gets.chomp
		@player = Player.new(name)
	end

	def deploy_ship(player, ship)
		valid = false
		while valid == false do
			position = {}
			while valid == false do
				print "#{ship.type.capitalize} orientation: horizaontal(H) or vertical(V)? "
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
				print "#{ship.type.capitalize} starting position: "
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
			if player.board.valid_coordinates?(ship.type, position, orientation) && player.board.check_clearance?(ship.type, position, orientation)
				ship.place_ship(player.board, position, orientation)
				valid = true
				@player.board.to_s
			else
				puts "Invalid position for ship."
			end
		end
	end

end

if __FILE__ == $0
	game = Game.new
	game.play
	# @player.board.to_s
end