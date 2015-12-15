@distances = {}
@destinations = []

def add_distance(input)
  destinations, length = input.split(' = ')
  a, b = destinations.split(' to ')
  @distances[a] ||= {}
  @distances[a][b] = length
  @distances[b] ||= {}
  @distances[b][a] = length
  @destinations << a
  @destinations << b
end

add_distance 'AlphaCentauri to Snowdin = 66'
add_distance 'AlphaCentauri to Tambi = 28'
add_distance 'AlphaCentauri to Faerun = 60'
add_distance 'AlphaCentauri to Norrath = 34'
add_distance 'AlphaCentauri to Straylight = 34'
add_distance 'AlphaCentauri to Tristram = 3'
add_distance 'AlphaCentauri to Arbre = 108'
add_distance 'Snowdin to Tambi = 22'
add_distance 'Snowdin to Faerun = 12'
add_distance 'Snowdin to Norrath = 91'
add_distance 'Snowdin to Straylight = 121'
add_distance 'Snowdin to Tristram = 111'
add_distance 'Snowdin to Arbre = 71'
add_distance 'Tambi to Faerun = 39'
add_distance 'Tambi to Norrath = 113'
add_distance 'Tambi to Straylight = 130'
add_distance 'Tambi to Tristram = 35'
add_distance 'Tambi to Arbre = 40'
add_distance 'Faerun to Norrath = 63'
add_distance 'Faerun to Straylight = 21'
add_distance 'Faerun to Tristram = 57'
add_distance 'Faerun to Arbre = 83'
add_distance 'Norrath to Straylight = 9'
add_distance 'Norrath to Tristram = 50'
add_distance 'Norrath to Arbre = 60'
add_distance 'Straylight to Tristram = 27'
add_distance 'Straylight to Arbre = 81'
add_distance 'Tristram to Arbre = 90'

result = 0

@destinations.uniq.permutation.each do |way|
  i = 0
  while way.size > 1
    i += @distances[way[0]][way[1]].to_i
    way.shift
  end
  if i > result
    result = i
  end
end

puts result
