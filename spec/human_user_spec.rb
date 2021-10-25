require './lib/human_user'
require './lib/game'


describe HumanUser do
  before(:each) do
    @default_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @width = 4
    @height = 4
    @game = Game.new([@height, @width],@default_ships)
  end

  it 'exists' do
    expect(@game.human_user).to be_a(HumanUser)
  end
  it 'has attributes' do
    expect(@game.human_user.board).to be_a(Board)
    expect(@game.human_user.ships).to be_a(Array)
    expect(@game.human_user.ships[0]).to be_a(Ship)
  end

end
