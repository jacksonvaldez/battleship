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

  # def valid_coordinate?(coordinate)
  #   @cells.times do |i|
  #     if coordinate == @cells[i].coordinate
  #       return true
  #     else
  #       return false
  #     end
  #   end
  # end



end
