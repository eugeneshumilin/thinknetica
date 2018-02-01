basket = {}
final_sum = 0

loop do
  print 'Введите наименование товара или stop для завершени программы: '
  item = gets.chomp.downcase
  break if item == 'stop'
  print 'Введите цену за единицу товара: '
  price = gets.to_f
  print 'Введите количество товара: '
  count = gets.to_f

  basket[item] = {price: price, count: count}
  final_sum += price * count
end

basket.each do |product, props|
  puts "Товар: #{product}\nЦена за ед.: #{props[:price]}\nКол-во ед. товара: #{props[:count]}"
end

puts "Итоговая сумма заказа: #{final_sum}"
