require_relative 'piece.rb'

class Pawn < Piece

    def initialize(color,board,pos)
        super(color,board,pos)
    end

    def symbol
        "♙".colorize(@color)
    end

    def moves
        forward_steps + side_attacks
    end
    
    private
    def at_start_row?
        row, col = @pos
        row == 1 || row == 6
    end
    
    def forward_dir
        @color == :black ? 1 : -1
    end
    
    def forward_steps
        row, col = @pos
        new_pos = [row + forward_dir, col]
        if Board.valid_pos?(new_pos) && @board[new_pos].empty?
            res = [new_pos]
            res << [row + forward_dir*2, col] if at_start_row?
        else
            res = []
        end
        res
    end
    
    def side_attacks
        row, col = @pos
        side1 = [row + forward_dir, col + 1]
        side2 = [row + forward_dir, col - 1]
        # DO LATER - check to ensure that an opponent is in those positions
        return [side1, side2] if Board.valid_pos?(side1) && Board.valid_pos?(side2) && self.opponent_color == @board[side1].color && self.opponent_color == @board[side2].color
        return [side1] if Board.valid_pos?(side1) && self.opponent_color == @board[side1].color
        return [side2] if Board.valid_pos?(side2) && self.opponent_color == @board[side2].color
        return []
    end
end