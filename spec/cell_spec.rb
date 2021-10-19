require './lib/cell'
require './lib/ship'

describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @ship = Ship.new()
  end

  it 'is a cell' do
    expect(@cell).to be_a Cell
  end

  it 'has correct coordinate' do
    expect(@cell.coordinate).to eq("B4")
  end

  it 'initializes with nil ship' do
    expect(@cell.ship).to eq(nil)
  end

  it 'initializes with display = "."' do
    expect(@cell.display).to eq(".")
  end

  describe ' #place_ship' do
    it 'adds ship object' do
      @cell.place_ship(@ship)
      expect(@cell.ship).to be_a Ship
      expect(@cell.ship).to eq(@ship)
    end
  end

  describe ' #empty?' do
    it 'returns true when nil present' do
      expect(@cell.empty?).to eq(true)
    end
    it 'returns false when ship present' do
      cell.place_ship(@ship)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe ' #fire_upon' do
    it 'updates display to M if no ship present' do
      expect(@cell.display).to eq(".")
      @cell.fire_upon
      expect(@cell.display).to eq("M")
    end
    it 'updates display to H if ship present' do
      expect(@cell.display).to eq(".")
      @cell.place_ship(@ship)
      @cell.fire_upon
      expect(@cell.display).to eq("H")
    end
  end

  describe ' #fired_upon' do
    it 'returns false when display is "."' do
      expect(@cell.display).to eq(false)
    end
    it 'returns true when display is anything but "."' do
      @cell.fire_upon
      expect(@cell.fired_upon).to eq(true)
    end
  end

  describe ' #render'do
    it 'returns "." if fired_upon == false and ship == nil' do
      expect(@cell.render(false)).to eq (".")
    end
    it 'returns "." if fired_upon == false, ship == nil and render == true' do
      expect(@cell.render(true)).to eq (".")
    end
    it 'returns "S" if fired_upon == false, ship == Ship and render == true' do
      @cell.place_ship(@ship)
      expect(@cell.render(true)).to eq ("S")
    end
    it 'returns "M" if fired_upon == true, ship == nil and ship != sunk' do
      @cell.fire_upon
      expect(@cell.render(true)).to eq ("M")
      expect(@cell.render(false)).to eq ("M")
    end
    it 'returns "H" if fired_upon == true, ship == Ship and ship != sunk' do
      @cell.place_ship(@ship)
      @cell.fire_upon
      expect(@cell.render(true)).to eq ("H")
      expect(@cell.render(false)).to eq ("H")
    end
    it 'returns X if fired_upon == true and ship == Ship and ship == sunk'
    @cell.place_ship(@ship)
    # hit ship until health = 1
    until @ship.health == 1
      @ship.hit
    end
    @cell.fire_upon
    expect(@cell.ship.sunk?).to eq (true)
    expect(@cell.render(true)).to eq ("X")
    expect(@cell.render(false)).to eq ("X")
    end
  end
end
