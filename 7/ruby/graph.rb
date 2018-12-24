class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def find_or_create_node(name)
    node = find_node(name)
    if node.nil?
      node = add_node(name)
    end
    node
  end

  def add_edge(from_node, to_node)
    from_node.forward_edges << to_node
    to_node.backward_edges << from_node
  end

  def find_initial_node
    nodes.select { |n| n.backward_edges.empty? }
  end

  private

  def find_node(name)
    nodes.select { |n| n.name == name}.first
  end

  def add_node(name)
    node = Node.new(name)
    nodes << node
    node
  end


end
