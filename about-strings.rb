$LOAD_PATH << '.'
require 'declare'
include Declare

puts "About Strings"

str = 'He said, "Go Away"'
declare str == "He said, \"Go Away\"", true

a = %(flexible quotes can handle both ' and " characters)
b = %!flexible quotes can handle both ' and " characters!
c = %/flexible quotes can handle both ' and " characters/

declare a == b, true
declare b == c, true
declare a == c, true

# Flexible quotes are a little funkadelic
a = %["It was the best of times.It was the worst of times."]
declare (a.eql?( "It was the best of times.It was the worst of times.") ), false

# Inline string blocks are a little funkadelic
big_string = <<EOS
It was the best of times.
It was the worst of times.
EOS

another_big_string = <<GOGO
It was the best of times.
It was the worst of times.
GOGO

yet_another_big_string = "It was the best of times.
It was the worst of times."


declare big_string.eql?(another_big_string), true
declare big_string.eql?( yet_another_big_string), false

a = "a string"
b = "a string"
declare a == b, true

c = a.clone
declare a == c, true