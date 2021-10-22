require './lib/game'
require 'colorize' # gem install colorize in terminal if needed

def starter_message
  text = File.new('./txt_files/starter_message.txt').read
  text = text.split("\n")

  text[5][0..16] = text[5][0..16].yellow
  text[5][32..54] = text[5][32..54].blue
  text[5][69..86] = text[5][69..86].yellow

  text[22] = text[22].yellow
  puts text
end

def setup?
  # ask user if they want to continue with game
  puts "\n"
  puts "Enter p to play. Enter q to quit."

  # loop through until correct answer is given
  loop? = true
  until loop? == false do
    choice = gets.chomp
    if choice == "q"
      puts "Ok then, let's play another time. Have a nice day!"
      loop? = false
      return false
    elsif choice == "p"
      puts "Let's play Battleship!!!\n"
      loop? = false
      return true
    else
      puts "I'm not sure what you mean. Please enter p to play. Enter q to quit."
      loop? = true
    end
  end
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



starter_message
if setup?
  dimensions = get_dimensions
  ships = get_ships([dimensions[1], dimensions[0]].min)
  game = Game.new(dimensions, ships)
end
# print starter message
# based on input, start game setup
# setup game
# gather board shape from user
# gather ships from user
# generate boards
# generate ships
# place ships
# place_ships(game.ships_ai, true) #pass ships array and boolean toggle for computer or User placement
# place_ships(game.ships_user, false)
# take turns until winner
# end game
