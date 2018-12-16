class FileReader

  def self.read_from_file
    input = []
    File.open("input.txt") do |f|
      f.each_line do |line|
        line.strip!
        input << line
      end
    end
    input
  end
end
