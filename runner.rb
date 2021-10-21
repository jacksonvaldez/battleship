require './lib/board'
require 'colorize' # gem install colorize in terminal if needed



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








def start_game

  puts starter_message
  puts "\nLets Get Things Setup!"
  puts "\n"

  dimensions = get_dimensions
  player_board = Board.new(dimensions[1], dimensions[0])
  computer_board = Board.new(dimensions[1], dimensions[0])

end


start_game
