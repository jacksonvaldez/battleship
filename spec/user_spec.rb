require './lib/user'



describe User do

  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @width = 4
    @height = 4
    dimensions = [@width, @length]
    @steve = User.new(Board.new(@height, @width), @default_ships)
  end

  it 'exists' do
    expect(@steve).to be_a(User)
  end
  it 'has attributes' do
    expect(@steve.board).to be_a(Board)
    expect(@steve.ships).to be_a(Array)
    expect(@steve.ships[0]).to be_a(Ship)
    expect(@steve.ships).to eq(@default_ships)
    expect(@steve.board.width).to eq(@width)
    expect(@steve.board.height).to eq(@height)
  end

  describe '#hunt' do
    it 'returns coordinate for a cell under "random" mode.' do
      expect(@steve.hunt(@steve.board, @default_ships,"random")).to be_a(String)
      expect(@steve.board.cells[@steve.hunt(@steve.board, @default_ships,"random")]).to be_a(Cell)
    end
    it 'returns coordinate for a cell under "probability" mode.' do
      expect(@steve.hunt(@steve.board, @default_ships,"probability")).to be_a(String)
      expect(@steve.board.cells[@steve.hunt(@steve.board, @default_ships,"probability")]).to be_a(Cell)
    end
    it 'returns a coordinate that has not been fired upon' do
      cells = @steve.board.cells.values
      safe_cell = cells.pop
      cells.each{|cell| cell.fire_upon}
      expect(@steve.hunt(@steve.board, @default_ships,"probability")).to eq(safe_cell.coordinate)
    end
  end

  describe '#target' do
    it 'returns coordinate for a cell.' do
      expect(@steve.target(@steve.board, @default_ships)).to eq(nil)
      @steve.board.place(@default_ships[1], ['D3', 'D4'])
      @steve.board.cells['D3'].fire_upon
      expect(@steve.target(@steve.board, @default_ships)).to be_a(String)
      expect(@steve.board.cells[@steve.target(@steve.board, @default_ships)]).to be_a(Cell)
    end
    it 'returns a coordinate that has not been fired upon and is on the board' do
      @steve.board.place(@default_ships[1], ['D3', 'D4'])
      cells = @steve.board.cells.values
      safe_cell = cells.pop
      cells.each{|cell| cell.fire_upon}
      expect(@steve.target(@steve.board, @default_ships)).to eq(safe_cell.coordinate)
    end
  end

  describe ' #setup_board(ai)' do
    it 'places all ships' do
      @steve.setup_board(true)
      expect(@steve.board.cells.values.find_all{|cell| cell.empty?}.length).to eq(16 - 5)
    end
    it 'returns nil if setup failed' do
      @bad_steve = User.new(Board.new(2, 2), @default_ships)
      @bad_steve.setup_board(true)
      expect(@bad_steve.board).to eq(nil)
    end
  end

  describe ' #create_cell_array' do
    it 'creates coordinates in up direction' do
      expect(@steve.create_cell_array("C3", 3, "up")).to eq(["C3", "B3", "A3"])
    end
    it 'creates coordinates in down direction' do
      expect(@steve.create_cell_array("C3", 3, "down")).to eq(["C3", "D3", "E3"])
    end
    it 'creates coordinates in left direction' do
      expect(@steve.create_cell_array("C3", 3, "left")).to eq(["C3", "C2", "C1"])
    end
    it 'creates coordinates in right direction' do
      expect(@steve.create_cell_array("C3", 3, "right")).to eq(["C3", "C4", "C5"])
    end
  end

  describe 'update_possible_ships' do
    it 'returns the count of all possible ships placements per cell' do
      expect(@steve.board.cells.values.map { |cell| cell.possible_ships}.sum).to eq(0)
      @steve.update_possible_ships(@steve.board, @default_ships)
      expect(@steve.board.cells.values.map { |cell| cell.possible_ships}.sum).to eq(96)
    end
    it 'updates probability map correctly under "probability" mode' do
      expect(@steve.board.render_probability_map).to eq("  1 2 3 4 \n              \nA 0 0 0 0 \nB 0 0 0 0 \nC 0 0 0 0 \nD 0 0 0 0 \n")
      @steve.update_possible_ships(@steve.board, @default_ships)
      expect(@steve.board.render_probability_map).to eq("  1 2 3 4 \n              \nA 4 6 6 4 \nB 6 8 8 6 \nC 6 8 8 6 \nD 4 6 6 4 \n")
      @steve.board.place(@default_ships[0], ['B1', 'B2', 'B3'])
      @steve.update_possible_ships(@steve.board, @default_ships)
      expect(@steve.board.render_probability_map).to eq("  1 2 3 4 \n              \nA 4 6 6 4 \nB 6 8 8 6 \nC 6 8 8 6 \nD 4 6 6 4 \n")
      @steve.board.cells['B2'].fire_upon
      expect(@steve.board.render_probability_map).to eq("  1 2 3 4 \n              \nA 4 6 6 4 \nB 6 8 8 6 \nC 6 8 8 6 \nD 4 6 6 4 \n")
      @steve.board.cells['C2'].fire_upon
      expect(@steve.board.render_probability_map).to eq("  1 2 3 4 \n              \nA 4 6 6 4 \nB 6 8 8 6 \nC 6 8 8 6 \nD 4 6 6 4 \n")
    end
  end
end
