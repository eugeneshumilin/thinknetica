basket = {}
sum = 0
final_sum = 0

loop do
  print 'Введите наименование товара или stop для завершени программы: '
  item = gets.chomp.downcase
  break if item == 'stop'
  print 'Введите цену за единицу товара: '
  price = gets.to_f
  print 'Введите количество товара: '
  count = gets.to_f

  sum = price * count
  basket[item] = {count => price}
  final_sum += sum

  puts "Сумма за текущий товар: #{sum}$"
  puts "В корзине: #{basket}"
  puts "Итоговая сумма: #{final_sum}"
end
