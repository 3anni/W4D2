require_relative './stepable.rb'
require_relative 'piece.rb'


class Knight < Piece
    include Stepable

    def initialize(color,board,pos)
        super
    end

    def symbol
        "♘".colorize(@color)
    end

    def move_diffs
        [[1,2],
        [1,-2],
        [-1,2],
        [-1,-2], 
        [2,1],
        [2,-1],
        [-2,1],
        [-2,-1]]
    end

    #todo add functions

end