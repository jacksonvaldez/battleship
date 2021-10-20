require './lib/board'

describe Board do

  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
    @board = Board.new(5, 3)
  end




  describe '#initialize' do
    it 'has dimensions' do
      expect(@board.height).to eq(5)
      expect(@board.width).to eq(3)
    end

    it 'has correct array length for @board.cells' do
      expect(@board.cells.length).to eq(15) # length * width (In this case 5 * 3)
    end
  end


  describe '#valid_coordinate?' do
    it 'returns true if coordinate is valid' do
      expect(@board.valid_coordinate?('B3')).to eq(true)
    end

    it 'returns false if coordinate is invalid' do
      expect(@board.valid_coordinate?('J3')).to eq(false)
    end
  end


  describe '#everything_same?' do
    it 'returns true if the array given has elements that are all equal to each other' do
      expect(@board.everything_same?([1, 1, 1, 1, 1])).to eq(true)
      expect(@board.everything_same?(['A', 'A', 'A', 'A'])).to eq(true)
    end
    it 'returns false if the array given has elements that are not all equal to each other' do
      expect(@board.everything_same?([1, 2, 3, 4, 5])).to eq(false)
      expect(@board.everything_same?(['A', 'B', 'C', 'D'])).to eq(false)
    end
  end



  describe '#valid_placement?' do
    # it 'returns true if placement is valid' do
    #   expect(@board.valid_placement?(@cruiser, ['A1', 'A2', 'A3'])).to eq(true)
    # end
    #
    # it 'returns false if placement is invalid' do
    #   expect(@board.valid_placement?(@cruiser, ["C3", "B2", "C3"])).to eq(false)
    # end


  end



end
