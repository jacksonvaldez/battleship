require './lib/cell'

class Board

  attr_reader :height, :width, :cells

  def initialize(height, width)
    @height = height
    @width = width
    @cells = []


    # Creates an array of cell objects based on height and width
    # Example: If height is 5, and width is 3, then:

    #   1 2 3
    # A . . .
    # B . . .
    # C . . .
    # D . . .
    # E . . .

    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
    @width.times do |w|
      @height.times do |h|
        @cells.push(Cell.new("#{alphabet[w]}#{h + 1}"))
      end
    end
  end


  def valid_coordinate?(coordinate)
    @cells.length.times do |i|
      if coordinate == @cells[i].coordinate
        return true
      end
    end
    return false
  end


  def everything_same?(array)
    array_new = array.find_all do |element|
      element == array[0]
    end
    array_new.length == array.length
  end




  def valid_placement?(ship, coordinates_array)

    # if the length of the ship object is not the same as the length of the coordinates_array array, return false for the whole method.
    if ship.length != coordinates_array.length
      return false
    end

    coordinates_array.each do |coordinate|
      if self.valid_coordinate?(coordinate) == false
        return false
      end
    end















    # Pseudocode
    if 'everything in letter_array is the same'
      if 'the number_array is in sequential order'
        return true
      end
    end

    if 'everything in the number_array is the same'
      if 'the letter_array is an alphabetical order'
        return true
      end
    end



    return false
  end




end
