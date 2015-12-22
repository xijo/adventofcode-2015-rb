class Reindeer
  # Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
  MATCHER = /(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<stamina>\d+) seconds, but then must rest for (?<pause>\d+) seconds/

  attr_accessor :name, :speed, :stamina, :pause

  def initialize(line)
    match    = line.match(MATCHER)
    @name    = match['name']
    @stamina = match['stamina'].to_i
    @pause   = match['pause'].to_i
    @speed   = match['speed'].to_i
  end

  def distance_after(seconds)
    distance = 0
    must_rest = false
    until seconds <= 0 do
      if switch_motion
        seconds -= stamina
        distance += (stamina * speed)
      else
        seconds -= pause
      end
    end
    distance
  end

  # Toggle between running and resting: true means running, false means resting
  def switch_motion
    @motion = !@motion
  end
end

input =<<-EOS
Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.
Rudolph can fly 3 km/s for 15 seconds, but then must rest for 28 seconds.
Donner can fly 19 km/s for 9 seconds, but then must rest for 164 seconds.
Blitzen can fly 19 km/s for 9 seconds, but then must rest for 158 seconds.
Comet can fly 13 km/s for 7 seconds, but then must rest for 82 seconds.
Cupid can fly 25 km/s for 6 seconds, but then must rest for 145 seconds.
Dasher can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Dancer can fly 3 km/s for 16 seconds, but then must rest for 37 seconds.
Prancer can fly 25 km/s for 6 seconds, but then must rest for 143 seconds.
EOS

reindeers = []
input.each_line { |l| reindeers << Reindeer.new(l) }

puts reindeers.map { |r| r.distance_after(2503) }.max
