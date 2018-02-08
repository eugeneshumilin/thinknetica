require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Company
  include InstanceCounter
  include Validation
  include Accessors

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  attr_reader :speed, :number, :wagons, :train_route
  attr_accessor_with_history :aaa, :bbb
  strong_attr_accessor :ccc, Array

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @index_station = 0
    @wagons = []
    @@trains[self.number] = self
    register_instance
  end

  def stop
    @speed = 0
  end

  def accelerate
    @speed += 10
  end

  def down_speed
    @speed > 9 ? @speed -= 10 : @speed
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && check_class(wagon)
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) if @wagons.include?(wagon) && @speed.zero?
  end

  def take_route(route)
    @train_route = route
    @index_station = 0
    current_station.arrive(self)
  end

  def move_next_station
    if current_station != route_stations.last
      current_station.depart(self)
      @index_station += 1
      current_station.arrive(self)
    else
      current_station
    end
  end

  def move_previous_station
    if current_station != route_stations.first
      current_station.depart(self)
      @index_station -= 1
      current_station.arrive(self)
    else
      current_station
    end
  end

  def current_station
    route_stations[@index_station]
  end

  def next_station
    size = route_stations.size
    route_stations[@index_station + 1] if @index_station != size - 1
  end

  def previous_station
    route_stations[@index_station - 1] if @index_station.nonzero?
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) } if block_given?
  end

  private

  def route_stations
    @train_route.stations
  end
end
