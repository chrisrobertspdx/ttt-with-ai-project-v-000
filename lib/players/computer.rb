#require_relative '../player.rb'

module Players
  class Computer < Player
    attr_reader :board
    def move(board)
      #auto move - center
      if board.turn_count == 0
        return 5
      end

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
          thewinner = win_combos.detect{|c|
            c.collect{|a| theoretical_board.cells[a]}.count(self.token) == 3
          }
          if !!thewinner
            puts "found winner"
            return thewinner.detect{|e|
              board.cells[e] == " "
            } + 1
          end
        }
        #can we block
        if self.token == "X"
          opp_token = "O"
        else
          opp_token = "X"
        end

        open_cells.each{|e|
          theoretical_board = Board.new
          theoretical_board.cells = board.cells.clone
          theoretical_board.cells[e] = opp_token
          theblock = win_combos.detect{|c|
            c.collect{|a| theoretical_board.cells[a]}.count(opp_token) == 3
          }
          if !!theblock
            puts "found block"
            return theblock.detect{|e|
              board.cells[e] == " "
            } + 1
          end
        }

      #take middle if available
      if !board.taken?(5)
        return 5
      end

      s = open_cells.sample.to_s
      puts "#{self.token} picks square #{s}."
      s
    end
  end
end

#hal = Players::Computer.new("O")
#puts hal.move(["X"," "," "," ","O","X"," "," "," "])
