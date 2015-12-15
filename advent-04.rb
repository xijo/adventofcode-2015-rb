require 'digest'

class ZeroFinder
  def initialize(input, zeros = 5)
    @input   = input
    @zeros   = '0' * zeros
    @current = 0
  end

  def perform
    result = md5
    while !result.start_with?('000000') do
      @current += 1
      result = md5
    end
    @current
  end

  def md5
    Digest::MD5.hexdigest("#{@input}#{@current}")
  end
end

# input          = 'iwrupvqb'
# current_number = 0
# result         = Digest::MD5.hexdigest("#{input}0")


puts ZeroFinder.new('iwrupvqb', 5).perform
