require './lib/board'
require 'colorize' # gem install colorize in terminal if needed


class Game
  #initialzie
  attr_reader :turn_counter,
              :ships_ai,
              :ships_user,
              :board_ai,
              :board_user


  def initialize(dimensions, ships)
    @turn_counter = 0
    @ships_ai = ships
    @ships_user = ships
    @board_ai = Board.new(dimensions[0], dimensions[1])
    @board_user = Board.new(dimensions[0], dimensions[1])
  end

  def place_ships(ships)
    #ask for locations for each ship
  end

  def take_turn(coordinate)

  end

  def end_game

  end
end
