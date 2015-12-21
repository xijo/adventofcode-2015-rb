input = File.read('advent-08_input')
code  = 0
chars = 0
encoded = 0

input.lines.each do |line|
  foo         = line.chomp
  foo_code    = foo.size
  foo_encoded = foo.inspect.size
  foo_esc     = foo.gsub(/\\[\\"]/, 'S').gsub(/\\x[0-9a-fA-F]{2}/, 'X')[1..-2]
  foo_char    = foo_esc.size
  # puts [foo, foo_code, foo_esc, foo_char].join("\t")

  code += foo_code
  chars += foo_char
  encoded += foo_encoded
end

puts "code:    #{code}"
puts "chars:   #{chars}"
puts "part 1: #{code - chars}"
puts "part 2: #{encoded - code}"
