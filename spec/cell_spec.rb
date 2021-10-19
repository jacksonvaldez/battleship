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

  describe ' #fired_upon' do
    it 'returns false when display is "."' do

    end
    it 'returns true when display is anything but "."' do

    end
  end

  describe ' #render'do
    it 'returns correct display object for each condition' do

    end
  end
end
