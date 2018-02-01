require_relative 'instance_counter'

class RailwayStation
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    @@stations << self
  end

  def arrive(train)
    @trains << train
  end

  def depart(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def trains_type_count(type)
    @trains.count { |train| train.type == type }
  end
end
