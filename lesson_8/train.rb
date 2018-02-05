require_relative 'company'
require_relative 'instance_counter'
require_relative 'valid'

class Train
  include Company
  include InstanceCounter
  include Valid

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  attr_reader :speed, :number, :wagons, :train_route

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    register_instance
    @number = number
    @speed = 0
    @index_station = 0
    @wagons = []
    validate!
    @@trains[self.number] = self
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
    if current_station != @train_route.stations.last
      current_station.depart(self)
      @index_station += 1
      current_station.arrive(self)
    else
      current_station
    end
  end

  def move_previous_station
    if current_station != @train_route.stations.first
      current_station.depart(self)
      @index_station -= 1
      current_station.arrive(self)
    else
      current_station
    end
  end

  def current_station
    @train_route.stations[@index_station]
  end

  def next_station
    size = @train_route.stations.size
    @train_route.stations[@index_station + 1] if @index_station != size - 1
  end

  def previous_station
    @train_route.stations[@index_station - 1] if @index_station.nonzero?
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) } if block_given?
  end

  protected

  def validate!
    raise 'Number cannot be nil' if number.nil?
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    raise 'Numbers cannot be duplicated' unless @@trains[number].nil?
    true
  end
end
