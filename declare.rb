module Declare
  def declare( declaration, value, test_message="" )
    puts "The test: #{test_message} is #{declaration == value}"
  end

end