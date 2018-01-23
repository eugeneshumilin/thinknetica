alphabet = ('a'..'z').to_a
vowels = %w(a e i o u y)

vowels_list = {}

alphabet.each_with_index do |key, index|
  vowels_list[key] = index + 1 if vowels.include?(key)
end

vowels_list.each do |letter, index|
  puts "Гласная #{letter.upcase} #{index}-я по счёту буква в английском алфавите"
end  
