arr = (10..100).to_a

arr.delete_if {|i| i % 5 != 0}

puts arr

