require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  attr_accessor :board, :cursor_pos, :selected

  def initialize(board)
    @cursor_pos = [0,0]
    @board = board
    @selected = []
  end

  def set_selected(pos)
    @selected = pos
  end

  def render
    system("clear")
    @board.grid.each_with_index do |row,ridx|
      row.each_with_index do |square,cidx|
        bg = :light_cyan
        if (ridx + cidx) % 2 == 0
          bg = :light_white
        end
        if cursor_pos == [ridx, cidx]
          if square == nil
            print "    ".colorize(:background => :magenta)
          else
            print square.render.colorize(:background => :magenta)
          end
        elsif selected == [ridx, cidx]
          if square == nil
            print "    ".colorize(:background => :light_yellow)
          else
            print square.render.colorize(:background => :light_yellow)
          end
        else
          if square == nil
            print "    ".colorize(:color => :black, :background => bg)
          else
            print square.render.colorize(:color => :black, :background => bg)
          end
        end
      end
      print "\n"
    end
  end
end
