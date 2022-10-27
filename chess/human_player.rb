require_relative 'player.rb'
require "byebug"


class HumanPlayer < Player

  def make_move(board)
    user_input = @display.cursor.get_input
    until user_input.nil?
      @display.render
      user_input = @display.cursor.get_input
      puts "user_input = #{user_input}"
    end

    until !user_input.nil?
      user_input = @display.cursor.get_input
    end
  end
end

