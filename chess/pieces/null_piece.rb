require 'singleton'
require_relative 'piece.rb'

require 'colorize'

class NullPiece < Piece
    include Singleton

    attr_reader :color

    def initialize
        super(nil,nil,nil)
    end

    def moves
        []
    end

    def symbol
        "_".colorize(:grey)
    end

end
