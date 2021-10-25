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

  describe '#self.starter_message' do
    it 'returns the correct starter message' do
      expect(Game.starter_message).to eq(["", "", "", "", "", "\e[0;33;49m-----------------\e[0m \e[0;34;49mWelcome To Battleship! \e[0m\e[0;33;49m-----------------\e[0m", "", "                                  )___(", "                           _______/__/_", "                  ___     /===========|   ___", " ____       __   [\\\\\\]___/____________|__[///]   __", " \\   \\_____[\\\\]__/___________________________\\__[//]___", "  \\40A                                                 |", "   \\__________________________________________________/", "", "", "Battleship is a strategy type guessing game for two players.", "It is played on ruled grids on which each player's fleet of", "ships are marked. The locations of the fleets are concealed", "from the other player. You are going to be paying against a", "computer named Steve!", "", "\e[0;33;49m----------------------------------------------------------\e[0m"])
    end
  end
end
