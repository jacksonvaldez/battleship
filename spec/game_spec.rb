require './lib/game'

describe Game do
  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @game = Game.new()
  end

  it 'exists' do
    expect(@game).to be_a(Game)
  end
  it 'has attributes' do
    expect(@game.turn_counter).to eq(0)
  end

  describe ' #starter_message' do

  end

end
