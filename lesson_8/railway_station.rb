require_relative 'instance_counter'
require_relative 'valid'

class RailwayStation
  include InstanceCounter
  include Valid

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    register_instance
    @name = name
    validate!
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

  def each_train
    @trains.each { |train| yield(train) } if block_given?
  end

  protected

  def validate!
    raise 'Name cannot be nil' if @name.nil?
    raise 'Name cannot be shorter than 2 letters' if @name.length < 2
    raise 'Name cannot be duplicated' if @@stations.map(&:name).include?(@name)
    true
  end
end
