$LOAD_PATH << '.'
require 'declare'
include Declare

puts "About Symbols"

declare :ruby.class == Symbol, true

symbol_1 = :hello
symbol_2 = :hello

declare symbol_1.object_id == symbol_2.object_id, true

declare Symbol.all_symbols.class == Array, true
declare Symbol.all_symbols.include?( :symbol_1), true

declare "hello".to_sym == :hello, true
declare :hello.to_s == "hello", true

str = "I am a string"
sym = :"This is not true: #{ str }"

declare sym.class == Symbol, true

str = "Why do people say: #{ sym }"
declare str.class == String, true