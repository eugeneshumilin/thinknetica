class RailwayStation
  attr_accessor :name

  def initialize(name)
    self.name = name
    @trains = {}
  end

  def arrive(train_number, train_type)
    @trains[train_number] = train_type
    puts "#{train_type} поезд номер #{train_number} прибыл на станцию #{name}"
  end

  def depart(train_number)
    if @trains.include?(train_number)
      @trains.delete(train_number)
      puts "#{@trains[train_number]} поезд номер #{train_number} уехал со станции #{name}"
    else
      puts "Такого поезда нет на станции"  
    end
  end

  def current_list
    if @trains.empty?
      puts "На станции нет ни одного поезда"
    else
      puts "На станции сейчас находятся следующие поезда:" 
      @trains.each do |number, type|
        puts "#{number} - #{type}"
      end
    end  
  end

  def type_list
    cargo = @trains.values.find_all{ |type| type == 'cargo' }.size
    passenger = @trains.values.find_all{ |type| type == 'passenger' }.size
    puts "В данный момент на станции #{cargo} грузовых поездов и #{passenger} пассажирских"        
  end
end

