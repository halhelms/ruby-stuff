$LOAD_PATH << '.'
require 'declare'
include Declare

arr = [ :peanut, :butter, :and, :jelly ]
declare arr[4], nil
declare arr[4,0], []
declare arr[5], nil
declare arr[5,0], nil

declare (1..5).class, Range
declare (1..5).to_a, [1,2,3,4,5]
declare (1...5).to_a, [1,2,3,4]

arr.pop
declare arr, [:peanut, :butter, :and]

arr = [:a, :b, :c, :d]
declare arr.shift, :a
declare arr, [:b, :c, :d]
declare (arr.unshift :a), [:a, :b, :c, :d]

first_name, last_name = "John","Smith", "III"
declare( first_name, "John" )
declare( last_name, "Smith" )

first_name, *last_name = "John", "Smith", "III"
declare last_name, %w( Smith III)

first_name, last_name = ["John", "Smith"]
declare first_name, "John"
declare last_name, "Smith"

first_name, last_name = ["John", "Smith", "III"]
declare first_name, "John"
declare last_name, "Smith"

first_name, *last_name = ["John", "Smith", "III"]
declare first_name, "John"
declare last_name, ["Smith", "III"]

*first_name, last_name = ["John", "Smith", "III"]
declare first_name, ["John", "Smith"]
declare last_name, "III"

first_name, last_name = ["Cher"]
declare first_name, "Cher"
declare last_name, nil

