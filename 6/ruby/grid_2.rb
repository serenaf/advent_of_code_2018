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
  MAX_VALUE = 10000


  def calculate_distance
    grid = Array.new(MAX_DIMENSION) { Array.new(MAX_DIMENSION, 0) }
    coordinates = []
    input = FileReader.read_from_file

    input.each do |line|
     coordinates <<  extract_coordinates(line)
    end

    region = []
    (0..MAX_DIMENSION-1).each do |dimension_x|
      (0..MAX_DIMENSION-1).each do |dimension_y|
        compare_coordinate = Coordinates.new(dimension_x, dimension_y)
        compare_distance = 0
        coordinates.each do |coordinate|
          distance = manhattan_distance(coordinate, compare_coordinate)
          compare_distance += distance
        end
        if compare_distance < MAX_VALUE
          region << compare_coordinate
        end
      end
    end

    puts region.length

  end


  def manhattan_distance(coord1, coord2)
    (coord1.x - coord2.x).abs + (coord1.y - coord2.y).abs
  end


  def extract_coordinates(line)
    split_line = line.split(",")
    Coordinates.new(split_line[1].to_i, split_line[0].to_i)
  end


  c = Grid.new
  c.calculate_distance

end
