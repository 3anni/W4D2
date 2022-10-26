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
      ("a".."h").to_a.each { |letter| print letter } # column headers
      puts
      print "  "
      (0..7).each { |ci| print ci } # column headers
      puts

      @board.rows.each_with_index do |row, ri|
          print ri.to_s + " "

          row.each_with_index do |el, ci|
            pos_i = [ri, ci]
            # color = @board[[ri, ci]].color || :white
            if @cursor.cursor_pos == pos_i
                #debugger
              print el.to_s.bg_gray
            elsif @cursor.selected_piece && @cursor.selected_piece.pos == pos_i
              print el.to_s.bg_blue
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

  def bg_blue;
    i = self[10]
    "\e[44m#{i}\e[0m"
  end
end


b = Board.new
d = Display.new(b)
p b.checkmate?(:black)
b.move_piece(:white,[1,5],[2,5])
p b.checkmate?(:black)
b.move_piece(:black,[6,4],[4,4])
p b.checkmate?(:black)
b.move_piece(:white,[1,6],[3,6])
p b.checkmate?(:black)
b.move_piece(:black,[7,3],[3,7])

d.render
p b.checkmate?(:black)

# d.test
#f2,f3 =>[1,5],[2,5]
#e7,e5 =>[6,4],[4,4]
#g2,g4 =>[1,6],[3,6]
#d8,h4 =>[7,3],[3,7]
