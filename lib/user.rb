require './lib/board'
require 'colorize' # gem install colorize in terminal if needed

class User

  attr_reader :board, :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end


  def setup_board(ai)
    if ai
      ai_setup_board
    else
      human_setup_board
    end
  end

  def ai_setup_board
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

  def human_setup_board
    loop = true
    message = nil
    puts "\nIf you want your ships randomly placed for you, please enter 'random'.".light_black.bold
    puts "\nOtherwise, press any key to manually place your ships.".light_black.bold
    choice = gets.chomp
    if choice == 'random'
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
    else
      unplaced_ships = @ships.map { |ship| ship}
      until loop == false
        if unplaced_ships.length == 0
          break
        end
        puts "\n"
        puts ("_" * 30).red.bold
        puts "SETUP YOUR BOARD: \n".red.bold
        puts @board.render(true)
        puts "AVAILABLE SHIPS:".yellow.bold
        unplaced_ships.each{|ship| puts " * #{ship.name}: #{ship.length}".yellow}
        puts message
        puts "\nPlease place one of the ships from the following listed on your board.".light_black.bold
        puts "Put 'finish' when you are done.".light_black.bold
        puts "Example: ShipName A1 A2 A3".light_black.italic
        print ' > '.magenta
        choice = gets.chomp

        if choice != 'finish'
          choice = choice.split(' ')
          ship_choice = unplaced_ships.find{|ship| ship.name == choice[0].to_s }
          coordinates = choice[1..].to_a
          coordinates = coordinates.find_all{|coordinate| @board.valid_coordinate?(coordinate)}
          if ship_choice.class == Ship && @board.valid_placement?(ship_choice, coordinates) && coordinates.length >= 2
            @board.place(ship_choice, coordinates)
            unplaced_ships.reject!{|ship| ship_choice.name == ship.name}
            message =  "Ship placed successfully!".green
          else
            message = "Invalid Input! Make sure the coordinates form a\nstraight line and don't overlap any other ships.".red
          end
          loop = true
        else
          break
        end
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

  def hunt(mode) #returns chosen cell coordinate
    if mode == "random"
      unfired_cells = self.board.cells.values.find_all {|cell| cell.fired_upon? == false}
      chosen_coordinate = unfired_cells.sample.coordinate
    elsif mode == "probability"
      self.update_possible_ships
      # find most highest # of ships
      max = @board.cells.values.map{|cell| cell.possible_ships}.max
      # gather all cells with this value
      possible_targets = @board.cells.values.find_all{|cell| cell.possible_ships == max}
      # randomly select from possible target
      chosen_coordinate = possible_targets.sample(1)[0].coordinate
    end
  end

  def update_possible_ships # this belongs in board
    # reset @possible_chip counter in all cells
    @board.cells.values.each{|cell| cell.possible_ships = 0}
    # loop through all cells
    @board.cells.values.each do |cell|
      # loops through all ships
      @ships.each do |ship|
        # generate all possible arrangements per ship per starting cell
        possible_placements = []
        valid_placements = []
        possible_placements << self.create_cell_array(cell.coordinate, ship.length, "up")
        possible_placements << self.create_cell_array(cell.coordinate, ship.length, "down")
        possible_placements << self.create_cell_array(cell.coordinate, ship.length, "left")
        possible_placements << self.create_cell_array(cell.coordinate, ship.length, "right")
        # check validity, return valid placements
        valid_placements = possible_placements.find_all{|placement| @board.valid_placement?(ship, placement)}
        # loop through each valid placement
        valid_placements.each do |valid_placement|
          # loop through each coordinate to gather each cell in the valid placement
          valid_placement.each do |coordinate|
            # get cell at coordiante and increase the possible_ships counter of that cell by one
            @board.cells[coordinate].possible_ships += 1
          end
        end
      end

    end

    # return nothing - board cells have been updated with new total probability

  end
end
