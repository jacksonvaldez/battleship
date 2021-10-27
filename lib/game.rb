require './lib/board'
require './lib/user'
require 'colorize' # gem install colorize in terminal if needed


class Game
  #initialzie
  attr_reader :turn_counter, :computer_user, :human_user
  #attr_accessor :human_user


  def initialize(dimensions, ships)
    ships_2 = ships.map(&:clone)
    @computer_user = User.new(Board.new(dimensions[0], dimensions[1]), ships)
    @human_user = User.new(Board.new(dimensions[0], dimensions[1]), ships_2)
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
      return nil
    end

    # STAGE 4: Game asks the user and Steve to take turns back and forth until someone has no more ships
    game.alternate_turns

    # STAGE 5: Game ends itself and announces the winner
    game.end_game
  end



  def setup_boards # Game asks the computer user and the human to setup their boards.
    @computer_user.setup_board(true)
    @human_user.setup_board(false)
  end



  def alternate_turns # Computer and user take turns back and forth until someone's ships are sunk
    message_1 = nil
    message_2 = nil
    until @computer_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0 || @human_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0
      if @turn_counter.even? || @turn_counter == 0 # If its the players turn
        puts "\nSTEVE'S BOARD:".red.bold
        puts @computer_user.board.render(false)
        puts "\nYOUR BOARD:".red.bold
        puts @human_user.board.render(true)
        #puts @human_user.board.render_probability_map()
        puts message_1
        puts message_2
        puts "It is your turn! Please choose a valid spot to fire on Steve's board. Example: A5".light_black.bold
        puts "S = ship, M = miss, H = hit, X = sunken".cyan
        print ' > '.magenta
        choice = gets.chomp
        choice.delete!(' ')
        choice = choice.upcase
        if choice == 'END'
          break
        end
        if @computer_user.board.valid_fire?(choice)
          @computer_user.board.cells[choice].fire_upon
          # return correct message depending on the result
          result = @computer_user.board.cells[choice].render
          if result == "\e[1;31;49mM\e[0m"
            message_1 = "Cell #{choice} is a miss!!".yellow
          elsif result == "\e[1;34;49mH\e[0m"
            message_1 = "Cell #{choice} is a hit!!".yellow
          elsif result == "\e[1;36;49mX\e[0m"
            message_1 = "Cell #{choice} is a hit!! You sunk Steve's #{@computer_user.board.cells[choice].ship.name}!! (length = #{@computer_user.board.cells[choice].ship.length})".yellow
          else
            message_1 = "You have fired at cell #{choice} on Steve's board but it didn't result in a hit, miss or sinking. Something's not right!".yellow
          end
          @turn_counter += 1
        else
          message_1 = "Invalid Input! You either already fired here or the given coordinate does not exist.".red
        end
      else # If its not the players turn, then its the computers turn
        chosen_coordinate = @computer_user.hunt(@human_user.board, @human_user.ships, "probability")
        @human_user.board.cells[chosen_coordinate].fire_upon
        message_2 = "Steve has fired at cell #{chosen_coordinate} on your board!".red
        @turn_counter += 1
      end
    end
  end

  def end_game # Ends the game
    if (@computer_user.board == nil) || (@human_user.board == nil)
      loser = "No one"
      puts "Board failed to set up. Try using a larger board or fewer ships.".red
      # put something here to stop the rest of game.start_game.
    elsif @computer_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0
      loser = 'Steve'
    elsif @human_user.board.cells.values.count { |cell| cell.ship.class == Ship && cell.ship.sunk? == false } == 0
      loser = 'You'
    else
      loser = "No one"
    end
    puts "#{loser} loses after #{turn_counter} turns!".red
  end

  def self.starter_message # Returns a string that can be printed as a starter message to the terminal
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

  def self.get_dimensions # Game asks the user to input dimensions through the command line. If successful, it will return an array with 2 elements: [height, width]
    puts "\n"
    puts "Please choose the board dimensions (rows x columns), or type 'default' for standard Battleship board size.".light_black.bold
    puts "Example: 15 x 20".light_black.italic
    puts "Example: default".light_black.italic
    print ' > '.magenta
    dimensions = gets.chomp
    dimensions = dimensions.gsub(/\s+/, "").downcase
      while !(dimensions.split('x').length == 2 && dimensions.split('x')[0].to_i <= 26 && dimensions.split('x')[0].to_i >= 4 && dimensions.include?('x') && dimensions.split[1].to_i <= 26 && dimensions.split('x')[1].to_i >= 4)
        if dimensions == 'default'
          dimensions = '10x10'
        else
        puts "Invalid Input. Example: 15 x 20".red
        puts "Hint: maximum dimension is 26. minimum dimension is 4".red
        print ' > '.magenta
        dimensions = gets.chomp
        dimensions = dimensions.gsub(/\s+/, "").downcase
      end
    end
    puts "Great! You will be playing on boards with #{dimensions.split('x')[0].to_i} rows and #{dimensions.split('x')[1].to_i} columns".green
    [dimensions.split('x')[0].to_i, dimensions.split('x')[1].to_i]
  end


  def self.get_ships(max_length) #Game asks user to create custom ships in the command line. If successful, it will return an array of ship objects
    puts "\n"
    puts "Pleaser enter a list of ships and their lengths that you would like to use for this game. You can create as many as you would like.".light_black.bold
    puts "Note: Based on the dimensions you have given, the maximum ship length is #{max_length}".light_black.bold
    puts "Example: ShipA 5, ShipB 4, ShipC 7".light_black.italic
    puts "Alternatively, type 'default' to use standard Battleship ship types".light_black.italic
    ship_objects = []
    until ship_objects.length > 0
      print ' > '.magenta
      choice = gets.chomp
      if choice == 'default'
        ship_objects = [Ship.new("Destroyer", 2), Ship.new("Cruiser", 3), Ship.new("Submarine", 3), Ship.new("Battleship", 4), Ship.new("Carrier", 5)]
        break
      end
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
