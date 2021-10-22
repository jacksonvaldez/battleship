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

  def place_ships(board, ships, ai)
    if ai #this trigger computer placement
      ships.each do |ship|
        # randomly choose starting cell.
        # Generate 4 possible cell arrays based on ship length
        # Check validity. Randomly choose one that works.
        # Keep looping until valid placement found
        start_cell = board.cells.sample
        possible_placements << create_cell_array(start_cell, ship.length, 0)
        possible_placements << create_cell_array(start_cell, ship.length, 1)
        possible_placements << create_cell_array(start_cell, ship.length, 2)
        possible_placements << create_cell_array(start_cell, ship.length, 3)
      end
    end
  end

  def create_cell_array(coordinate, length, direction)
    start_letter = start_cell.coordinate[0]
    start_num = start_cell.coordinate[1]
    cells_up = [coordinate]
    cells_right = [coordinate]
    cells_down =[coordinate]
    cells_left = [coordinate]
    ship.length.times do
      cells_up << "I'm tired"
    end
  end

  def take_turn(coordinate)

  end

  def end_game

  end
end
