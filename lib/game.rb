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
        chosen_placement = nil
        possible_placements = []
        while chosen_placement == nil do
          start_cell = board.cells.values.sample
          possible_placements << create_cell_array(start_cell.coordinate, ship.length, "up")
          possible_placements << create_cell_array(start_cell.coordinate, ship.length, "down")
          possible_placements << create_cell_array(start_cell.coordinate, ship.length, "left")
          possible_placements << create_cell_array(start_cell.coordinate, ship.length, "right")
          valid_placements = possible_placements.find_all{|placement| board.valid_placement?(ship, placement)}
          chosen_placement = valid_placements.sample(1)
        end
        #place ship
        board.place(ship,chosen_placement)
      end
    end
  end

  def create_cell_array(coordinate, length, direction)
    alphabet = ('A'..'Z').to_a
    start_letter = coordinate[0]
    start_num = coordinate[1]
    new_coordinates = []


    if direction == "up"
      # create array that decreases in letters but has same number
      start_index = start_letter.ord
      end_index = start_index - (length - 1)
      # create ord number array, convert to characters, append column #, then reverse.
      # create array doesn't work (large..small) so we do (small..large) then reverse.
      new_coordinates = (end_index..start_index).to_a.map { |x| x.chr + "#{start_num}" }.reverse
    elsif direction == "down"
      # create array that increases in letters but has same number
      start_index = start_letter.ord
      end_index = start_index + (length - 1)
      # create ord number array, convert to characters, append column #.
      new_coordinates = (start_index..end_index).to_a.map { |x| x.chr + "#{start_num}" }
    elsif direction == "left"
      # create array with same letter that decreases in number
      start_index = start_num.to_i
      end_index = start_index - (length - 1)
      # create number array, convert to string, prepend column letter, then reverse.
      # create array doesn't work (large..small) so we do (small..large) then reverse.
      new_coordinates = (end_index..start_index).to_a.map { |x| "#{start_letter}" + x.to_s}.reverse
    elsif direction == "right"
      # create array with same letter that increases in number
      start_index = start_num.to_i
      end_index = start_index + (length - 1)
      # create number array, convert to string, prepend column letter.
      new_coordinates = (start_index..end_index).to_a.map { |x| "#{start_letter}" + x.to_s}
    else
      []
    end
  end

  def take_turn(coordinate)

  end

  def end_game

  end
end
