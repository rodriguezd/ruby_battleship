require './player'
require './board'

class Game

	attr_accessor :player, :opponent

	def play
		puts "Let's play some Battleship!\n"
		set_player
		deploy_ship(@player, @player.carrier)
		# deploy_ship(@player, @player.battleship)
		# deploy_ship(@player, @player.destroyer)
		# deploy_ship(@player, @player.submarine)
		# deploy_ship(@player, @player.patrol)
		# play_rounds(@player)
	end

	def set_player
		print "Enter name: "
		name = gets.chomp.rstrip
		@player = Player.new(name)
	end

	def set_opponent
		@opponent = Player.new('Opponent')
	end

	def deploy_opp_ships
		position = {}
		Ship::LENGTH.keys.each do |ship|
			valid = false
			while valid == false
				orientation = [:horizontal, :vertical].sample

				if orientation == :horizontal
					rows = Board::ROW
					columns = Board::COLUMN[0..9 - ship.length]
				else
					rows = Board::ROW[0..9 - ship.length]
					columns = Board::COLUMN
				end

				position[:row] = Board::ROW.rindex(rows.sample)
				position[:column] = Board::COLUMN.rindex(columns.sample)

				if @opponent.board.valid_coordinates?(ship, position, orientation) &&
					 @opponent.board.check_clearance?(ship, position, orientation)
					 valid = true
					 case ship
					 when :carrier
					 	@opponent.carrier.place_ship(@opponent.board, position, orientation)
					 when :battleship
					 	@opponent.battleship.place_ship(@opponent.board, position, orientation)
					 when :destroyer
					 	@opponent.destroyer.place_ship(@opponent.board, position, orientation)
					 when :submarine
					 	@opponent.submarine.place_ship(@opponent.board, position, orientation)
					 when :patrol
					 	@opponent.patrol.place_ship(@opponent.board, position, orientation)
					 end
				end
			end
		end
		@opponent.board.to_s
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
			if player.board.valid_coordinates?(ship.type, position, orientation) &&
				 player.board.check_clearance?(ship.type, position, orientation)
					ship.place_ship(player.board, position, orientation)
					valid = true
					player.board.to_s
			else
				puts "Invalid position for ship."
			end
		end
	end

end

if __FILE__ == $0
	game = Game.new
	game.set_opponent
	game.deploy_opp_ships
	# @player.board.to_s
end