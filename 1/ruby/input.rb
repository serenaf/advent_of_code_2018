require 'set'

sum = 0
numbers = []
frequency = Set.new
File.open("input.txt").each do |line|
  numbers << line.to_i
end

numbers.cycle do |number|
  sum +=number
  (puts sum; break) if frequency.include?(sum)
  frequency.add(sum)
end

