require_relative '../../lib/battleship/board'

describe Board do
	before do
		@board = Board.new
	end

	it "should create a game board" do
		@board.class.should == Board
	end
	it "cell should be Grid class" do
		@board.grid[5][5].class.should == Grid_Cell
	end
end