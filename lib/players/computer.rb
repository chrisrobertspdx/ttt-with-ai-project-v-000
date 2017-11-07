#require_relative '../player.rb'

module Players
  class Computer < Player
    attr_reader :board
    def move(board)
      #random level
      open_cells = []
        board.cells.each_with_index{|e,i|
        if e == " "
          open_cells << i + 1
        end
      }

      # intermediate level
      win_combos = Game.win_combos
        #can we make a win combo?
        open_cells.each{|e|
          theoretical_board = Board.new
          theoretical_board.cells = board.cells.clone
          theoretical_board.update(e,self)
          winner = win_combos.detect{|combination|
            theoretical_board.cells[combination[0]] == theoretical_board.cells[combination[1]] &&
            theoretical_board.cells[combination[1]] == theoretical_board.cells[combination[2]] &&
            theoretical_board.cells[combination[0]] != " "
          }
          puts winner.inspect
        }


      s = open_cells.sample.to_s
      puts "#{self.token} picks square #{s}."
      s
    end
  end
end

#hal = Players::Computer.new("O")
#puts hal.move(["X"," "," "," ","O","X"," "," "," "])
