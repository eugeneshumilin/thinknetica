arr = [10]
loop do
  arr << arr.last + 5
  break if arr.last >= 100
end
puts arr
