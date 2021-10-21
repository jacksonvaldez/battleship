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

    it 'cell_coordinates initializes will correct cell coordinates' do
      expect(@board.cell_coordinates).to eq(%w[A1 B1 C1 D1 E1 A2 B2 C2 D2 E2 A3 B3 C3 D3 E3])
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
      expect(@board.cells[@board.cells.index("A1")].empty?).to eq(true)
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      expect(@board.cells[@board.cells.index("A1")].empty?).to eq(false)
      expect(@board.cells[@board.cells.index("A2")].empty?).to eq(false)
      expect(@board.cells[@board.cells.index("A3")].empty?).to eq(false)
    end
    it 'places the correct ship' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      expect(@board.cells[@board.cells.index("A1")].ship).to eq(@cruiser)
    end
  end
end
