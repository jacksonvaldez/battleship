require './lib/board'
require 'colorize' # gem install colorize in terminal if needed


class Game
  #initialzie
  attr_reader :turn_counter,
              :ships_ai,
              :ships_user,
              :board_ai,
              :board_user

  def initialize

  end

  def starter_message
    text = File.new('./txt_files/starter_message.txt').read
    text = text.split("\n")

    text[5][0..16] = text[5][0..16].yellow
    text[5][32..54] = text[5][32..54].blue
    text[5][69..86] = text[5][69..86].yellow

    text[22] = text[22].yellow
    text
  end



  def get_dimensions
    puts "Please choose the board dimensions (rows x columns). Example: 15 x 20".light_black.bold
    print ' > '.magenta
    dimensions = gets.chomp
    while !(dimensions.split.length == 3 && dimensions.split[0].to_i <= 26 && dimensions.split[0].to_i >= 4 && dimensions.split[1] == 'x' && dimensions.split[2].to_i <= 26 && dimensions.split[2].to_i >= 4)
      puts "Invalid Input. Example: 15 x 20".red
      puts "Hint: maximum dimension is 26. minimum dimension is 4".red
      print ' > '.magenta
      dimensions = gets.chomp
    end
    puts "Great! You will be playing on boards with #{dimensions.split[0].to_i} rows and #{dimensions.split[2].to_i} columns".green
    puts "\n"
    [dimensions.split[0].to_i, dimensions.split[2].to_i]
  end


  def get_ships(max_length)
    puts "Pleaser enter a list of ships and their lengths that you would like to use for this game. Example: Cruiser 3, Submarine 2, Big 5. You can create as many as you would like".light_black.bold
    ship_objects = []
    until ship_objects.length > 0
      print ' > '.magenta
      ships = gets.chomp
      ships = ships.split(',')
      ships = ships.find_all do |ship|
        ship.split.length == 2 && ship.split[1].to_i <= max_length && ship.split[1].to_i >= 2
      end
      ships = ships.map do |ship|
        ship_objects.push(Ship.new(ship.split[0], ship.split[1]))
      end
      if ship_objects.length == 0
        puts "Invalid Input. Example: Cruiser 3, Submarine 2".red
        puts "Hint: maximum length is #{max_length}. Minimum length is 2".red
      end
    end
    puts "Great! You have created #{ship_objects.length} ships!".green
    puts "\n"
    ship_objects.each do |ship|
      puts "#{ship.name}: #{ship.length}".yellow.bold
    end
    puts "\n"
    ship_objects
  end








  def start_game

    puts starter_message
    puts "\nLets Get Things Setup!"
    puts "\n"

    dimensions = get_dimensions
    player_board = Board.new(dimensions[1], dimensions[0])
    computer_board = Board.new(dimensions[1], dimensions[0])

    ships = get_ships([dimensions[1], dimensions[0]].min)

  end

  def place_ships(ships)
    #ask for locations for each ship
  end

  def take_turn(coordinate)

  end

  def end_game

  end
end
