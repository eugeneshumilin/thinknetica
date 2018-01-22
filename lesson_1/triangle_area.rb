print 'Введите основание треугольника: '
a = gets.chomp.to_f

print 'Введите высоту треугольника: '
h = gets.chomp.to_f


if a > 0 && h > 0
  puts "Площадь данного треугольника: #{0.5 * a * h}"
else
  puts 'Данные некорректны'  
end  