require './lib/ship'

class Cell
  attr_reader :coordinate, :fired_upon, :ship, :show_ship

  #initialize cell with coordinate name and empty ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
    @show_ship = false
  end

  # method to add ship object - return ship object or nil
  def place_ship(ship)
    @ship = ship
    return nil
  end

  # method to check if cell is empty
  def empty?
    ship == nil
  end

  # method to check if cell has already been fired upon
  def fired_upon?
    @fired_upon
  end

  #
  def show_ship?
    @show_ship
  end
  #method to fire upon cell
  def fire_upon
    @fired_upon = true
    if !empty?
      ship.hit
    end
    return nil
  end

  # method to return status of cell
  def render(*show)
    # show_ship = false uinless true given
    if show != []
      @show_ship = show[0]
    end

    # run tests to determine what to display
    if !fired_upon? && empty?
      "." # empty
    elsif !fired_upon? && !empty? && !show_ship?
      "." # ship exists, but don't show it
    elsif !fired_upon? && !empty? && show_ship?
      "S" # Ship
    elsif fired_upon? && empty?
      "M" # Missed
    elsif fired_upon? && !empty? && !ship.sunk?
      "H" # Hit
    else fired_upon? && !empty? && ship.sunk?
      "X" # Sunken Ship
    end
    @show_ship = false
  end
end
