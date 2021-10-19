require './lib/board'

describe Board do

  before(:each) do
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

    it 'returns a boolean' do
      expect(@board.valid_coordinate?('B3')).to be_a(TrueClass || FalseClass)
    end

    it 'returns true if coordinate is valid' do
      expect(@board.valid_coordinate?('B3')).to eq(true)
    end

    it 'returns false if coordinate is invalid' do
      expect(@board.valid_coordinate?('J3')).to eq(false)
    end


  end



end
