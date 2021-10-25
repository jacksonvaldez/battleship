require './lib/computer_user'



describe ComputerUser do

  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @width = 4
    @height = 4
    @game = Game.new([@width, @height],@default_ships)
    @steve = ComputerUser.new(Board.new([@width, @length]), @default_ships)
  end

  it 'exists' do
    expect(@steve).to be_a(ComputerUser)
  end
  it 'has attributes' do
    expect(@steve.ships).to eq(@default_ships)
    expect(@steve.board).to be_a(Board)
    expect(@steve.board.width).to eq(@width)
    expect(@steve.board.height).to eq(@height)
  end

  describe ' #setup_board' do
    it 'places all ships' do
      @steve.setup_board
      expect(@steve.board.cells.values.find_all{|cell| cell.empty?}.length).to eq(11)
    end
  end

  describe ' #create_cell_array' do
    it 'creates coordinates in up direction' do
      expect(@steve.computer_user.create_cell_array("C3", 3, "up")).to eq(["C3", "B3", "A3"])
    end
    it 'creates coordinates in down direction' do
      expect(@steve.computer_user.create_cell_array("C3", 3, "down")).to eq(["C3", "D3", "E3"])
    end
    it 'creates coordinates in left direction' do
      expect(@steve.computer_user.create_cell_array("C3", 3, "left")).to eq(["C3", "C2", "C1"])
    end
    it 'creates coordinates in right direction' do
      expect(@steve.computer_user.create_cell_array("C3", 3, "right")).to eq(["C3", "C4", "C5"])
    end
  end

end
