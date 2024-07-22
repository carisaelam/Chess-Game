# frozen_string_literal: true

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
require_relative 'lib/pieces/empty_piece'
require_relative 'lib/game_flow'
require_relative 'lib/game_status'

board = Board.new
piece_mover = PieceMover.new(board)
coordinate_converter = CoordinateConverter.new
game_status = GameStatus.new(board)

# game = GameFlow.new(board, piece_mover, coordinate_converter)
# game.start

board.place_piece(EmptyPiece.new, [1, 0])
board.place_piece(EmptyPiece.new, [1, 1])
board.place_piece(EmptyPiece.new, [1, 2])
board.place_piece(EmptyPiece.new, [1, 3])
board.place_piece(EmptyPiece.new, [1, 4])
board.place_piece(EmptyPiece.new, [1, 5])
board.place_piece(EmptyPiece.new, [1, 6])
board.place_piece(EmptyPiece.new, [1, 7])

board.print_board
game_status.check?
