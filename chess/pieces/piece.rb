class Piece
    attr_reader :board

    attr_accessor :pos, :color

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

    # filters out the #moves of a Piece that would leave the player in check.
    # a good approach is to write a Piece#move_into_check?(end_pos) method (see below private)

    def valid_moves
        moves.reject do |end_pos|
            # Check to see if move puts piece's king in check
            dup = @board.dup

            dup.move_piece!(@color, @pos, end_pos)
            dup.in_check?(@color)
        end
    end


    def pos=(val)
        @pos = val
    end

    def symbol
        raise "must implement symbol in subclass"
    end


    private
    # method will:
        # 1) duplicate the Board and perform the move
        # 2) look to see if the player is in check after the move (Board#in_check?)
    # you'll need a Board#dup method that duplicates not only the Board but also the pieces on the Board.
    # be aware: Ruby's #dup method does not call dup on the instance variables, so you
    # may need to write your own Board#dup method that will dup the individual pieces as well
    def move_into_check?(end_pos)

    end

end
