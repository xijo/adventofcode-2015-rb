class PasswordFinder
  def initialize(current)
    @current = current.dup
  end

  def find_next
    @current.next!
    until good? do
      @current.next!
    end
    @current
  end

  def good?
    valid_chars? && two_doubles? && three_consecutive?
  end

  def valid_chars?
    !(@current =~ /[iol]/)
  end

  def two_doubles?
    @current.scan(/(.)(?=\1)[^\1]/).size >= 2
  end

  def three_consecutive?
    count = 1
    @current.each_char.inject('') do |m, c|
      m.next == c ? count += 1 : count = 1
      count == 3 and return true
      c
    end
    false
  end
end

current         = 'hxbxwxba'
first_password  = PasswordFinder.new(current).find_next
second_password = PasswordFinder.new(first_password).find_next

puts first_password
puts second_password
