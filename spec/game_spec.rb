require './lib/game'

describe Game do
  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @game = Game.new(4,4, @default_ships)
  end

  it 'exists with input values' do
    expect(@game).to be_a(Game)
  end
  it 'has attributes' do
    expect(@game.ships_ai).to eq(@default_ships)
    expect(@game.ships_user).to eq(@default_ships)
    expect(@game.ships_ai).to eq(@default_ships)
    expect(@game.ships_user).to eq(@default_ships)
    expect(@game.turn_counter).to eq(0)
  end



end
