require "../../7/ruby/node.rb"
require "../../7/ruby/graph.rb"
require "../../utils/file_reader.rb"
require "pry.rb"

class SumOfPartsWorkerEdition

  NUM_WORKERS = 2
  MIN_TIME = 0

  def initialize
    @graph = Graph.new
    @completed = []
    @available = []
    @worker_task = {}
    @traversed = {}

    (0..NUM_WORKERS-1).each do |worker|
      @traversed[worker] = []
      @worker_task[worker] = -1
   end
  end

  def read_graph
    input = FileReader.read_from_file
    input.each do |line|
      parse_line(line)
    end

    topological_sort(@graph)
  end

  def topological_sort(graph)
    current_time = 0
    @available = @graph.find_initial_node.sort!
    while @completed.length < @graph.nodes.length do
      available_workers = find_available_workers(current_time)
      available_workers.each do |worker|
        next if @available[0].nil?
        traverse(@available[0], worker, current_time)
      end
      calculate_available_nodes(current_time)
      current_time += 1
    end
  end

  def calculate_available_nodes(current_time)

  end

  def traverse(node, worker, current_time)
    @traversed[worker] << node
    @worker_task[worker] = current_time + task_time_for_char(node.name)
    @completed << node
    @available.delete(node)
    puts "Adding #{node.name} to #{worker} at #{current_time} for #{@worker_task[worker]}"
  end


  def find_available_workers(current_time)
    available_workers = []
    (0..NUM_WORKERS-1).each do |worker|
      available_workers << worker if @worker_task[worker] <= current_time
    end
    available_workers
  end

  def parse_line(line)
    from_node_name = /(?<=Step )(\w+)/.match(line)[0]
    to_node_name = /(?<=step )(\w+)/.match(line)[0]
    from_node = @graph.find_or_create_node(from_node_name)
    to_node = @graph.find_or_create_node(to_node_name)
    @graph.add_edge(from_node, to_node)
  end

  def task_time_for_char(char)
    (1 + char.ord - ?A.ord) + MIN_TIME
  end

  s = SumOfPartsWorkerEdition.new
  s.read_graph
end
