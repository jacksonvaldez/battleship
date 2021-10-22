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

  # ask user if they want to continue with game
  puts "\n"
  puts "Enter p to play. Enter q to quit."
  choice = gets.chomp
  if choice = "q"
    puts "Ok then, let's play another time. Have a nice day!"
  elsif choice = "p"
    puts "Let's play Battleship!!!\n"
    game_setup
  else
    puts "I'm not sure what you mean. Please enter p to play. Enter q to quit."
  end
end

def game_setup
  game = Game.new()
  dimensions = game.get_dimensions
end

# print starter message
starter_message
# based on input, start game setup
# setup game
# gather board shape from user
# get_dimensions
# generate boards
# gather ships from user
# get_ships
# generate ships
# place ships
# place_ships(game.ships_ai, true) #pass ships array and boolean toggle for computer or User placement
# place_ships(game.ships_user, false)
# take turns until winner
# end game
