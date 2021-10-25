require './lib/game'

puts ("-" * 15).bold.yellow
puts "Game".bold.yellow
puts ("-" * 15).bold.yellow
puts Game.instance_methods(false)

puts ("-" * 15).bold.yellow
puts "ComputerUser".bold.yellow
puts ("-" * 15).bold.yellow
puts ComputerUser.instance_methods(false)

puts ("-" * 15).bold.yellow
puts "HumanUser".bold.yellow
puts ("-" * 15).bold.yellow
puts HumanUser.instance_methods(false)

puts ("-" * 15).bold.yellow
puts "Board".bold.yellow
puts ("-" * 15).bold.yellow
puts Board.instance_methods(false)

puts ("-" * 15).bold.yellow
puts "Cell".bold.yellow
puts ("-" * 15).bold.yellow
puts Cell.instance_methods(false)

puts ("-" * 15).bold.yellow
puts "Ship".bold.yellow
puts ("-" * 15).bold.yellow
puts Ship.instance_methods(false)
