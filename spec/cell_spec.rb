require './lib/cell'
require './lib/ship'

describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
  end

  it 'is a cell' do
    expect(@cell).to be_a(Cell)
  end

  it 'has correct coordinate' do
    expect(@cell.coordinate).to eq("B4")
  end

  it 'initializes with nil ship' do
    expect(@cell.ship).to eq(nil)
  end

  it 'initializes with fire_upon = false' do
    expect(@cell.fired_upon).to eq(false)
  end

  describe ' #place_ship' do
    it 'adds ship object' do
      @cell.place_ship(@ship)
      expect(@cell.ship).to be_a(Ship)
      expect(@cell.ship).to eq(@ship)
    end
  end

  describe ' #empty?' do
    it 'returns true when nil present' do
      expect(@cell.empty?).to eq(true)
    end
    it 'returns false when ship present' do
      @cell.place_ship(@ship)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe ' #fire_upon' do
    it 'changes fired_upon to true' do
      expect(@cell.fired_upon).to eq(false)
      @cell.fire_upon
      expect(@cell.fired_upon).to eq(true)
    end
  end

  describe ' #fired_upon?' do
    it 'returns false when cell has not been fired upon' do
      expect(@cell.fired_upon).to eq(false)
      expect(@cell.fired_upon?).to eq(false)
    end
    it 'returns true after cell has been fired upon' do
      @cell.fire_upon
      expect(@cell.fired_upon).to eq(true)
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe ' #render'do
    it 'returns "." if fired_upon == false and ship == nil' do
      expect(@cell.render).to eq(".")
      expect(@cell.render(true)).to eq(".")
    end
    it 'returns "." if fired_upon == false, ship == Ship and render == false' do
      @cell.place_ship(@ship)
      expect(@cell.render).to eq(".")
    end
    it 'returns "S" if fired_upon == false, ship == Ship and render == true' do
      @cell.place_ship(@ship)
      expect(@cell.render(true)).to eq("S")
    end
    it 'returns "M" if fired_upon == true, ship == nil and ship != sunk' do
      @cell.fire_upon
      expect(@cell.render(true)).to eq("M")
      expect(@cell.render).to eq("M")
    end
    it 'returns "H" if fired_upon == true, ship == Ship and ship != sunk' do
      @cell.place_ship(@ship)
      @cell.fire_upon
      expect(@cell.render(true)).to eq("H")
      expect(@cell.render).to eq("H")
    end
    it 'returns X if fired_upon == true and ship == Ship and ship == sunk' do
      @cell.place_ship(@ship)
      # hit ship until health = 1
      until @ship.health == 1 do
        @ship.hit
      end
      @cell.fire_upon
      expect(@cell.ship.sunk?).to eq(true)
      expect(@cell.render(true)).to eq("X")
      expect(@cell.render).to eq("X")
    end
  end
end
