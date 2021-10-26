require './lib/cell'
require './lib/array_methods'




class Board

  attr_reader :height, :width, :cells

  def initialize(width, height)
    @height = height
    @width = width
    @cells = Hash.new()


    # Creates an array of cell objects based on height and width
    # Example: If height is 5, and width is 3, then:

    #   1 2 3
    # A . . .
    # B . . .
    # C . . .
    # D . . .
    # E . . .

    alphabet = ('A'..'Z').to_a

    # Generates an array of cells for the board
    @height.times do |h|
      @width.times do |w|
        #@cells.push(Cell.new("#{alphabet[h]}#{w + 1}"))
        @cells["#{alphabet[h]}#{w + 1}"] = Cell.new("#{alphabet[h]}#{w + 1}")
      end
    end

  end

  # Tests if a coordinate is a valid placement on the board
  # Return true only if both coordinate valid and cell empty
  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate) && @cells[coordinate].empty?
  end

  def valid_fire?(coordinate)
    @cells.keys.include?(coordinate) && @cells[coordinate].fired_upon? == false
  end


  # Tests if a ship placement is possible on the board
  def valid_placement?(ship, coordinates)

    def parse_letters(strings)
      strings.map do |element|
        element[0] # Each element is a string. Its returning a new array for the FIRST character of each string. ['A1', A2', 'A3'] --> ['A', 'B', 'C']
      end
    end

    def parse_numbers(strings)
      strings.map do |element|
        element[1..2] # Each element is a string. Its returning a new array for the SECOND character of each string. ['A1', A2', 'A3'] --> ['1', '2', '3']
      end
    end

    if !(ship.length == coordinates.length) # Testing if the ship length is the same length as the coordinates given, and if there are more than 2 coordinates given
      return false
    end

    coordinates.each do |coordinate| # Testing if the coordinates given are a valid position on the board
      if !self.valid_coordinate?(coordinate)
        return false
      end
    end

    if parse_letters(coordinates).everything_same? && parse_numbers(coordinates).is_sequential? # If all the numbers in each coordinate is sequential AND If all the coordinates start with the same letter
      return true # Add code here that tests for overlapping ships
    elsif parse_numbers(coordinates).everything_same? && parse_letters(coordinates).is_sequential? # If all the letters in each coordinate is sequential AND If all the coordinates end with the same number
      return true # Add code here that tests for overlapping ships
    else
      return false
    end

  end


  # place ship
  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each { |coordinate| @cells[coordinate].place_ship(ship) }
      return true #returns true if the placement was successful
    end
  end


  # this is start of render method
  def render(show = false)
    # gather working variables and aggregators
    letters = ('A'..'Z').to_a[0..(@height -1)]
    print_text =[]

    # generate the first row
    first_row = (1..@width).to_a # create array of numbers based on width
    first_row = first_row.map do |element| # change each number in array to a string of that number
      element.to_s[0]
    end
    second_row = (1..@width).to_a # create array of numbers based on width
    second_row = second_row.map do |element| # change each number in array to a string of that number
      if element.to_s[1].class == String
        element.to_s[1]
      end
    end

    # add first row to print_text
    # prepend white space and append newline to first row, then shovel into print_text
    print_text << first_row.unshift(" ").push("\n").join(" ")
    print_text << "           " + second_row.join(" ") + "\n"

    # iterate through each "row" of the cells array
    @cells.values.each_slice(@width).with_index(0) do |row, counter|
      # iterate through each cell in row to return the render string (S, ., M etc.)
      cell_text = row.map do |cell|
        cell.render(show)
      end
      # prepend row letter, append newline, join with space, then shovel to print)text array.
      print_text << cell_text.unshift(letters[counter]).push("\n").join(" ")
    end
    print_text = print_text.join()
  end

  # this is start of render probability method
  def render_probability_map(show = false)
    # gather working variables and aggregators
    letters = ('A'..'Z').to_a[0..(@height -1)]
    print_text =[]

    # generate the first row
    first_row = (1..@width).to_a # create array of numbers based on width
    first_row = first_row.map do |element| # change each number in array to a string of that number
      element.to_s[0]
    end
    second_row = (1..@width).to_a # create array of numbers based on width
    second_row = second_row.map do |element| # change each number in array to a string of that number
      if element.to_s[1].class == String
        element.to_s[1]
      end
    end

    # add first row to print_text
    # prepend white space and append newline to first row, then shovel into print_text
    print_text << first_row.unshift(" ").push("\n").join(" ")
    print_text << "           " + second_row.join(" ") + "\n"

    # iterate through each "row" of the cells array
    @cells.values.each_slice(@width).with_index(0) do |row, counter|
      # iterate through each cell in row to return the render string (S, ., M etc.)
      cell_text = row.map do |cell|
        cell.possible_ships.to_s
      end
      # prepend row letter, append newline, join with space, then shovel to print)text array.
      print_text << cell_text.unshift(letters[counter]).push("\n").join(" ")
    end
    print_text = print_text.join()
  end


  def fits?(ship_length)
    alphabet = ('A'..'Z').to_a
    counter_1 = 0
    counter_2 = 0
    @height.times do |h|
      @width.times do |w|
        if counter_1 >= ship_length
          return true
        elsif @cells["#{alphabet[h]}#{w + 1}"].empty?
          counter_1 += 1
        else
          counter_1 = 0
        end
        # at the end of the loop, reset the counter before starting next row.
        if counter_1 > @width
          counter_1 = 0
        end
      end
    end
    @width.times do |w|
      @height.times do |h|
        if counter_2 >= ship_length
          return true
        elsif @cells["#{alphabet[h]}#{w + 1}"].empty?
          counter_2 += 1
        else
          counter_2 = 0
        end
        # at the end of the loop, reset the counter before starting next row.
        if counter_2 > @height
          counter_2 = 0
        end
      end
    end
    return false
  end

end
