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

end
