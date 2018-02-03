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
    puts '13 - Посмотреть подробно список всех поездов с вагонами на станциях(NEW)'
    puts '14 - Заполнить вагон(NEW)'
    puts '15 - Выход'
    puts '16 - Меню'
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
      when '13'
        show_each_train_on_stations
      when '14'
        fill_wagon
      when '15', 'exit'
        exit
      when '16', 'help'
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
    begin
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
    end
    rescue RuntimeError => e
      puts e.message
      retry
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
    print 'Введите кол-во мест, если вагон пассажирский, и объем, если вагон грузовой: '
    spaces = gets.to_i
    if train.is_a?(PassengerTrain)
      train.add_wagon(PassengerWagon.new(spaces))
      puts "Добавлен вагон на #{spaces} мест"
    else
      train.add_wagon(CargoWagon.new(spaces))
      puts "Добавлен вагон объемом #{spaces}"
    end
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

  def show_each_train_on_stations
    @stations.each do |station|
      puts "#{station.name}:"
      station.each_train do |train|
        puts "#{train.number} - #{train.class} - #{train.wagons.size}"
        train.each_wagon do |wagon|
          puts "#{wagon.number} - #{wagon.class} - #{wagon.free_space} - #{wagon.occupied_space}"
        end
      end
    end
  end

  def fill_wagon
    train = train_choice
    puts "#{train.class} под номером #{train.number} имеет #{train.wagons.size} вагонов"
    print "Выберите вагон от 1 до #{train.wagons.size} "
    wagon = train.wagons[gets.to_i - 1]
    if wagon.is_a?(PassengerWagon)
      puts "Пассажирский вагон. Количество свободных мест: #{wagon.free_space}"
      puts '......................покупка билета....................'
      wagon.take_a_space
      puts "Осталось #{wagon.free_space} свободных мест"
    else
      puts "Грузовой вагон. Свободный объем вагона: #{wagon.free_space}"
      print 'Какой объем вагона заполнить? '
      volume = gets.to_i
      puts '......................вагон заполняется.................'
      wagon.take_a_space(volume)
      puts "Свободный объем вагона: #{wagon.free_space}"
    end
  end

  def route_choice
    puts 'Выберите маршрут по индексу:'
    show_routes
    @routes[gets.to_i - 1]
  end

  def train_choice
    puts 'Выберите поезд по индексу:'
    show_trains
    @trains[gets.to_i - 1]
  end

  def station_choice
    puts 'Выберите станцию по индексу:'
    show_stations
    @stations[gets.to_i - 1]
  end
end
