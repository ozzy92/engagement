# helpers for cost centers and mail codes
module CodeGenerator

  def random_digits(count)
    ((1..count).collect { rand(1...10) }.collect { |n| n.to_s }).join('')
  end

  def random_chars(count)
    ((1..count).collect { ("A".ord + rand(0...26)).chr }).join('')
  end

end