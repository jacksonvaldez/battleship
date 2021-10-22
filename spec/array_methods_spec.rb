
describe Array do

  describe '#everything_same?' do
    it 'returns true if the array given has elements that are all equal to each other' do
      expect([1, 1, 1, 1, 1].everything_same?).to eq(true)
      expect(['A', 'A', 'A', 'A'].everything_same?).to eq(true)
    end
    it 'returns false if the array given has elements that are not all equal to each other' do
      expect([1, 2, 3, 4, 5].everything_same?).to eq(false)
      expect(['A', 'B', 'C', 'D'].everything_same?).to eq(false)
    end
  end


  describe '#is_sequential?' do
    it 'returns true if the array given is in sequential' do
      expect([5, 8, 6, 7].is_sequential?).to eq(true)
      expect(['D', 'C', 'B'].is_sequential?).to eq(true)
    end
    it 'returns false if the array given is not in sequential' do
      expect([5, 8, 6, 7, 10].is_sequential?).to eq(false)
      expect(['D', 'C', 'B', 'Z'].is_sequential?).to eq(false)
    end
  end

end
