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


end
