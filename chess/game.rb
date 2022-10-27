require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'human_player.rb'

# Phase VI
class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(:black, @display)
    @player2 = HumanPlayer.new(:white, @display) #hash of players (or just make seperate variables for them)
    @current_player = @player2
  end

  def play
    until @board.checkmate?(@current_player.color) # add "|| no_possible_moves_left"
      system "clear"
      @display.render
      @current_player.make_move(@board)
      swap_turn!
    end
  end

  private
  def notify_players

  end

  def swap_turn!
    @current_player == player1 ? @current_player = @player2 : @current_player = @player1
  end

end

g = Game.new
g.play
