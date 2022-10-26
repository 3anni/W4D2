require_relative './slideable.rb'
require_relative 'piece.rb'

class Bishop < Piece
    include Slideable

    def initialize(color,board,pos)
        super
    end

    def symbol
        "♗".colorize(@color)
    end
    
    def move_dirs
        diagonal_dirs
    end

end