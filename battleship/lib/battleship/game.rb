require_relative 'player'
require_relative 'board'

class Game

	attr_reader :opp_targeting_queue

	FLEET = [:carrier, :battleship, :destroyer, :submarine, :patrol_boat]

	def play
		puts "\nLet's play some Battleship!\n\n"
		set_player
		set_opponent
		puts "\nNow place your ships, #{@player.name}."
		FLEET.each {|ship| deploy_ship(@player, ship)}
		FLEET.each {|ship| deploy_opp_ship(@opponent, ship)}
		play_rounds
	end

	def set_player
		name = ''
		while name.empty? do
			print "Enter name: "
			name = gets.chomp.rstrip
			@player = Player.new(name)
		end
	end

	def set_opponent
		@opponent = Player.new('Opponent')
		@opp_targeting_queue = []
		Board::ROW.each do |row|
			Board::COLUMN.each do |column|
				@opp_targeting_queue << [row, column]
			end
		end
		@opp_targeting_queue.shuffle!   #queue of random ooponent shot coordinates
	end

	def deploy_ship(player, ship)

		#prompt for placement orientation and validate input
		valid = false
		while valid == false do
			print "\n"
			player.board.to_s			#print board for reference
			position = {}
			while valid == false do
				print "\n#{ship.capitalize} orientation: horizontal(H) or vertical(V)? "
				input = gets.chomp.rstrip.upcase
				if input == 'H' || input == 'HORIZONTAL'
					orientation = :horizontal
					valid = true
				elsif input == 'V' || input == 'VERTICAL'
					orientation = :vertical
					valid = true
				else
					puts "Invalid orientation entry."
				end
			end

			#prompt for placement starting position and validate input
			valid = false
			while valid == false do
				print "\n#{ship.capitalize} starting position (Ex. A10): "
				input = gets.chomp.rstrip.upcase
				position[:row] = Board::ROW.rindex(input.split(//, 2)[0])
				position[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
				if !position[:row].nil? && !position[:column].nil?
					valid = true
				else
					puts "Invalid coordinates."
				end
			end

			#validate board clearances for given orientation and position
			valid = false
			if player.board.valid_coordinates?(player.send(ship), position, orientation) &&
				 player.board.check_clearance?(player.send(ship), position, orientation)
					 player.board.place_ship(player.send(ship), position, orientation)
					 valid = true
			else
				puts "Invalid position for ship."
			end
		end
	end

	#randomly place opponent's ships
	def deploy_opp_ship(opponent, ship)
		position = {}
		valid = false
		while valid == false
			orientation = [:horizontal, :vertical].sample
			if orientation == :horizontal
				rows = Board::ROW
				columns = Board::COLUMN[0..9 - opponent.send(ship).length]
			else
				rows = Board::ROW[0..9 - opponent.send(ship).length]
				columns = Board::COLUMN
			end

			position[:row] = Board::ROW.rindex(rows.sample)
			position[:column] = Board::COLUMN.rindex(columns.sample)

			if opponent.board.valid_coordinates?(opponent.send(ship), position, orientation) &&
				 opponent.board.check_clearance?(opponent.send(ship), position, orientation)
				 valid = true
				 opponent.board.place_ship(opponent.send(ship), position, orientation)
			end
		end
	end

	#alternate rounds between player and opponent, determine if game won
	def play_rounds
		puts "\n\nTime to sink some ships! Good luck, #{@player.name}\n\n"
		game_over = false
		while game_over == false
			@player.print_boards
			player_round
			if @opponent.ships_left == 0
				winner = @player.name
				game_over = true
				next
			end

			opponent_round
			if @player.ships_left == 0
				winner = "Opponent"
				game_over = true
			end
		end
		puts "\n\n#{winner} WINS!\n\n"
	end

	#prompt player for shot coordinates, validate, assess hit or miss
	def player_round
		target = {}
		valid = false
		while valid == false
			print "\nYour turn. Target coordinates: "
			input = gets.chomp.rstrip.upcase
			target[:row] = Board::ROW.rindex(input.split(//, 2)[0])
			target[:column] = Board::COLUMN.rindex(input.split(//, 2)[1])
			player_cell = @player.target_board.grid[target[:row]][target[:column]]
			if target[:row].nil? || target[:column].nil?
				puts "Invalid coordinates."
			elsif player_cell.status != :open
				puts "Coordinates already called. Try again."
			else
				valid = true
			end
		end

		opponent_cell = @opponent.board.grid[target[:row]][target[:column]]

		if opponent_cell.status == :open
			puts "\n\"MISS!\""
			player_cell.miss
		else
			puts "\n\"HIT!\""
			player_cell.hit
			opponent_cell.ship.hit
			opponent_cell.hit

			if opponent_cell.ship.sunk?
				@opponent.ships_left -= 1
				puts "Opponent's #{opponent_cell.ship.class.to_s.downcase} sunk! #{@opponent.ships_left} more ships to go."
			end
		end
	end

	#opponent takes shot from queue, assess hit or miss
	def opponent_round
		puts "\n---------- Opponent's turn ----------"
		target_coords = opp_targeting_queue.pop
		target = {}

		target[:row] = Board::ROW.rindex(target_coords[0])
		target[:column] = Board::COLUMN.rindex(target_coords[1])

		player_cell = @player.board.grid[target[:row]][target[:column]]

		print "\nOpponent called \"#{target_coords[0]}#{target_coords[1]}\" "
		if @player.board.grid[target[:row]][target[:column]].status == :open
			puts "- MISS!\n\n"
		else
			puts "- HIT!"
			player_cell.hit
			player_cell.ship.hit
			if player_cell.ship.sunk?
				puts "\nYour #{player_cell.ship.class.to_s.downcase} has been sunk!"
			else
				puts "\nYour #{player_cell.ship.class.to_s.downcase} has been hit!"
			end
		end
		puts "-------------------------------------\n\n"
	end

end

if __FILE__ == $0
	g = Game.new
	g.play
	# p = Player.new('David')
	# o = Player.new('Opponent')
	# g.deploy_opp_ship(o, :carrier)
	# puts o.board
end
