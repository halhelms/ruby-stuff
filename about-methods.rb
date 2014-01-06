$LOAD_PATH << '.'
require 'declare'
include Declare

puts "About Methods"

def global_method( arg)
  arg
end

declare global_method( 'hello' ) == 'hello', true, "methods can exist detached from any user-defined classes"