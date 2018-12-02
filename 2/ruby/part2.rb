lines = []
commonCharacters = ""
File.open("../input.txt").each do |line|
  lines << line
end

def compareCharacters(str1, str2)
  numberOfDifferences = 0
  chars1 = str1.split("")
  chars2 = str2.split("")

  chars1.each_with_index do |char, index|
    break if numberOfDifferences > 1
    if char != chars2[index]
      numberOfDifferences+=1
    end
  end
  numberOfDifferences == 1 ? true :false
end

def findCommonCharacters(str1, str2)
  commonChars = ""
  chars1 = str1.split("")
  chars2 = str2.split("")

  chars1.each_with_index do |char, index|
    if char == chars2[index]
      commonChars += char
    end
  end
  commonChars
end


for i in 0..lines.length-1 do
  for j in i+1..lines.length-1 do
    almostMatchingLines = compareCharacters(lines[i], lines[j])
    if almostMatchingLines
      commonCharacters = findCommonCharacters(lines[i], lines[j])
      break
    end
  end
end

puts "Common character is #{commonCharacters}"


