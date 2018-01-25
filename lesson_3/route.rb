class Route
  attr_accessor :name, :stations

  def initialize(first, last)
    self.stations = [first, last]
    self.name = first + "-" + last
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    if self.stations.include?(station)
      self.stations.delete(station)
    else
      puts 'Такой станции нет в маршруте'
    end    
  end
  
  def list_route
    puts "Список станций маршрута #{name}"
    stations.each_with_index do |station, num|
      puts "#{num + 1}. #{station}"
    end
  end
end

