class Ship
  attr_reader :name, :length, :health

  def initialize (name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    @health <= 0 # Returns true if health is less than or equal to 0, and false if not.
  end

  def hit
    @health -= 1 # health = health - 1
  end


end
