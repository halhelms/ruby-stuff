puts "About Objects"
$LOAD_PATH << '.'
require 'declare'
include Declare


declare nil.object_id, 8
declare true.object_id, 20
declare false.object_id, 0

x = Object.new
y = x.clone
declare x == y, false