x = nil

class Object
  def blank?
    return true if self.nil?
    return true if self.length == 0 rescue "Huh?"
  end
end

puts x.nil? == true
y = ""
z = {}
a = []
puts x.blank?
puts y.blank?
puts z.blank?
puts a.blank?
puts nil.to_s == ""
