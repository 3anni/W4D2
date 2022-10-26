require_relative 'pieces/bishop.rb'
require_relative 'pieces/king.rb'
require_relative 'pieces/knight.rb'
require_relative 'pieces/null_piece.rb'
require_relative 'pieces/pawn.rb'
require_relative 'pieces/piece.rb'
require_relative 'pieces/queen.rb'
require_relative 'pieces/rook.rb'

class Board
    attr_reader :rows, :null_piece

    def initialize
        @null_piece = NullPiece.instance
        @rows = Array.new(8) {Array.new(8, @null_piece)}
        place_pieces
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos,val)
        row, col = pos
        @rows[row][col] = val
    end

    def self.valid_pos?(pos)
        row, col = pos
        !(row > 7 || col > 7 || row < 0 || col < 0)
    end

    # empty pos method

    def move_piece(color,start_pos,end_pos)
        #raise an error if piece at this location cannot move to end_pos
        raise "Cannot move to that location" if self[end_pos].color == color
        raise "No piece at this location" if self[start_pos] == @null_piece
        
        #move piece to new position
        self[end_pos] = self[start_pos]
        #update piece at self[start_pos]'s position
        self[end_pos].pos = end_pos
        
        self[start_pos] = @null_piece
    end

    def render
        print "  "
        (0..7).each { |ci| print ci }
        puts

        @rows.each_with_index do |row, ri|
            # p row[0]
            print ri.to_s + " "
            row.each do |el|
                print el.to_s
            end
            puts
        end
        return nil
    end

    private
    def place_pieces
        black_pawns = (0..7).map {|i| [1, i]}
        white_pawns = (0..7).map {|i| [6, i]}
        pawns = black_pawns + white_pawns
        rooks = [[0,0], [0,7], [7,0], [7,7]]
        knights = [[0,1], [0,6], [7,1], [7,6]]
        bishops = [[0,2], [0,5], [7,2], [7,5]]
        queens = [[0,3], [7,3]]
        kings = [[0,4], [7,4]]

        pawns.each {|pos| self[pos] = Pawn.new(determine_color(pos),self,pos)}
        rooks.each {|pos| self[pos] = Rook.new(determine_color(pos),self,pos)}
        knights.each {|pos| self[pos] = Knight.new(determine_color(pos),self,pos)}
        bishops.each {|pos| self[pos] = Bishop.new(determine_color(pos),self,pos)}
        queens.each {|pos| self[pos] = Queen.new(determine_color(pos),self,pos)}
        kings.each {|pos| self[pos] = King.new(determine_color(pos),self,pos)}
    end

    def determine_color(pos)
        pos[0] == 0 || pos[0] == 1 ? :black : :white
    end
end