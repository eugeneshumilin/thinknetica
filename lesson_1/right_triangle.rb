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

sides = [a, b, c]
sides.sort!

if sides[1] == sides[2]
  puts 'Треугольник равнобедренный'
  exit
else
  cathetus1 = sides[0]
  cathetus2 = sides[1]
  hypotenuse = sides[2]
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
