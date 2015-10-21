require_relative './cell.rb'
require 'colorize'

class Grid
  attr_accessor :grid

  def initialize(height, width)
    @grid = Array.new(height) do |y|
      Array.new(width) do |x|
        Cell.new(self, [x, y], false)
      end
    end
  end

  def [](pos)
    @grid[pos.first][pos.last]
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
    [[0,1],[1,0],[0,-1],[-1,0],[1,1],[-1,-1],[-1,1],[1,-1]].each do |dir|

end
