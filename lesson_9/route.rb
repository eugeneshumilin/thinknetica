require_relative 'validation'
require_relative 'accessors'

class Route
  include Validation
  include Accessors
  attr_reader :name, :stations
  
  validate :stations, :presence
  validate :name, :presence

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
end
