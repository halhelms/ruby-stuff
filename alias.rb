def old_method
  puts "I am the old method"
end

alias old_old_method old_method

def old_method
  puts "turns out I'm not as old as i thought"
end

old_method
old_old_method