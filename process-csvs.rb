def separate_csvs( line )
  line.split( ',' ).each{ |value| puts value.strip }
end

ARGF.each_line do |line|
  separate_csvs( line )
end