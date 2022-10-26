module Stepable

    def moves
        possible_moves = []
        row, col = @pos

        move_diffs.each do |dir|
            dy, dx = dir
            new_pos = [row+dx, col+dy]
            if Board.valid_pos?(new_pos) && board[new_pos].color != color
                possible_moves << new_pos
            end
        end

        possible_moves
    end

    private
    def move_diffs 
        # overwritten by subclass
    end

end

