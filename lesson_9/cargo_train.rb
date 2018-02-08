class CargoTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  private

  def check_class(wagon)
    wagon.is_a?(CargoWagon)
  end
end
