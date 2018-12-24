class Node
  include Comparable

  attr_accessor :name, :forward_edges, :backward_edges

  def initialize(name)
    @name = name
    @forward_edges = []
    @backward_edges = []
  end

  def <=>(other)
    name <=> other.name
  end

  def has_no_incoming_edge?
    backward_edges.empty?
  end

end
