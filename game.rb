require_relative 'player'
require_relative 'board'

class Game

	attr_accessor :player, :opponent
	attr_reader :opp_targeting_queue

	def play
		puts "\nLet's play some Battleship!\n\n"
		set_player
		set_opponent
		puts "\nNow place your ships, #{@player.name}."
		deploy_ship(@player, @player.carrier)
		deploy_ship(@player, @player.battleship)
		deploy_ship(@player, @player.destroyer)
		deploy_ship(@player, @player.submarine)
		deploy_ship(@player, @player.patrol)
		deploy_opp_ships
		play_rounds
	end

	def set_player
		print "Enter name: "
		name = gets.chomp.rstrip
		@player = Player.new(name)
	end

	def set_opponent
		@opponent = Player.new('Opponent')
		@opp_targeting_queue = []
		Board::ROW.each do |row|
			Board::COLUMN.each do |column|
				@opp_targeting_queue << [row, column]
			end
		end
		@opp_targeting_queue.shuffle!
	end

	def deploy_ship(player, ship)
		valid = false
		while valid == false do
			print "\n"
			player.board.to_s			#printing board
			position = {}
			while valid == false do
				print "\n#{ship.type.capitalize} orientation: horizaontal(H) or vertical(V)? "
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
				print "\n#{ship.type.capitalize} starting position: "
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
					# print "\n"
					# player.board.to_s			#printing board
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
		puts "\n\nTime to sink some ships! Good luck, #{@player.name}\n\n"
		game_over = false
		while game_over == false
			@player.print_boards			#print board
			player_round
			if @opponent.ships_left == 0
				winner = @player.name
				game_over = true
				next
			end
			# @player.print_boards			#print board
			opponent_round
			if @player.ships_left == 0
				winner = "Opponent"
				game_over = true
			end
			# @player.print_boards			#print board
		end
		puts "\n\n#{winner} WINS!\n\n"
	end

	def player_round

		target = {}
		valid = false
		while valid == false
			print "\nYour turn. Target coordinates: "
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
			puts "\n\"MISS!\""
			@player.target_board.grid[target[:row]][target[:column]].miss
		else
			puts "\n\"HIT!\""
			@player.target_board.grid[target[:row]][target[:column]].hit
			case @opponent.board.grid[target[:row]][target[:column]].status
				when :carrier
					@opponent.carrier.hit
					if @opponent.carrier.sunk?
						@opponent.ships_left -= 1
						puts "Opponent's carrier sunk! #{@opponent.ships_left} more ships to go."
					end
				when :battleship
					@opponent.battleship.hit
					if @opponent.battleship.sunk?
						@opponent.ships_left -= 1
						puts "Opponent's battleship sunk!  #{@opponent.ships_left} more ships to go."
					end
				when :destroyer
					@opponent.destroyer.hit
					if @opponent.destroyer.sunk?
						@opponent.ships_left -= 1
						puts "Opponent's destroyer sunk!  #{@opponent.ships_left} more ships to go."
					end
				when :submarine
					@opponent.submarine.hit
					if @opponent.submarine.sunk?
						@opponent.ships_left -= 1
						puts "Opponent's submarine sunk!  #{@opponent.ships_left} more ships to go."
					end
				when :patrol
					@opponent.patrol.hit
					if @opponent.patrol.sunk?
						@opponent.ships_left -= 1
						puts "Opponent's patrol boat sunk!  #{@opponent.ships_left} more ships to go."
					end
			end
		end
	end

	def opponent_round
		puts "\n---------- Opponent's turn ----------"
		target_coords = opp_targeting_queue.pop
		target = {}

		target[:row] = Board::ROW.rindex(target_coords[0])
		target[:column] = Board::COLUMN.rindex(target_coords[1])

		print "\nOpponent called \"#{target_coords[0]} #{target_coords[1]}\" "
		if @player.board.grid[target[:row]][target[:column]].status == :open
			puts "- MISS!\n\n"
		else
			puts "- HIT!"
			case @player.board.grid[target[:row]][target[:column]].status
				when :carrier
					@player.carrier.hit
					if @player.carrier.sunk?
						@player.ships_left -= 1
						puts "\nYour carrier has been sunk!"
					else
						puts "\nYour carrier has been hit!"
					end
				when :battleship
					@player.battleship.hit
					if @player.battleship.sunk?
						@player.ships_left -= 1
						puts "\nYour battleship has been sunk!"
					else
						puts "\nYour battleship has been hit!"
					end
				when :destroyer
					@player.destroyer.hit

					if @player.destroyer.sunk?
						@player.ships_left -= 1
						puts "\nYour destroyer has been sunk!"
					else
						puts "\nYour destroyer has been hit!"
					end
				when :submarine
					@player.submarine.hit

					if @player.submarine.sunk?
						@player.ships_left -= 1
						puts "\nYour submarine has been sunk!"
					else
						puts "\nYour submarine has been hit!"
					end
				when :patrol
					@player.patrol.hit

					if @player.patrol.sunk?
						@player.ships_left -= 1
						puts "\nYour patrol boat has been sunk!"
					else
						puts "\nYour patrol boat has been hit!"
					end
			end
			@player.board.grid[target[:row]][target[:column]].hit
		end
		puts "-------------------------------------\n\n"
	end
end

if __FILE__ == $0
	game = Game.new
	# game.opponent_round
	# game.set_player
	game.play
	# game.set_opponent
	# game.deploy_opp_ships
	# game.play_rounds
	# @player.board.to_s
end