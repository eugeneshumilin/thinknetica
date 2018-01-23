print 'Введите коэффициент a: '
a = gets.to_f
print 'Введите коэффициент b: '
b = gets.to_f
print 'Введите коэффициент c: '
c = gets.to_f

d = b**2 - 4 * a * c

if d > 0
  math_sqrt = Math.sqrt(d)
  x1 = (-b + math_sqrt / (2 * a)
  x2 = (-b - math_sqrt / (2 * a)
  puts "Дискриминант равен #{d}. Корень 1 равен #{x1}, Корень 2 равен #{x2}"
elsif d == 0
  x = -b / (2 * a)
  puts "Дискриминант равен #{d}, корень равен #{x}"
else
  puts "Дискриминант равен #{d}, корней нет. Точнее есть, но они будут мнимыми числами :)"
end
