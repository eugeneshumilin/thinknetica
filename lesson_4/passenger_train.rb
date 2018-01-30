class PassengerTrain < Train
  private

  def check_class(wagon)
    wagon.class == PassengerWagon
  end
end

