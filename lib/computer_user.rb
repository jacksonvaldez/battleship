require './lib/board'
require 'colorize' # gem install colorize in terminal if needed

class ComputerUser

  attr_reader :board, :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end




  def setup_board
    failed = false
    @ships.each do |ship|
      # randomly choose placement
      chosen_placement = random_placement(ship)
      #place ship
      if !(chosen_placement == nil)
        @board.place(ship,chosen_placement)
      else
        return @board = nil
      end
    end
  end

  def random_placement(ship)
    # randomly choose starting cell.
    # Generate 4 possible cell arrays based on ship length
    # Check validity. Randomly choose one that works.
    # Keep looping until valid placement found
    chosen_placement = nil
    possible_placements = []
    valid_placements = []
    # first, check that ship can fit.
    # If not, reset
    while chosen_placement == nil do
      if !@board.fits?(ship.length)
        return nil
      end
      start_cell = @board.cells.values.sample
      possible_placements << self.create_cell_array(start_cell.coordinate, ship.length, "up")
      possible_placements << self.create_cell_array(start_cell.coordinate, ship.length, "down")
      possible_placements << self.create_cell_array(start_cell.coordinate, ship.length, "left")
      possible_placements << self.create_cell_array(start_cell.coordinate, ship.length, "right")
      valid_placements = possible_placements.find_all{|placement| @board.valid_placement?(ship, placement)}
      chosen_placement = valid_placements.sample
    end
    chosen_placement
  end

  def create_cell_array(coordinate, length, direction)
    alphabet = ('A'..'Z').to_a
    start_letter = coordinate[0]
    start_num = coordinate[1..2]
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

end
