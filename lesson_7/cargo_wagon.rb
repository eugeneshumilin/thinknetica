class CargoWagon < Wagon
  def take_a_space(volume)
    @free_space -= volume if @free_space - volume >= 0
  end
end
