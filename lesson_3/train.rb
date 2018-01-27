class Train
  attr_reader :speed, :number, :wagons, :type, :train_route

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

  def accelerate
    @speed += 10
  end

  def down_speed
    @speed > 9 ? @speed -= 10 : @speed
  end

  def add_wagon
    @speed == 0 ? @wagons += 1 : @wagons
  end

  def remove_wagon
    @speed == 0 && @wagons > 0 ? @wagons -= 1 : @wagons
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
    @train_route.stations[@index_station + 1] if @index_station != @train_route.stations.size - 1
  end

  def previous_station
    @train_route.stations[@index_station - 1] if @index_station != 0
  end
end

