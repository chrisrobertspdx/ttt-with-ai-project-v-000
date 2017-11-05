class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(player_1=Players::Human.new("X"),player_2=Players::Human.new("O"),board=Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def start

  end

  def current_player
    self.board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def over?
    self.board.full? || self.won?
  end

  def won?
    winner = WIN_COMBINATIONS.detect{|combination|
      if self.board.cells[combination[0]] == self.board.cells[combination[1]] && self.board.cells[combination[1]] == self.board.cells[combination[2]]
    }
    !!winner ? winner : false
  end

end
