require './player'
require './board'

class Game

	attr_accessor :player, :opponent

	def play
		puts "Let's play some Battleship!\n"
		set_player
		set_opponent
		deploy_ship(@player, @player.carrier)
		deploy_ship(@player, @player.battleship)
		deploy_ship(@player, @player.destroyer)
		deploy_ship(@player, @player.submarine)
		deploy_ship(@player, @player.patrol)
		deploy_opp_ships
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
				if !position[:row].nil? && !position[:column].nil?
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

	def play_rounds
		puts "\nTime to sink some ships!"
		game_over = false
		while game_over == false
			player_round
			if @opponent.ships_left == 0
				winner = @player.name
				game_over = true
			end
			# opponent_round
			# if @opponent.ships_left == 0
			# 	winner = "Opponent"
			# 	game_over = true
			# end
		end
		puts "#{winner} wins!"
		return winner
	end

	def player_round

		target = {}
		valid = false
		while valid == false
			print "Target coordinates: "
			input = gets.chomp.rstrip.upcase
			target[:row] = Board::ROW.rindex(input.split(//, 2)[0])
			target[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
			if !target[:row].nil? && !target[:column].nil?
				 valid = true
			else
				puts "Invalid coordinates."
			end
		end

		if @opponent.board.grid[target[:row]][target[:column]].status == :open
			puts "Miss!"
			@player.target_board.grid[target[:row]][target[:column]].miss
		else
			puts "Hit!"
			case @opponent.board.grid[target[:row]][target[:column]].status
				when :carrier
					@opponent.carrier.hit
					if @opponent.carrier.sunk?
						@opponent.ships_left -= 1
						puts "Opponent carrier sunk! #{@opponent.ships_left} more to go."
					end
				when :battleship
					@opponent.battleship.hit
					if @opponent.battleship.sunk?
						@opponent.ships_left -= 1
						puts "Opponent battleship sunk!  #{@opponent.ships_left} more to go."
					end
				when :destroyer
					@opponent.destroyer.hit
					if @opponent.destroyer.sunk?
						@opponent.ships_left -= 1
						puts "Opponent destroyer sunk!  #{@opponent.ships_left} more to go."
					end
				when :submarine
					@opponent.submarine.hit
					if @opponent.submarine.sunk?
						@opponent.ships_left -= 1
						puts "Opponent submarine sunk!  #{@opponent.ships_left} more to go."
					end
				when :patrol
					@opponent.patrol.hit
					if @opponent.patrol.sunk?
						@opponent.ships_left -= 1
						puts "Opponent patrol boat sunk!  #{@opponent.ships_left} more to go."
					end
			end
			@player.target_board.grid[target[:row]][target[:column]].hit

		end
		@player.target_board.to_s
	end

	def opponent_round

	end

end

if __FILE__ == $0
	game = Game.new
	game.set_player
	# game.play
	game.set_opponent
	game.deploy_opp_ships
	game.play_rounds
	# @player.board.to_s
end