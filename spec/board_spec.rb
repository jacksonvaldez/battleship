require './lib/board'

describe Board do

  before(:each) do
    @ship = Ship.new('Cruiser', 3)
    @cell = Cell.new('C3')
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


  # describe '#valid_coordinate?' do
  #
  #   it 'returns true if coordinate is valid' do
  #
  #   end
  #
  #   it 'returns false if coordinate is invalid' do
  #
  #   end
  #
  #
  # end



end
