require_relative './cell.rb'
require 'colorize'
require 'io/console'

class Grid
  attr_accessor :grid

  def initialize(height, width, living_cells = [])
    @cursor_pos = [-1,-1]
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
    select_starting if living_cells.length == 0
  end

  def select_starting
    pos = [0,0]
    @cursor_pos = [0,0]
    while pos.first.between?(0,@width - 1) && pos.last.between?(0,@height - 1)
      pos = move_cursor
      if pos.first.between?(0,@width - 1) && pos.last.between?(0,@height - 1)
        if self[[pos.first, pos.last]].alive?
          self[[pos.first, pos.last]].kill
        else
          self[[pos.first, pos.last]].animate
        end
      end
    end
  end

  def move_cursor
    input = ""
    until input == "\r"
      render
      input = STDIN.getch
      @cursor_pos[1] += 1 if input == 'k'
      @cursor_pos[1] -= 1 if input == 'i'
      @cursor_pos[0] -= 1 if input == 'j'
      @cursor_pos[0] += 1 if input == 'l'
    end
    @cursor_pos.dup
  end

  def [](pos)
    @grid[pos.last][pos.first]
  end

  def render
    system('clear')
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if [x,y] == @cursor_pos
          print '  '.colorize(background: :yellow)
        elsif cell.alive?
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
    [[0,1],[1,0],[0,-1],[-1,0],[1,1],[-1,-1],[1,-1],[-1,1]].each do |dir|
      new_pos = [dir.first + pos.first, dir.last + pos.last]
      if new_pos.first.between?(0, @width - 1) && new_pos.last.between?(0, @height - 1)
        valid_neighbors.push(self[new_pos])
      end
    end
    valid_neighbors
  end
end
