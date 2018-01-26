class RailwayStation
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    trains << train
  end

  def depart(train)
    trains.delete(train) if trains.include?(train)
  end

  def trains_cargo_type
    trains.count {|train| train.type == :cargo}
  end

  def trains_passenger_type
    trains.count {|train| train.type == :passenger}
  end
end
