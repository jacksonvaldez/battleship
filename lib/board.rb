require './lib/cell'




public # Allows the methods below to be accessed inside the Board class definition

# Testing if every element in an array is the same. [1, 2, 3] --> false,    ['hi', 'hi', 'hi'] --> true
def everything_same?(array)
  array.all? do |element|
    element == array[0]
  end
end

# Testing if characters OR numbers in an array are sequential ['A', 'B', 'C'] --> true,  [1, 2, 3] --> true
def is_sequential?(array)
  array.sort!
  (array.first..array.last).to_a == array
end




class Board

  attr_reader :height, :width, :cells, :cell_coordinates

  def initialize(height, width)
    @height = height
    @width = width
    @cells = []
    @cell_coordinates = [] #An array of coordinates(strings) for each cell object


    # Creates an array of cell objects based on height and width
    # Example: If height is 5, and width is 3, then:

    #   1 2 3
    # A . . .
    # B . . .
    # C . . .
    # D . . .
    # E . . .

    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']

    # Generates an array of cells for the board
    @width.times do |w|
      @height.times do |h|
        @cells.push(Cell.new("#{alphabet[h]}#{w + 1}"))
        @cell_coordinates.push("#{alphabet[h]}#{w + 1}")
      end
    end
  end

  # Tests if a coordinate is a valid placement on the board
  def valid_coordinate?(coordinate)
    check_coordinate = @cell_coordinates.include?(coordinate)
    check_ship = get_cell(coordinate).empty?
    check_coordinate && check_ship #return true only if both coordinate valid and cell empty
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
        element[1] # Each element is a string. Its returning a new array for the SECOND character of each string. ['A1', A2', 'A3'] --> ['1', '2', '3']
      end
    end


    if ship.length == coordinates.length # Testing if the ship length is the same length as the coordinates given
      coordinates.each do |coordinate| # Testing if the coordinates given are a valid position on the board
        if !self.valid_coordinate?(coordinate)
          return false
        end
      end
      if self.everything_same?(parse_letters(coordinates)) # If all the coordinates start with the same letter
        if self.is_sequential?(parse_numbers(coordinates)) # If all the numbers in each coordinate is sequential
          return true # Add code here that tests for overlapping ships
        else
          return false
        end
      elsif self.everything_same?(parse_numbers(coordinates)) # If all the coordinates end with the same number
        if self.is_sequential?(parse_letters(coordinates)) # If all the letters in each coordinate is sequential
          return true # Add code here that tests for overlapping ships
        else
          return false
        end
      else
        return false
      end
    end
  end

  # method to check cell by name
  def get_cell(name)
    if @cell_coordinates.include?(name)
      return @cells[@cell_coordinates.index(name)]
    else
      return nil
    end
  end

  # place ship
  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        get_cell(coordinate).place_ship(ship)
      end
    end
  end

  # this is start of render method
  def render(*show)
    board_render = []
    board_render[0] = '  '
    @width.times do |w|
      board_render[0] += "#{w + 1} "
    end
    @height.times do |h|
      board_render[]
    end
  end
end
