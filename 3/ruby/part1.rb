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

puts grid.flatten.select { |cell| cell > 1 }.count
