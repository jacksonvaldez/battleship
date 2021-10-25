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
    expect(@game.computer_user).to be_a(ComputerUser)
    expect(@game.human_user).to be_a(HumanUser)
  end

end
