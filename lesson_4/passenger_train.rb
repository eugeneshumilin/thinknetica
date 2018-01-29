class PassengerTrain < Train
  def add_wagon(wagon)
    @wagons << wagon if wagon.class == PassengerWagon && @speed == 0
  end
end

