#frozen_string_literal: true

require '../../utils/file_reader.rb'

class Coordinates
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end


class Grid
  MAX_DIMENSION = 400


  def find_distance
    grid = Array.new(MAX_DIMENSION) { Array.new(MAX_DIMENSION, 0) }
    coordinates = []
    input = FileReader.read_from_file

    input.each do |line|
     coordinates <<  extract_coordinates(line)
    end

    (0..MAX_DIMENSION-1).each do |dimension_x|
      (0..MAX_DIMENSION-1).each do |dimension_y|
        compare_distance = 10000000
        compare_coordinate = Coordinates.new(dimension_x, dimension_y)
        coordinates.each do |coordinate|
          distance = manhattan_distance(coordinate, compare_coordinate)
          if compare_distance == distance
            grid[dimension_x][dimension_y] = -1
          end
          if compare_distance > distance
            grid[dimension_x][dimension_y] = coordinate
            compare_distance = distance
          end
        end
      end
    end


    (0..MAX_DIMENSION-1).each do |dimension_x|
      (0..MAX_DIMENSION-1).each do |dimension_y|
        coord = grid[dimension_x][dimension_y]
        next unless coordinates.include?(coord)
        next unless infinite_border?(dimension_x, dimension_y, MAX_DIMENSION-1) && coord !=-1
        coordinates.delete(coord)
      end
    end

    finite_coordinates = {}
    (0..MAX_DIMENSION-1).each do |dimension_x|
      (0..MAX_DIMENSION-1).each do |dimension_y|
        coord = grid[dimension_x][dimension_y]
        next unless coordinates.include?(coord)
        if finite_coordinates[coord].nil?
          finite_coordinates[coord] = 1
        else
          finite_coordinates[coord] += 1
        end
      end
    end

    max_distance = 0
    finite_coordinates.each do |key, value|
      if value > max_distance
        max_distance = value
      end
    end

    puts max_distance
  end

  def infinite_border?(x, y, size)
    x == 0 || x == size || y == 0 || y == size
  end

  def manhattan_distance(coord1, coord2)
    (coord1.x - coord2.x).abs + (coord1.y - coord2.y).abs
  end


  def extract_coordinates(line)
    split_line = line.split(",")
    Coordinates.new(split_line[1].to_i, split_line[0].to_i)
  end


  c = Grid.new
  c.find_distance

end
