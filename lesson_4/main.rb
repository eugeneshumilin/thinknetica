require_relative 'train'
require_relative 'route'
require_relative 'railway_station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'user_interface'

puts 'Пользовательский интерфейс'
user_interface = UserInterface.new
user_interface.show_menu
user_interface.control
