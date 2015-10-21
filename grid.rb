require_relative './cell.rb'
require 'colorize'

class Grid
  attr_accessor :grid

  def initialize(height, width, living_cells = [])
    @height = height
    @width = width
    @grid = Array.new(height) do |y|
      Array.new(width) do |x|
        if living_cells.include?([x,y])
          Cell.new(self, [x, y], true)
        else
          Cell.new(self, [x, y], false)
        end
      end
    end
  end

  def [](pos)
    @grid[pos.last][pos.first]
  end

  def render
    @grid.each do |row|
      row.each do |cell|
        if cell.alive?
          print '  '.colorize(background: :green)
        else
          print '  '.colorize(background: :black)
        end
      end
      puts
    end
  end

  def valid_neighbors(pos)
    valid_neighbors = []
    [[0,1],[1,0],[0,-1],[-1,0]].each do |dir|
      new_pos = [dir.first + pos.first, dir.last + pos.last]
      if new_pos.first.between?(0, @width - 1) && new_pos.last.between?(0, @height - 1)
        valid_neighbors.push(self[new_pos])
      end
    end
    valid_neighbors
  end
end
