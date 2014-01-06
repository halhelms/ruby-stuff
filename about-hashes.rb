$LOAD_PATH << '.'
require 'declare'
include Declare

puts "About Hashes"

hash = { a: "AAA", b: "BBB" }
hash2 = hash.clone

declare hash == hash2, true

hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

declare hash != new_hash, true

brand_new_hash = hash.merge!( new_hash )
declare brand_new_hash == new_hash, true
