require_relative 'company'

class Wagon
  include Company

  @@wagon_num = 0

  attr_reader :all_space, :free_space, :number

  def initialize(space)
    @all_space = space
    @free_space = space
    @number = @@wagon_num += 1
  end

  def occupied_space
    @all_space - @free_space
  end
end
