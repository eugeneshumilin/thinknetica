require_relative 'route'
require_relative 'railway_station'

class Train
  attr_accessor :speed, :route, :station
  attr_reader :wagons

  def initialize(number, type, wagons)
    @number = number
    @type = type if type == 'cargo' || type == 'passenger'
    @wagons = wagons
    @index = 0
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    @wagons += 1 if speed == 0
  end
  
  def remove_wagon
    @wagons -= 1 if speed == 0
  end     
  
  def take_route(route)
    self.route = route
    self.station = route.stations[@index]
  end

  def move_next_station
    self.station = route.stations[@index + 1]
  end

  def move_previous_station
    if @index != 0
      self.station = route.stations[@index -1]  
    elsif self.route.nil? 
      puts 'Маршрут для поезда не задан'
    else
      puts 'Поезд находится на первой станции маршрута'
    end
  end

  def list_station
    puts "Поезд находитс на станции #{station}, предыдущая станция - #{route.stations[@index -1]}, следующая станция маршрута - #{route.stations[index + 1]}"
  end
end

