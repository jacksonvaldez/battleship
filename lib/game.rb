require './lib/board'
require './lib/computer_user'
require './lib/human_user'
require 'colorize' # gem install colorize in terminal if needed


class Game
  #initialzie
  attr_reader :turn_counter, :computer_user#, :human_user
  attr_accessor :human_user


  def initialize(dimensions, ships)
    @computer_user = ComputerUser.new(Board.new(dimensions[0], dimensions[1]), ships)
    @human_user = HumanUser.new(Board.new(dimensions[0], dimensions[1]), ships)
    @turn_counter = 0
  end



  def self.start_game

    # Each stage has its own method. If a stage returns false, that means don't move onto the next stage.


    # STAGE 1: Game prints the starter message to the terminal. Returns starter message string
    puts self.starter_message

    # STAGE 2: Game asks the user if they want to continue. If they do, it prompts them asking for ships and custom board dimensions.
    # If the setup is successful, it will return a game object. If not, it will return nil
    game = self.setup
    if game.class != Game
      return nil
    end

    # STAGE 3: Game asks the user and Steve to setup their boards
    game.setup_boards
    if (game.computer_user.board == nil) || (game.human_user.board == nil)
      game.end_game
    end

    # STAGE 4: Game asks the user and Steve to take turns back and forth until someone has no more ships
    game.alternate_turns

    # STAGE 5: Game ends itself and announces the winner
    game.end_game



  end



  def setup_boards
    @computer_user.setup_board
    @human_user.setup_board
  end



  def alternate_turns
    message_1 = nil
    message_2 = nil
    until @computer_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0 || @human_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0
      if @turn_counter.even? || @turn_counter == 0 # If its the players turn
        puts "\nSTEVE'S BOARD:".red.bold
        puts @computer_user.board.render(false)
        puts "\nYOUR BOARD:".red.bold
        puts @human_user.board.render(true)
        puts message_1
        puts message_2
        puts "It is your turn! Please choose a valid spot to fire on Steve's board. Example: A5".light_black.bold
        puts "S = ship, M = miss, H = hit, X = sunken".cyan
        print ' > '.magenta
        choice = gets.chomp
        choice.delete!(' ')
        if choice == 'end'
          break
        end
        if @computer_user.board.valid_fire?(choice)
          @computer_user.board.cells[choice].fire_upon
          message_1 = "You have fired at cell #{choice} on Steve's board!".yellow
          @turn_counter += 1
        else
          message_1 = "Invalid Input! You either already fired here or the given coordinate does not exist.".red
        end
      else # If its not the players turn, then its the computers turn
        unfired_cells = @human_user.board.cells.values.find_all {|cell| cell.fired_upon? == false}
        chosen_cell = unfired_cells.sample
        @human_user.board.cells[chosen_cell.coordinate].fire_upon
        message_2 = "Steve has fired at cell #{chosen_cell.coordinate} on your board!".red
        @turn_counter += 1
      end
    end
  end

  def end_game
    if @computer_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0
      loser = 'Steve'
    elsif @human_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0
      loser = 'You'
    else
      loser = "No one"
    end
    puts "#{loser} loses after #{turn_counter} turns!"
  end

  def self.starter_message
    text = File.new('./txt_files/starter_message.txt').read
    text = text.split("\n")

    text[5][0..16] = text[5][0..16].yellow
    text[5][32..54] = text[5][32..54].blue
    text[5][69..86] = text[5][69..86].yellow

    text[22] = text[22].yellow
    return text
  end

  def self.setup
    # ask user if they want to continue with game
    puts "\n"
    puts "Enter p to play. Enter q to quit."

    # loop through until correct answer is given
    loop = true
    until loop == false do
      choice = gets.chomp
      if choice == "q"
        puts "Ok then, let's play another time. Have a nice day!"
        loop = false
        return nil
      elsif choice == "p"
        puts "Let's play Battleship!!!"
        puts "\n---------------------------------------------------------".yellow
        dimensions = self.get_dimensions
        ships = self.get_ships([dimensions[0], dimensions[1]].min)
        return Game.new(dimensions, ships)
      else
        puts "I'm not sure what you mean. Please enter p to play. Enter q to quit."
        loop = true
      end
    end


  end

  def self.get_dimensions
    puts "\n"
    puts "Please choose the board dimensions (rows x columns).".light_black.bold
    puts "Example: 15 x 20".light_black.italic
    print ' > '.magenta
    dimensions = gets.chomp
    while !(dimensions.split.length == 3 && dimensions.split[0].to_i <= 26 && dimensions.split[0].to_i >= 4 && dimensions.split[1] == 'x' && dimensions.split[2].to_i <= 26 && dimensions.split[2].to_i >= 4)
      puts "Invalid Input. Example: 15 x 20".red
      puts "Hint: maximum dimension is 26. minimum dimension is 4".red
      print ' > '.magenta
      dimensions = gets.chomp
    end
    puts "Great! You will be playing on boards with #{dimensions.split[0].to_i} rows and #{dimensions.split[2].to_i} columns".green
    [dimensions.split[0].to_i, dimensions.split[2].to_i]
  end


  def self.get_ships(max_length)
    puts "\n"
    puts "Pleaser enter a list of ships and their lengths that you would like to use for this game. You can create as many as you would like.".light_black.bold
    puts "Note: Based on the dimensions you have given, the maximum ship length is #{max_length}".light_black.bold
    puts "Example: ShipA 5, ShipB 4, ShipC 7".light_black.italic
    ship_objects = []
    until ship_objects.length > 0
      print ' > '.magenta
      choice = gets.chomp
      choice = choice.split(',')
      choice = choice.find_all{|ship| ship.split.length == 2 && ship.split[1].to_i <= max_length && ship.split[1].to_i >= 2 }
      choice = choice.map{|ship| ship_objects.push(Ship.new(ship.split[0], ship.split[1].to_i))}
      ship_objects.uniq!{|ship| ship.name}
      if ship_objects.length == 0
        puts "Invalid Input. Example: Cruiser 3, Submarine 2".red
        puts "Hint: maximum length is #{max_length}. Minimum length is 2".red
      end
    end
    puts "Great! You have created #{ship_objects.length} ships!".green
    ship_objects
  end

end
