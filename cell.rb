class Cell
  attr_accessor :alive

  def initialize(grid, location, alive = false)
    @alive = alive
    @grid = grid
    @location = location
  end

  def alive?
    @alive
  end

  def living_neighbors
  end
end
