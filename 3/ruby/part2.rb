input = []
grid = Array.new(1000) { Array.new(1000, 0) }

input = File.open("../input.txt").each_line.map do |line|
  line.scan(/\d+/).map(&:to_i)
end

input.each do |id, x, y, w, h|
  puts "w #{w} h #{h} x #{x} y #{y}"
  h.times do |h1|
    w.times do |w1|
       if grid[y+h1][x+w1]
        grid[y+h1][x+w1] +=1
      else
        grid[y+h1][x+w1] = 1
       end
    end
  end
end

result = 0
input.each do |id, x, y, w, h|
  isIsolated = true
  h.times do |h1|
    w.times do |w1|
      if grid[y+h1][x+w1] > 1
        isIsolated = false
        break
      end
    end
    break if isIsolated == false
  end
  if isIsolated
    result = id
  end
end

puts "Result is #{result}"

