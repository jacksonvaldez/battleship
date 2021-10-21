require './lib/board'

describe '#everything_same?' do
  it 'returns true if the array given has elements that are all equal to each other' do
    expect(everything_same?([1, 1, 1, 1, 1])).to eq(true)
    expect(everything_same?(['A', 'A', 'A', 'A'])).to eq(true)
  end
  it 'returns false if the array given has elements that are not all equal to each other' do
    expect(everything_same?([1, 2, 3, 4, 5])).to eq(false)
    expect(everything_same?(['A', 'B', 'C', 'D'])).to eq(false)
  end
end


describe '#is_sequential?' do
  it 'returns true if the array given is in sequential' do
    expect(is_sequential?([5, 8, 6, 7])).to eq(true)
    expect(is_sequential?(['D', 'C', 'B'])).to eq(true)
  end
  it 'returns false if the array given is not in sequential' do
    expect(is_sequential?([5, 8, 6, 7, 10])).to eq(false)
    expect(is_sequential?(['D', 'C', 'B', 'Z'])).to eq(false)
  end
end


describe Board do
  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
    @sub = Ship.new('Submarine', 2)
    @board = Board.new(3, 5)
  end


  describe '#initialize' do
    it 'has attributes' do
      expect(@board.height).to eq(5)
      expect(@board.width).to eq(3)
      expect(@board.cells).to be_a(Hash)
    end
    it '@board.cells has correct # of items' do
      expect(@board.cells.keys.length).to eq(15) # length * width (In this case 5 * 3)
    end
    it 'cell_coordinates initializes will correct cell coordinates' do
      expect(@board.cells.keys).to eq(%w[A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 E1 E2 E3])
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


  describe '#valid_placement?' do
    it 'returns true if placement is valid' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2', 'A3'])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ['D1', 'C1', 'B1'])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ['B3', 'B1', 'B2'])).to eq(true)
    end
    it 'returns false if placement is invalid' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B1", "C2"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A1", "B1", "D1"])).to eq(false)
    end
  end


  describe ' #place' do
    it 'places a ship in the right cells if placement is valid' do
      @board.place(@cruiser,["A1", "B1", "C2"])
      expect(@board.cells["A1"].empty?).to eq(true)
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      expect(@board.cells["A1"].empty?).to eq(false)
      expect(@board.cells["A2"].empty?).to eq(false)
      expect(@board.cells["A3"].empty?).to eq(false)
    end
    it 'places the correct ship' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      expect(@board.cells["A1"].ship).to eq(@cruiser)
    end
  end


  describe ' #cells' do
    it 'returns nil if cell is not on board' do
      expect(@board.cells["Z1"]).to eq(nil)
    end
    it 'returns the correct cell' do
      expect(@board.cells["A1"].coordinate).to eq("A1")
    end
  end


  describe ' #render' do
    it 'returns correct string' do
      expect(@board.render).to be_a(String)
    end
    it 'returns correct string' do
      expect(@board.render).to eq("  1 2 3 \nA . . . \nB . . . \nC . . . \nD . . . \nE . . . \n")
    end
    it 'prints a board with a ship' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.render(true)).to eq("  1 2 3 \nA S S S \nB . . . \nC . . . \nD . . . \nE . . . \n")
      @board.place(@sub, ["B2", "C2"])
      expect(@board.render(true)).to eq("  1 2 3 \nA S S S \nB . S . \nC . S . \nD . . . \nE . . . \n")
      expect(@board.render).to eq("  1 2 3 \nA . . . \nB . . . \nC . . . \nD . . . \nE . . . \n")
    end

    it 'renders correct board of different shape' do
      board2 = Board.new(4, 5)
      board2.place(@cruiser, ["A1", "A2", "A3"])
      expect(board2.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \nE . . . . \n")
      board2.place(@sub, ["B2", "C2"])
      expect(board2.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . S . . \nC . S . . \nD . . . . \nE . . . . \n")
      expect(board2.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \nE . . . . \n")
    end


  end

end
