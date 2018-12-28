require "../../utils/file_reader.rb"
require "../../8/ruby/node.rb"
require "pry"

class MemoryManeuver

  def calculate_metadata
    input = FileReader.read_from_file
    licence = input[0].split(" ")
    node = calculate_node_data(licence)
    puts calculate_result(node)
    puts calculate_root_value(node)
  end

  def calculate_node_data(licence)
    node = Node.new(licence[0], licence[1])
    licence.delete_at(0)
    licence.delete_at(0)
    node.children_count.to_i.times do
      node.add_child(calculate_node_data(licence))
    end
    node.metadata_count.to_i.times do
      node.add_metadata(licence[0])
      licence.delete_at(0)

    end
    node
  end

  def calculate_result(node)
    sum = 0
    node.children.each do |child|
      sum += calculate_result(child)
    end
    sum += node.metadata_sum
  end

  def calculate_root_value(node)
    return node.metadata_sum if node.children.empty?
    value = 0
    node.metadata.each do |metadata|
      next if node.children[metadata-1].nil?
      value += calculate_root_value(node.children[metadata-1])
    end
    value
  end

  c = MemoryManeuver.new
  c.calculate_metadata

end
