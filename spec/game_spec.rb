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

  describe ' #starter_message' do

  end

end
