x = 10
5.times do |x|
  puts "x inside the block is #{ x }"
end

puts "x outside the block is #{ x }"