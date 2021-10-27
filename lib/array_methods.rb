


class Array # Adding custom methods to the array class.

  # Testing if every element in an array is the same. [1, 2, 3] --> false,    ['hi', 'hi', 'hi'] --> true
  def everything_same?
    self.uniq.length <= 1 # 'self' is the array.
  end

    # Testing if characters OR numbers in an array are sequential ['A', 'B', 'C'] --> true,  [1, 2, 3] --> true
  def is_sequential?
    array = self
    if array[0].to_i > 0
      array = array.map { |e| e.to_i }
    end
    array.sort!
    (array.first..array.last).to_a == array
  end

end
