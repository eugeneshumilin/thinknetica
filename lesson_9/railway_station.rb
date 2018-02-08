require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class RailwayStation
  include InstanceCounter
  include Validation
  include Accessors

  attr_reader :name, :trains

  validate :name, :presence

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
end
