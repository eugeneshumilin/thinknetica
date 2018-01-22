print 'Введите длину первой стороны треугольника: '
a = gets.to_f

print 'Введите длину второй стороны треугольника: '
b = gets.to_f

print 'Введите длину третьей стороны треугольника: '
c = gets.to_f


if a == b && b == c
  puts 'Треугольник равнобедренный и равносторонний'
  exit
end


if a > b && a > c
  hypotenuse = a
  cathetus1 = b
  cathetus2 = c
elsif b > a && b > c
  hypotenuse = b
  cathetus1 = a
  cathetus2 = c
elsif c > b && c > a
  hypotenuse = c
  cathetus1 = a
  cathetus2 = b
end

if (hypotenuse**2 == cathetus1**2 + cathetus2**2) && cathetus1 == cathetus2
  puts 'Треугольник прямоугольный и равнобедренный'
elsif hypotenuse**2 == cathetus1**2 + cathetus2**2
  puts 'Треугольник прямоугольный'
elsif cathetus1 == cathetus2
  puts 'Треугольник равнобедренный'    
else
  puts 'Треугольник не прямоугольный, не равнобедренный и не равносторонний'
end