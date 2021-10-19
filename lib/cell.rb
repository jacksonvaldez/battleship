require './lib/ship'

class Cell
  attr_reader :coordinate
  attr_accessor :ship

  #initialize
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  # method to add ship object - return ship object or nil
  def place_ship

  end

  # method to check if cell is empty
  def empty

  end

end
