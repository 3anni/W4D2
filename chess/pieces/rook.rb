require_relative 'slideable.rb'
require_relative 'piece.rb'

require 'colorize'

class Rook < Piece
    include Slideable

    # attr_reader :color

    def initialize(color,board,pos)
        super
    end

    def symbol
        "♖".colorize(@color)
    end
    
    def move_dirs
        horizontal_dirs
    end

end