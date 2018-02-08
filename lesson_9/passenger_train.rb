class PassengerTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  private

  def check_class(wagon)
    wagon.is_a?(PassengerWagon)
  end
end
