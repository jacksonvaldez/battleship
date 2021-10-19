require './lib/ship'


describe Ship do


  before(:each) do
    @ship = Ship.new('Cruiser', 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ship).to be_instance_of(Ship)
    end
  end


  describe '#sunk?' do
    it 'returns appropriate boolean' do
      5.times do
        @ship.hit
      end
      expect(@ship.sunk?).to eq(true)
    end
    it 'returns appropriate boolean' do
      2.times do
        @ship.hit
      end
      expect(@ship.sunk?).to eq(false)
    end
  end



end
