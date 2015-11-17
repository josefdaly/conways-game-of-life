require_relative './grid.rb'

class Game
  def initialize(height, width, starting_locations = [])
    @grid = Grid.new(height, width, starting_locations)
    @height = height
    @width = width
  end

  def step
    cells_to_kill = []
    cells_to_animate = []
    (0...@height).each do |y|
      (0...@width).each do |x|
        cell = @grid[[x,y]]
        live_neighbors = cell.living_neighbors
        if cell.alive?
          if live_neighbors < 2 || live_neighbors > 3
            cells_to_kill.push(cell)
          end
        else
          cells_to_animate.push(cell) if live_neighbors == 3
        end
      end
    end

    [[cells_to_kill, :kill], [cells_to_animate, :animate]].each do |action_group|
      self.do_to_group(action_group.first, action_group.last)
    end
  end

  def do_to_group(items, action)
    items.each { |item| item.send(action) }
  end

  def run
    while true
      @grid.render
      self.step
      sleep(1.0/3.0)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  starting_pos = [[2,1],[3,3],[2,3],[4,2],[1,2],[3,1]]
  game = Game.new(30,60)
  game.run
end
