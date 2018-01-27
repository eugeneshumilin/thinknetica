class RailwayStation
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train
  end

  def depart(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def trains_type_count(type)
    @trains.count {|train| train.type == type}
  end
end

