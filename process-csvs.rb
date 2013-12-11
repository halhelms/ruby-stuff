def is_correct_length( text )
  text.length == 3
end

def is_numeric( text )
  true if Float(text) rescue false
end


def is_valid( text )
  is_correct_length( text ) && is_numeric( text )
end

def separate_csvs( line )
  File.open( 'errors.txt', 'w' ) { |file| file.write( '' ) }
  line.split( ',' ).each do |value| 
    trimmed_value = value.strip
    if is_valid( trimmed_value )
      puts trimmed_value
    else
      File.open('errors.txt', 'a') { |file| file.write("Problem with #{ trimmed_value }\n") }  
    end
  end
end

ARGF.each_line do |line|
  separate_csvs( line )
end