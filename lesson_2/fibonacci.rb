fib = []
fib[0] = 0
fib[1] = 1
n = 1

while fib[n] + fib[n - 1] < 100
  n += 1
  fib[n] = fib[n - 1] + fib[n - 2]   
end

puts fib

