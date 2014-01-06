def greet
  puts "hello"
  yield if block_given?
end

# greet{ puts " there " }
greet