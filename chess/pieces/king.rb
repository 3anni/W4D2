require_relative './stepable.rb'
require_relative 'piece.rb'


class King < Piece
    include Stepable

    def initialize(color,board,pos)
        super
    end

    def symbol
        "♔".colorize(@color)
    end

    def move_diffs
        [[0,1],
        [0,-1],
        [1,0],
        [-1,0], 
        [1,1],
        [1,-1],
        [-1,1],
        [-1,-1]]
    end

end

