require 'byebug'

class Cell
  attr_reader :location

  def initialize(grid, location, alive = false)
    @alive = alive
    @grid = grid
    @location = location
  end

  def alive?
    @alive
  end

  def kill
    @alive = false
  end

  def animate
    @alive = true
  end

  def living_neighbors
    num_living = 0
    @grid.valid_neighbors(@location).each do |neighbor|
      if neighbor.alive?
        num_living += 1
      end
    end
    num_living
  end
end
