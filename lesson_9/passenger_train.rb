class PassengerTrain < Train
  private

  def check_class(wagon)
    wagon.is_a?(PassengerWagon)
  end
end
