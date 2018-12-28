class Node
  attr_accessor :children_count, :metadata_count, :children, :metadata

  def initialize(children_count, metadata_count)
    @children_count = children_count
    @metadata_count = metadata_count
    @children = []
    @metadata = []
  end

  def add_child(child)
    @children << child
  end

  def add_metadata(metadata)
    @metadata << metadata.to_i
  end

  def metadata_sum
    @metadata.reduce(:+)
  end

end
