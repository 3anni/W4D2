class Piece
    attr_reader :board, :color

    attr_accessor :pos

    def initialize(color,board,pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        symbol.to_s
    end

    def empty?
        @color.nil?
    end

    def opponent_color
        @color == :white ? :black : :white
    end

    def valid_moves

    end

    def pos=(val)
        @pos = val
    end

    def symbol
        
    end

    private
    def move_into_check?(end_pos)

    end

end