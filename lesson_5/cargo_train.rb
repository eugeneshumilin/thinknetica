class CargoTrain < Train
  private

  def check_class(wagon)
    wagon.is_a?(CargoWagon)
  end
end
