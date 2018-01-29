class CargoTrain < Train
  def add_wagon(wagon)
    @wagons << wagon if wagon.class == CargoWagon && @speed == 0
  end
end

