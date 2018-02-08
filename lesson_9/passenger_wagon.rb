class PassengerWagon < Wagon
  def take_a_space
    @free_space -= 1 unless @free_space.zero?
  end
end
