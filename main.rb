require_relative 'lib/board'
require_relative 'lib/coordinate_converter'
require_relative 'lib/piece'
require_relative 'lib/piece_mover'
require_relative 'lib/pieces/knight'
require_relative 'lib/pieces/bishop'
require_relative 'lib/pieces/rook'
require_relative 'lib/pieces/pawn'
require_relative 'lib/pieces/king'
require_relative 'lib/pieces/queen'
require_relative 'lib/pieces/empty'

new_board = Board.new
new_board.print_board
# pp new_board.board[0][0][1].class
# pp new_board.board[0][0][1].color

# # King Checks
# # _____________________________________________
# p 'white king horizontal move'
# piece_mover.move_piece([7, 4], [7, 5])
# board.print_board

# p 'black king horizontal move'
# piece_mover.move_piece([0, 4], [0, 5])
# board.print_board

# p 'white king vertical move'
# piece_mover.move_piece([7, 5], [6, 5])
# board.print_board

# p 'black king vertical move'
# piece_mover.move_piece([0, 5], [1, 5])
# board.print_board

# p 'white king diagonal move'
# piece_mover.move_piece([6, 5], [7, 6])
# board.print_board

# p 'black king diagonal move'
# piece_mover.move_piece([1, 5], [2, 6])
# board.print_board

# p 'white king attempts two steps'
# piece_mover.move_piece([7, 6], [7, 4])
# board.print_board

# # Pawn Checks
# # ___________________________________________
# p 'black pawn down'
# piece_mover.move_piece([1, 0], [2, 0])
# board.print_board

# p 'white pawn up'
# piece_mover.move_piece([6, 0], [5, 0])
# board.print_board

# p 'out of bounds move'
# piece_mover.move_piece([5, 0], [9, 0])
# board.print_board

# p 'invalid move for piece'
# piece_mover.move_piece([5, 0], [6, 5])
# board.print_board

# p 'white trying to move down'
# piece_mover.move_piece([5, 0], [6, 0])
# board.print_board

# p 'black trying to move up'
# piece_mover.move_piece([2, 0], [1, 0])
# board.print_board
