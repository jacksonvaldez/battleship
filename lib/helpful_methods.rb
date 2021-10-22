

class HelpfulMethods

  # Testing if every element in an array is the same. [1, 2, 3] --> false,    ['hi', 'hi', 'hi'] --> true
  def self.everything_same?(array)
    array.uniq.length <= 1
  end

  # Testing if characters OR numbers in an array are sequential ['A', 'B', 'C'] --> true,  [1, 2, 3] --> true
  def self.is_sequential?(array)
    array.sort!
    (array.first..array.last).to_a == array
  end

end
