require_relative 'valid'

class Route
  include Valid
  attr_reader :name, :stations

  def initialize(first, last)
    @stations = [first, last]
    validate!
    @name = first.name + '-' + last.name
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station)
  end

  protected

  def validate!
    first = @stations.first
    last = @stations.last
    unless first.is_a?(RailwayStation) && last.is_a?(RailwayStation)
      raise 'Parameters must be objects of the RailwayStation class'
    end
    true
  end
end
