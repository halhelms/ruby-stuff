require 'benchmark'
require 'bigdecimal/math'
require 'ipaddr'

location = "World"


# puts Benchmark.measure{ "Hello " + location }


# puts Benchmark.measure{ "Hello " << location }


# puts Benchmark.measure{ "Hello #{ location }" }

def explicit_return
  return "Hello"
end

def implicit_return
  "Hello"
end

def merge!(array)
  array.inject({}) { |h, e| h.merge!(e => e) }
end

def merge(array)
  array.inject({}) { |h, e| h.merge(e => e) }
end

N = 1_000
array = (0..N).to_a


Benchmark.bmbm( 14 ) do |bm|
  puts "Interpolation test"
  
  bm.report( "plus operator        " ) do
    (1..1_000_000).each do |i|
      "Hello" + location
    end
  end

  bm.report( "push operator        " ) do 
    (1..1_000_000).each do |i|
      "Hello " << location 
    end
  end

  bm.report( "string Interpolation " ) do 
    (1..1_000_000).each do |i|
      "Hello #{ location }"
    end
  end

  puts ""
  puts "Implicit/Explicit return test"

  bm.report( "explicit return      " ) do
    (1..1_000).each do |i|
      explicit_return
    end
  end

  bm.report( "implicit return      " ) do
    (1..1_000).each do |i|
      implicit_return
    end
  end

  puts ""
  puts "Parallel Assignment test   "
  bm.report( "parallel assignment  " ) do
    (1..1_000_000).each do |i|
      a, b = 10, 20
    end
  end
  bm.report( "separate assignment  " ) do
    (1..1_000_000).each do |i|
      a = 10; b = 20
    end
  end
  puts ""
  puts "Destructive Method test"
  bm.report( "merge                " ) { merge array }
  bm.report( "merge!               " ) { merge! array }

end

class IPAddr
  def self.valid_ipv4?(addr)
    if /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/ =~ addr
      return $~.captures.all? {|i| i.to_i < 256}
    end
    false
  end
 
  def self.valid_ipv6?(addr)
    # IPv6 (normal)
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*\Z/ =~ addr
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*)?\Z/ =~ addr
    return true if /\A::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*)?\Z/ =~ addr
    # IPv6 (IPv4 compat)
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*:/ =~ addr && valid_ipv4?($')
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*:)?/ =~ addr && valid_ipv4?($')
    return true if /\A::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*:)?/ =~ addr && valid_ipv4?($')
    false
  end
end
 
class Bim
  attr_accessor :cls, :data
  def initialize(cls, data)
    self.cls = cls
    self.data = data
  end
  def value
    1 / 0
  rescue ZeroDivisionError
    1
  end
end
 
class Bum
  attr_accessor :cls, :data
  def initialize(cls, data)
    self.cls = cls
    self.data = data
  end
  def value
    if cls == "A"
      0
    else
      1
    end
  end
end
 
class Bam
  attr_accessor :cls, :data
  def initialize(cls, data)
    self.cls = cls
    self.data = data
  end
  def value
    if IPAddr.valid_ipv4?(data) || IPAddr.valid_ipv6?(data)
      0
    else
      1
    end
  end
end
 
puts ""

TIMES = 50_000
 
Benchmark.bmbm( 14 ) do |x|
  x.report("NS exception         ") do
    TIMES.times { b = Bim.new("NS", "ns2.foo.com"); b.value }
  end
  x.report("NS if                ") do
    TIMES.times { b = Bum.new("NS", "ns2.foo.com"); b.value }
  end
  x.report("NS regexp            ") do
    TIMES.times { b = Bam.new("NS", "ns2.foo.com"); b.value }
  end
  x.report("A exception          ") do
    TIMES.times { b = Bim.new("A", "192.168.1.1"); b.value }
  end
  x.report("A if                 ") do
    TIMES.times { b = Bum.new("A", "192.168.1.1"); b.value }
  end
  x.report("A regepx             ") do
    TIMES.times { b = Bum.new("A", "192.168.1.1"); b.value }
  end
end

class TestAccessor
  attr_accessor :a, :b

  def initialize
    @a, @b = 10, 20
  end

  def get_instance_vars
    [ a, b ]
  end
end

class TestNoAccessor

  def initialize
    @a, @b = 10, 20
  end

  def get_instance_vars
    [ @a, @b ]
  end
end

puts ""

Benchmark.bmbm( 14 ) do |bm|
  bm.report( "Using accessors    ") do
    (1..1_000_000).each do |i|
      TestAccessor.new.get_instance_vars
    end
  end

  bm.report( "Not Using accessors") do
    (1..1_000_000).each do |i|
      TestNoAccessor.new.get_instance_vars
    end
  end
end