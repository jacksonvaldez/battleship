
describe HelpfulMethods do

  before(:each) do
    @helpful_methods = HelpfulMethods.new
  end



  describe '#everything_same?' do
    it 'returns true if the array given has elements that are all equal to each other' do
      expect(@helpful_methods.everything_same?([1, 1, 1, 1, 1])).to eq(true)
      expect(@helpful_methods.everything_same?(['A', 'A', 'A', 'A'])).to eq(true)
    end
    it 'returns false if the array given has elements that are not all equal to each other' do
      expect(@helpful_methods.everything_same?([1, 2, 3, 4, 5])).to eq(false)
      expect(@helpful_methods.everything_same?(['A', 'B', 'C', 'D'])).to eq(false)
    end
  end


  describe '#is_sequential?' do
    it 'returns true if the array given is in sequential' do
      expect(@helpful_methods.is_sequential?([5, 8, 6, 7])).to eq(true)
      expect(@helpful_methods.is_sequential?(['D', 'C', 'B'])).to eq(true)
    end
    it 'returns false if the array given is not in sequential' do
      expect(@helpful_methods.is_sequential?([5, 8, 6, 7, 10])).to eq(false)
      expect(@helpful_methods.is_sequential?(['D', 'C', 'B', 'Z'])).to eq(false)
    end
  end

end
