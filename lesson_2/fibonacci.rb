fib = [0,1]
while fib[-1] + fib[-2] < 100
  fib << fib[-1] + fib[-2]
end
puts fib   

