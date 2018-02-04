class UserInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def show_menu
    [
      '1 - Создать станцию', '2 - Создать поезд', '3 - Создать маршрут',
      '4 - Добавить станцию в маршрут', '5 - Удалить станцию из маршрута',
      '6 - Назначить маршрут поезду', '7 - Добавить вагон к поезду',
      '8 - Отцепить вагон от поезда',
      '9 - Переместить поезд вперед по маршруту',
      '10 - Переместить поезд назад по маршруту',
      '11 - Посмотреть список станций',
      '12 - Посмотреть список поездов на станции',
      '13 - Посмотреть список всех поездов с вагонами на станциях(NEW)',
      '14 - Заполнить вагон(NEW)', '15(exit) - Выход', '16(help) - Меню'
    ].each { |point| puts point }
  end

  def control
    loop do
      actions = {
        '1' => method(:create_station),
        '2' => method(:create_train),
        '3' => method(:create_route),
        '4' => method(:add_station_to_route),
        '5' => method(:delete_station_from_route),
        '6' => method(:set_route_to_train),
        '7' => method(:add_wagon_to_train),
        '8' => method(:remove_wagon_from_train),
        '9' => method(:forward),
        '10' => method(:back),
        '11' => method(:show_stations),
        '12' => method(:list_of_trains),
        '13' => method(:show_each_train_on_stations),
        '14' => method(:fill_wagon),
        '15' => method(:exit), 'exit' => method(:exit),
        '16' => method(:show_menu), 'help' => method(:show_menu)
      }
      print 'Выберите действие: '
      input = gets.chomp
      if actions[input].nil?
        puts 'Некорректный ввод. Повторите...'
      else
        actions[input].call
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
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    puts 'Выберите начальную и конечную станции маршрута по индексу:'
    show_stations
    route = Route.new(@stations[gets.to_i - 1], @stations[gets.to_i - 1])
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
    print 'Введите кол-во мест, если вагон пассажирский,
     и объем, если вагон грузовой: '
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
    @trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number} - #{train.class}"
    end
  end

  def show_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  def show_routes
    @routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}"
    end
  end

  def show_each_train_on_stations
    @stations.each do |station|
      puts "#{station.name}:"
      station.each_train do |train|
        puts "#{train.number} - #{train.class} - #{train.wagons.size}"
        train.each_wagon do |wagon|
          puts "#{wagon.number} - #{wagon.class} - #{wagon.free_space} -
           #{wagon.occupied_space}"
        end
      end
    end
  end

  def fill_wagon
    train = train_choice
    puts "#{train.class} номер #{train.number} - #{train.wagons.size} вагонов"
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
