require './lib/ship'

class Cell
  attr_reader :coordinate, :fired_upon, :ship

  #initialize cell with coordinate name and empty ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  # method to add ship object - return ship object or nil
  def place_ship(ship)
    @ship = ship
  end

  # method to check if cell is empty
  def empty?
    ship == nil
  end

  # method to check if cell has already been fired upon
  def fired_upon?
    @fired_upon
  end

  #method to fire upon cell
  def fire_upon
    @fired_upon = true
    if !empty?
      ship.hit
    end
  end

  # method to return status of cell
  def render(*show)
    # show_ship = false uinless true given
    show_ship = false
    if show != []
      show_ship = show[0]
    end
    if !fired_upon? && empty?
      "."
    elsif !fired_upon? && !empty? && !show_ship
      "."
    elsif !fired_upon? && !empty? && show_ship
      "S"
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && !empty? && !ship.sunk?
      "H"
    else fired_upon? && !empty? && ship.sunk?
      "X"
    end
  end
end
