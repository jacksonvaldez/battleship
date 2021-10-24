class HumanUser

  attr_reader :board, :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end

  def take_turn

  end

  def setup_board
    loop = true
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
          puts "Ship placed successfully!".green
        else
          puts "Invalid Input! Make sure the coordinates form a".red
          puts "straight line and don't overlap any other ships.".red
        end
        loop = true
      else
        break
      end
    end
  end


end
