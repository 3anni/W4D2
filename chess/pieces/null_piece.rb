require 'singleton'
require_relative 'piece.rb'

class NullPiece < Piece
    include Singleton

    attr_reader :color

    def initialize
        super(nil,nil,nil)
    end

    def moves
        raise "NullPiece can't be moved."
    end

    def symbol
        :_.colorize(:white)
    end

end
