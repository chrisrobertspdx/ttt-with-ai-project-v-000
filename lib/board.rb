class board
  attr_accessor :cells
  def initialize
    @cells = Array.new(9," ")
  end
  def reset
    self.cells.fill(" ")
  end
end
