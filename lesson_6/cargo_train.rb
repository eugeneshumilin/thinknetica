class CargoTrain < Train
  private

  def check_class(wagon)
    wagon.class == CargoWagon
  end
end
