require './lib/computer_user'



describe ComputerUser do

  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @width = 4
    @height = 4
    @game = Game.new([@width, @height],@default_ships)
  end

  # add init test
  # add setup_board test


  describe ' #create_cell_array' do
    it 'creates coordinates in up direction' do
      expect(@game.computer_user.create_cell_array("C3", 3, "up")).to eq(["C3", "B3", "A3"])
    end
    it 'creates coordinates in down direction' do
      expect(@game.computer_user.create_cell_array("C3", 3, "down")).to eq(["C3", "D3", "E3"])
    end
    it 'creates coordinates in left direction' do
      expect(@game.computer_user.create_cell_array("C3", 3, "left")).to eq(["C3", "C2", "C1"])
    end
    it 'creates coordinates in right direction' do
      expect(@game.computer_user.create_cell_array("C3", 3, "right")).to eq(["C3", "C4", "C5"])
    end
  end

end
