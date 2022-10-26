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

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected #= true/flase
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

  # Use a case statement that switches on the value of key
  # Depending on key, #handle_key(key) will
    # (a) return the @cursor_pos (in case of :return or :space)
    # (b) call #update_pos with the appropriate movement difference from moves and return nil (in the case of :left, :right, :up, and :down)
    # (c) exit from terminal process (in case of :ctrl_c)

  # NB: To exit a terminal process, use the Process.exit method.
  # Pass it the status code 0 as an argument. You can read more about exit here.
  def handle_key(key)
    case key
    when :return, :space
      return @cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      return nil
    when :ctrl_c
      Process.exit(0)
    end
  end

  # Use diff to reassign @cursor_pos to a new position you may wish to write a board.valid_pos?
  # to ensure you update @cursor_pos only when the new position is on the board
  # Render the square at the @cursor_pos display in a different color.
  # Test that you can move your cursor around the board by creating and calling a method that loops
  # Display#render and Cursor#get_input
  def update_pos(diff)
    dy, dx = diff
    row, col = @cursor_pos
    new_pos = [row + dy, col + dx]
    @cursor_pos = new_pos if Board.valid_pos?(new_pos)
    # change color of piece - make sure display is doing it correctly
  end
end
