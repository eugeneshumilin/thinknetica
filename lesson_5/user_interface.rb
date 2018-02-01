class UserInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def show_menu
    puts '1 - Создать станцию'
    puts '2 - Создать поезд'
    puts '3 - Создать маршрут'
    puts '4 - Добавить станцию в маршрут'
    puts '5 - Удалить станцию из маршрута'
    puts '6 - Назначить маршрут поезду'
    puts '7 - Добавить вагон к поезду'
    puts '8 - Отцепить вагон от поезда'
    puts '9 - Переместить поезд вперед по маршруту'
    puts '10 - Переместить поезд назад по маршруту'
    puts '11 - Посмотреть список станций'
    puts '12 - Посмотреть список поездов на станции'
    puts '13 - Выход'
    puts '14 - Меню'
  end

  def control
    loop do
      print 'Выберите действие: '
      action = gets.chomp
      case action
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route
      when '4'
        add_station_to_route
      when '5'
        delete_station_from_route
      when '6'
        set_route_to_train
      when '7'
        add_wagon_to_train
      when '8'
        remove_wagon_from_train
      when '9'
        forward
      when '10'
        back
      when '11'
        show_stations
      when '12'
        list_of_trains
      when '13', 'exit'
        exit
      when '14', 'help'
        show_menu
      else
        puts 'Некорректный ввод, попробуйте еще раз.'
      end
    end
  end

  private

  def create_station
    print 'Введите название станции: '
    station_name = gets.chomp
    @stations << RailwayStation.new(station_name)
    puts "Станция #{station_name} создана"
  end

  def create_train
    print 'Какой поезд вы хотите создать?(1 - пассажирский, 2 - грузовой): '
    train_type = gets.chomp
    print 'Задайте номер поезду: '
    number = gets.chomp
    if train_type == '1'
      @trains << PassengerTrain.new(number)
      puts "Пассажирский поезд #{number} создан"
    elsif train_type == '2'
      @trains << CargoTrain.new(number)
      puts "Грузовой поезд #{number} создан"
    else
      puts 'Введенные данные некорректны'
    end
  end

  def create_route
    puts 'Выберите начальную станцию маршрута по индексу:'
    show_stations
    first = @stations[gets.to_i - 1]
    print 'Выберите конечную станцию маршрута по индексу: '
    last = @stations[gets.to_i - 1]
    route = Route.new(first, last)
    @routes << route
    puts "Маршрут #{route.name} создан"
  end

  def add_station_to_route
    route = route_choice
    station = station_choice
    route.add_station(station)
    puts 'Станция добавлена'
  end

  def delete_station_from_route
    route = route_choice
    station = station_choice
    route.remove_station(station)
    puts 'Станция удалена'
  end

  def set_route_to_train
    train = train_choice
    route = route_choice
    train.take_route(route)
  end

  def add_wagon_to_train
    train = train_choice
    if train.class == PassengerTrain
      train.add_wagon(PassengerWagon.new)
    else
      train.add_wagon(CargoWagon.new)
    end
    puts 'Вагон добавлен'
  end

  def remove_wagon_from_train
    train = train_choice
    train.remove_wagon(train.wagons.last)
    puts 'Вагон отцеплен'
  end

  def forward
    train = train_choice
    train.move_next_station
    puts "Поезд пермещен вперед на станцию #{train.current_station.name}"
  end

  def back
    train = train_choice
    train.move_previous_station
    puts "Поезд перемещен назад на станцию #{train.current_station.name}"
  end

  def list_of_trains
    station = station_choice
    station.trains.each { |train| puts "#{train.number} - #{train.class}" }
  end

  def show_trains
    @trains.each.with_index(1) { |train, index| puts "#{index} - #{train.number} - #{train.class}" }
  end

  def show_stations
    @stations.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
  end

  def show_routes
    @routes.each.with_index(1) { |route, index| puts "#{index} - #{route.name}" }
  end

  def route_choice
    puts 'Выберите маршрут по индексу:'
    show_routes
    route = @routes[gets.to_i - 1]
  end

  def train_choice
    puts 'Выберите поезд по индексу:'
    show_trains
    train = @trains[gets.to_i - 1]
  end

  def station_choice
    puts 'Выберите станцию по индексу:'
    show_stations
    station = @stations[gets.to_i - 1]
  end
end
