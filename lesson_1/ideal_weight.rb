print 'Введите Ваше имя: '
name = gets.chomp.capitalize

print 'Введите Ваш рост в см: '
height = gets.to_f

ideal_weight = height - 110

if ideal_weight >= 0
  puts "Привет #{name}, Ваш идеальный вес #{ideal_weight}"
else
  puts 'Ваш вес уже идеальный'
end