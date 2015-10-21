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
    self.do_to_group(cells_to_kill, 'kill'.to_sym)
    self.do_to_group(cells_to_animate, 'animate'.to_sym)
  end

  def do_to_group(items, action)
    items.each { |item| item.send(action) }
  end

  def run
    while true
      @grid.render
      self.step
      gets
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(20,20,[[1,0],[2,0],[2,1],[1,2]])
  game.run
end
