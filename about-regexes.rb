$LOAD_PATH << '.'
require 'declare'
include Declare

puts "About Regexes"

declare /hello/.class == Regexp, true

declare "This is some content"[/content/] == "content", true
declare "This is some content"[/nada/] == nil, true

# ? afterwards makes it optional
declare "This is some content"[/contenx?t/] == "content", true
declare "This is some content"[/con[a-z]*tx?/] == "content", true

# + afterwards means one or more
declare "This is some content"[/conq+tent/] == "content", false
declare "This is some content"[/con+tent/] == "content", true

# * asterisk afterwards means 0 or more
declare "Thisss is some content"[/Th[is]*/] == "Thisss", true

# Leftmost match wins
declare "abbccc az"[/az*/] == "a", true

# character classes
animals = ["cat", "bat", "rat", "zat"]
z = animals.select { |a| a[/[cbr]at/] }
declare z.include?( "cat" ), true
declare z.include?( "bat" ), true
declare z.include?( "rat" ), true

# \d is a shortcut for digits
declare "23940506"[/\d*/] == "23940506", true

# \s is a shortcut for whitespace 
declare " \t\n"[/\s+/] == " \t\n", true

# ^is a negation
# shortcut classes can be negated with capitals
declare "123"[/\^d/] == nil, true, "shortcut characters can be negated with capitals"

declare "Hello world"[/\w*/] == "Hello", true, "\\w is a shortcut for a character"

declare "Hello olleH"[/\AH[a-z\s]*H/] == "Hello olleH", true, "\\A anchors to beginning of string"

declare "Hello olleH"[/leH\z/] == "leH", true, "\\Z anchors to end of string"

declare "Hello world"[/\bwo.../] == "world", true, "\\b anchors to beginning of word boundary"

declare "oohoohhoohoo"[/(ooh)+/] == "oohooh", true, "parentheses group things"

declare "Hello world"[/(\w+) (\w+)/, 2] == "world", true, "parentheses allow for ordered groupings"

declare "Hello world".scan(/(\w+)/).class == Array, true, "scan finds ALL conformations and turns results into array"

declare "Hello world".sub(/l/, 'a') == "Healo world", true, "sub replaces first conformation"

declare "Hello world".gsub(/l/, 'a') == "Heaao worad", true, "gsub replaces all conformations"
