class Train
  attr_accessor :speed
  attr_reader :wagons, :type, :train_route, :current_station

  def initialize(number, type = :passenger, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @index_station = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @speed == 0 ? @wagons += 1 : @wagons
  end

  def remove_wagon
    (@speed == 0 && @wagons != 0) ? @wagons -= 1 : @wagons
  end

  def take_route(route)
    @train_route = route
    @current_station = @train_route.stations.first
    @current_station.arrive(self)
  end

  def move_next_station
    @current_station = self.next_station
    @current_station.arrive(self)
  end

  def move_previous_station
    @current_station = self.previous_station
    @current_station.arrive(self)
  end

  private

  def next_station
    @train_route.stations[@index_station += 1] if @index_station != @train_route.stations.size - 1
  end

  def previous_station
    @train_route.stations[@index_station -= 1] if @index_station != 0
  end
end
