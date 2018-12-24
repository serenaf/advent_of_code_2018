require "../../7/ruby/node.rb"
require "../../7/ruby/graph.rb"
require "../../utils/file_reader.rb"

class SumOfParts

  def initialize
    @graph = Graph.new
    @topology = []
    @selected = []
  end

  def read_graph
    input = FileReader.read_from_file
    input.each do |line|
      parse_line(line)
    end

    topological_sort(@graph)
  end

  def parse_line(line)
    from_node_name = /(?<=Step )(\w+)/.match(line)[0]
    to_node_name = /(?<=step )(\w+)/.match(line)[0]
    from_node = @graph.find_or_create_node(from_node_name)
    to_node = @graph.find_or_create_node(to_node_name)
    @graph.add_edge(from_node, to_node)
  end

  def topological_sort(graph)
    @selected = @graph.find_initial_node.sort!
    while @selected.length > 0
      traverse_node(@selected[0])
    end
    puts @topology.join("")
  end

  def no_other_incoming_edge?(node)
    node.backward_edges.all? { |backward_edge| @topology.include?(backward_edge.name) }
  end

  def traverse_node(node)
    @topology << node.name
    @selected.delete(node)
    node.forward_edges.each do |edge|
      next unless no_other_incoming_edge?(edge)
      @selected << edge
      @selected.sort!
    end
  end


  s = SumOfParts.new
  s.read_graph
end
