module YeOlde
  def hello( subject="World" )
    if defined?( super )
      super
    else
      "Good morrow, #{subject }"
    end
    puts "Well met indeed!"
  end
end



module Logged
  def logged_send( name, *args, &block )
    original_send = Object.instance_method( :send )
    bound_send = original_send.bind( self )
    puts "Sending #{ name }( #{args.map( &:inspect ).join(', ' ) } )"
    # bound_send.call( name, *args, *block )
    __send__( name, *args, &block )
  end
end

module PigeonPost
  def send( *messages )
    puts "Your message is winging its way to folks"
  end
end

class Greeter
  include PigeonPost
  include Logged 
  def hello( subject )
    puts "Hello, #{ subject }"
  end
end


class GreeterChild < Greeter
  include YeOlde
end

class NonGreeter
  include YeOlde
end

Greeter.new.logged_send( :hello, "Major Tom" )

