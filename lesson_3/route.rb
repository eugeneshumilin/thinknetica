class Route
  attr_reader :name, :stations

  def initialize(first, last)
    @stations = [first, last]
    @name = first.name + "-" + last.name
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station) if stations.include?(station)
  end
end
