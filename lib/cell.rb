require './lib/ship'

class Cell
  attr_reader :coordinate
  attr_accessor :ship, :display

  #initialize cell with coordinate name and empty ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  # method to add ship object - return ship object or nil
  def place_ship

  end

  # method to check if cell is empty
  def empty?
    ship == nil
  end

  # method to check if cell has already been fired upon
  def fired_upon?

  end

  #method to fire upon cell
  def fire_upon

  end

  # method to return status of cell
  def render

  end
end
