require 'byebug'

module Slideable

    HORIZONTAL_DIRS = [
        [0,1],
        [0,-1],
        [1,0],
        [-1,0]
    ]

    DIAGONAL_DIRS = [
        [1,1],
        [1,-1],
        [-1,1],
        [-1,-1]
    ]

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        arr = []
        self.move_dirs.each do |dir|
            arr += grow_unblocked_moves_in_dir(dir[0],dir[1])
        end
        return arr
    end

    private
    def move_dirs # overwritten by subclass
        raise "This should be overwritten"
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        direction_moves = []
        row,col = self.pos
        new_pos = [row+dy,col+dx]
        
        while Board.valid_pos?(new_pos) && self.board[new_pos] == self.board.null_piece
            np_row, np_col = new_pos
            direction_moves << new_pos
            new_pos = [new_pos[0]+dy, new_pos[1]+dx]
        end
        
        if Board.valid_pos?(new_pos) && self.board[new_pos].color != self.color
            direction_moves << new_pos
        end
        return direction_moves
    end

end