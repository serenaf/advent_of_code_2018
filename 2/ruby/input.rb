characterCount = {
  2 => 0,
  3 => 0,
}


def characterMapForLine(line)
  characterMap = {}
  line.each_char do |char|
    if characterMap[char]
        characterMap[char] += 1
    else
      characterMap[char] = 1
    end
  end
  characterMap
end

File.open("input.txt").each do |line|
  characterMap = characterMapForLine(line)
  sawTwo = false
  sawThree = false
  characterMap.each do |key, value|
    break if sawTwo && sawThree
    if value == 2 && !sawTwo
      characterCount[value] +=1
      sawTwo = true
    end
    if value == 3 && !sawThree
      characterCount[value] +=1
      sawThree = true
    end
  end
end

puts characterCount[2] * characterCount[3]

