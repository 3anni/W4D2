require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}


MOVES = {
  left: [0, -1], # [y, x]
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected_piece

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
    @selected_piece = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def toggle_selected
    @selected ? @selected = false : @selected = true
  end

  private
  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  # Move cursor
  def handle_key(key)
    case key

      # (a) return the @cursor_pos (in case of :return or :space)
    when :return, :space
      toggle_selected
      if @selected
        if @board[@cursor_pos].instance_of?(NullPiece)
          puts "Can't select an empty square"
          sleep(1)
          toggle_selected
        else
          @selected_piece = @board[@cursor_pos]
        end
      else
        if @selected_piece.valid_moves.include?(@cursor_pos)
          @board.move_piece(@selected_piece.color,@selected_piece.pos,@cursor_pos)
        end

        @selected_piece = nil
      end
      return @cursor_pos

    # (b) call #update_pos with the appropriate movement difference from moves and return nil (in the case of :left, :right, :up, and :down)
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      return nil

    # (c) exit from terminal process (in case of :ctrl_c)
    when :ctrl_c
      Process.exit(0)
    end
  end

  # Update cursor position if diff yields a valid_position on the bord
  def update_pos(diff)
    dy, dx = diff
    row, col = @cursor_pos
    new_pos = [row + dy, col + dx]
    @cursor_pos = new_pos if Board.valid_pos?(new_pos)
    # change color of piece - make sure display is doing it correctly
  end
end
