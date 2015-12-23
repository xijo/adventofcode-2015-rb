require 'byebug'
require 'pp'

class Reindeer
  include Comparable

  # Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
  MATCHER = /(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<stamina>\d+) seconds, but then must rest for (?<pause>\d+) seconds/

  attr_accessor :name, :speed, :stamina, :pause, :score, :distance

  def initialize(line)
    match         = line.match(MATCHER)
    @name         = match['name']
    @stamina      = match['stamina'].to_i
    @pause        = match['pause'].to_i
    @speed        = match['speed'].to_i
    @score        = 0
    @distance     = 0
    @ran_for      = 0
    @rested_for   = 0
  end

  def inc
    if needs_to_rest?
      @rested_for += 1
      @ran_for = 0
    else
      @ran_for += 1
      @distance += speed
      @rested_for = 0
    end
  end

  def needs_to_rest?
    if running?
      @ran_for == stamina
    else
      @rested_for < pause
    end
  end

  def running?
    @ran_for > 0 || distance == 0
  end

  def <=>(other)
    distance <=> other.distance
  end

  def ==(other)
    name == other.name
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

2503.times do
  reindeers.each &:inc

  groups = reindeers.group_by(&:distance)
  groups[groups.keys.max].each { |r| r.score += 1 }
end

puts reindeers.group_by(&:score).keys.max
