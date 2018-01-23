print 'Введите день вашего рождения: '
day = gets.to_i
print 'Введите месяц вашего рождения: '
month = gets.to_i
print 'Введите год вашего рождения: '
year = gets.to_i

regular_year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 
  regular_year[1] = 29
end

months_to_date = regular_year.first(month - 1)

days_to_date = months_to_date.inject(0) {|result, elem| result + elem} + day

puts "День вашего рождения был #{days_to_date}-м днем с начала года!"

