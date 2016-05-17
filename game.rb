require_relative "board"
require_relative "display"

class Game
  attr_accessor :board, :player1, :player2, :cur_player, :display

  def initialize(board, player1 = :white, player2 = :black)
    @board = board
    @player1 = player1
    @cur_player = player1
    @player2 = player2
    @display = Display.new(board)
    @board.populate
  end

  def play
    until @board.over?
      if @board.in_check?(@cur_player)
        puts "#{@cur_player} is in check"
      end
      play_turn
    end
    next_player
    @display.render
    puts "Checkmate! #{@cur_player} wins! "
  end

  def play_turn
    @display.render
    p "#{@cur_player}'s turn"
    begin
    move = []
    while move.length < 2
      input = @display.get_input
      @display.render
      p "#{@cur_player}'s turn"
      unless input == nil
        move.push(input)
      end
      if move.length == 1
        @display.set_selected(move.first)
      end
    end
      @display.set_selected([])
      @board.move(move[0], move[1], cur_player)
      next_player
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def next_player
    if (@cur_player == :white)
      @cur_player = :black
    else
      @cur_player = :white
    end
  end


end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  game = Game.new(board)
  game.play
end
