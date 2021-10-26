require './lib/board'



describe Board do
  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
    @sub = Ship.new('Submarine', 2)
    @board = Board.new(5, 3)
  end


  describe '#initialize' do
    it 'has attributes' do
      expect(@board.height).to eq(3)
      expect(@board.width).to eq(5)
      expect(@board.cells).to be_a(Hash)
    end
    it '@board.cells has correct # of items' do
      expect(@board.cells.keys.length).to eq(15) # length * width (In this case 5 * 3)
    end
    it 'cell_coordinates initializes will correct cell coordinates' do
      expect(@board.cells.keys).to eq(%w[A1 A2 A3 A4 A5 B1 B2 B3 B4 B5 C1 C2 C3 C4 C5])
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
      expect(@board.valid_placement?(@cruiser, ['A1', 'C1', 'B1'])).to eq(true)
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

  describe ' #render' do
    it 'returns correct string' do
      expect(@board.render).to be_a(String)
    end
    it 'returns correct string' do
      expect(@board.render).to eq("  1 2 3 4 5 \n               \nA . . . . . \nB . . . . . \nC . . . . . \n")
    end
    it 'prints a board with a ship' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.render(true)).to eq("  1 2 3 4 5 \n               \nA \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m . . \nB . . . . . \nC . . . . . \n")
      @board.place(@sub, ["B2", "C2"])
      expect(@board.render(true)).to eq("  1 2 3 4 5 \n               \nA \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m . . \nB . \e[1;32;49mS\e[0m . . . \nC . \e[1;32;49mS\e[0m . . . \n")
      expect(@board.render).to eq("  1 2 3 4 5 \n               \nA . . . . . \nB . . . . . \nC . . . . . \n")
    end

    it 'renders correct board of different shape' do
      board2 = Board.new(5, 4)
      board2.place(@cruiser, ["A1", "A2", "A3"])
      expect(board2.render(true)).to eq("  1 2 3 4 5 \n               \nA \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m . . \nB . . . . . \nC . . . . . \nD . . . . . \n")
      board2.place(@sub, ["B2", "C2"])
      expect(board2.render(true)).to eq("  1 2 3 4 5 \n               \nA \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m \e[1;32;49mS\e[0m . . \nB . \e[1;32;49mS\e[0m . . . \nC . \e[1;32;49mS\e[0m . . . \nD . . . . . \n")
      expect(board2.render).to eq("  1 2 3 4 5 \n               \nA . . . . . \nB . . . . . \nC . . . . . \nD . . . . . \n")
    end


  end

  describe ' #render_probability_map' do
    it 'returns correct string' do
      expect(@board.render_probability_map).to be_a(String)
    end
    it 'returns correct string' do
      expect(@board.render_probability_map).to eq("  1 2 3 4 5 \n               \nA 0 0 0 0 0 \nB 0 0 0 0 0 \nC 0 0 0 0 0 \n")
    end
  end

  describe ' #fits?' do
    it 'returns true if ship fits' do
      board1 = Board.new(3,3)
      expect(board1.fits?(3)).to eq(true)
    end
    it 'returns false if ship does not fit' do
      board2 = Board.new(2,2)
      expect(board2.fits?(3)).to eq(false)
    end
  end

end
