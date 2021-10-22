require './lib/game'

describe Game do
  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @width = 4
    @height = 4
    @game = Game.new([@width, @height],@default_ships)
  end

  it 'exists' do
    expect(@game).to be_a(Game)
  end
  it 'has attributes' do
    expect(@game.turn_counter).to eq(0)
    expect(@game.ships_ai).to eq(@default_ships)
    expect(@game.ships_user).to eq(@default_ships)
    expect(@game.board_ai).to be_a(Board)
    expect(@game.board_user).to be_a(Board)
    expect(@game.board_ai.width).to eq(@width)
    expect(@game.board_ai.height).to eq(@height)
    expect(@game.board_user.width).to eq(@width)
    expect(@game.board_user.height).to eq(@height)
  end

  describe ' #place_ship' do
    it 'places all ships' do
      @game.place_ships(@game.board_ai, @game.ships_ai, true)
      expect(@game.board_ai.cells.values.find_all{|cell| cell.is_empty?}.length).to be < (@game.board_ai.cells.values)
    end
  end

  describe ' #create_cell_array' do
    it 'creates coordinates in up direction' do
      expect(@game.create_cell_array("C3", 3, "up")).to eq(["C3", "B3", "A3"])
    end
    it 'creates coordinates in down direction' do
      expect(@game.create_cell_array("C3", 3, "down")).to eq(["C3", "D3", "E3"])
    end
    it 'creates coordinates in left direction' do
      expect(@game.create_cell_array("C3", 3, "left")).to eq(["C3", "C2", "C1"])
    end
    it 'creates coordinates in right direction' do
      expect(@game.create_cell_array("C3", 3, "right")).to eq(["C3", "C4", "C5"])
    end
  end

end
