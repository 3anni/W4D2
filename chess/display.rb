require_relative 'cursor.rb'
require_relative 'board.rb'

require 'colorize'
require 'byebug'





class Display

    def initialize(board)
      @board = board
      @cursor = Cursor.new([0,0],board)
    end

    def render
      print "  "
      (0..7).each { |ci| print ci } # column headers
      puts

      @board.rows.each_with_index do |row, ri|
          print ri.to_s + " "

          row.each_with_index do |el, ci|
            color = @board[[ri, ci]].color || :white
            if @cursor.cursor_pos == [ri, ci]
                #debugger
              print el.to_s.bg_gray
            else
              print el.to_s
            end
          end

          puts
      end

      return nil
    end

    def test
        while true
          render
          @cursor.get_input
          system "clear" #print "\e[2J\e[f"
        end
    end
end

class String
  def bg_gray;
    # self = "\e[0;30;49m♖\e[0m"
    i = self[10]
    #"\e[47m#{self}\e[0m"
    "\e[47m#{i}\e[0m"
  end
end


b = Board.new
d = Display.new(b)
d.test
