require_relative "player"

class ComputerPlayer < Player
  attr_accessor :values
  def initialize(name, color)
    super
    set_values
  end

  def set_values
    
  end

  def get_move(display)

    all_moves = []
    display.board.grid.each_with_index do |row, ridx|
      row.each_with_index do |square, cidx|
        if (square != nil && square.color == @color)
          unless square.valid_moves.empty?
            start_pos = [ridx, cidx]
            square.valid_moves.each do |end_pos|
              all_moves.push([start_pos, end_pos])
            end
          end
        end
      end
    end
    smart_move = []

    all_moves.each do |move|
      unless (display.board[move[1]] == nil ||
        display.board[move[1]].color == @color)

        smart_move = move
        break
      end
    end

    smart_move = all_moves.shuffle.first if smart_move.empty?

    display.render
    p "computer moved from #{smart_move[0]} to #{smart_move[1]}"
    smart_move
  end
end
