# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/empty_piece'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/knight'

# spec/board_spec.rb

RSpec.describe Board, type: :model do
  let(:board) { Board.new }

  before do
    board.starting_positions
  end

  describe '#castle_short_move_available?' do
    context 'when the color is white' do
      it 'returns true if short castling is available' do
        # Move the pieces into positions that would allow castling short
        board.place_piece(King.new(:white, [7, 4], board), [7, 4])
        board.place_piece(EmptyPiece.new, [7, 5])
        board.place_piece(EmptyPiece.new, [7, 6])
        board.place_piece(Rook.new(:white, [7, 7], board), [7, 7])

        expect(board.castle_short_move_available?(:white)).to be true
      end

      it 'returns false if short castling is not available' do
        # Modify the board so that short castling is not available
        board.place_piece(King.new(:white, [7, 4], board), [7, 4])
        board.place_piece(Rook.new(:white, [7, 7], board), [7, 7])
        board.place_piece(Pawn.new(:white, [7, 6], board), [7, 6])
        expect(board.castle_short_move_available?(:white)).to be false
      end
    end

    context 'when the color is black' do
      it 'returns true if short castling is available' do
        # Move the pieces into positions that would allow castling short
        board.place_piece(King.new(:black, [0, 4], board), [0, 4])
        board.place_piece(Rook.new(:black, [0, 7], board), [0, 7])
        # Empty the necessary squares
        [0, 6, 0, 5].each { |pos| board.place_piece(EmptyPiece.new, [0, pos]) }
        expect(board.castle_short_move_available?(:black)).to be true
      end

      it 'returns false if short castling is not available' do
        # Modify the board so that short castling is not available
        board.place_piece(King.new(:black, [0, 4], board), [0, 4])
        board.place_piece(Rook.new(:black, [0, 7], board), [0, 7])
        board.place_piece(Pawn.new(:black, [0, 6], board), [0, 6])
        expect(board.castle_short_move_available?(:black)).to be false
      end
    end
  end

  describe '#castle_long_move_available?' do
    context 'when the color is white' do
      it 'returns true if long castling is available' do
        # Move the pieces into positions that would allow castling long
        board.place_piece(King.new(:white, [7, 4], board), [7, 4])
        board.place_piece(EmptyPiece.new, [7, 3])
        board.place_piece(EmptyPiece.new, [7, 2])
        board.place_piece(EmptyPiece.new, [7, 1])
        board.place_piece(Rook.new(:white, [7, 0], board), [7, 0])

        expect(board.castle_long_move_available?(:white)).to be true
      end

      it 'returns false if long castling is not available' do
        # Modify the board so that long castling is not available
        board.place_piece(King.new(:white, [7, 4], board), [7, 4])
        board.place_piece(Rook.new(:white, [7, 0], board), [7, 0])
        board.place_piece(Pawn.new(:white, [7, 1], board), [7, 1])
        expect(board.castle_long_move_available?(:white)).to be false
      end
    end

    context 'when the color is black' do
      it 'returns true if long castling is available' do
        # Move the pieces into positions that would allow castling long
        board.place_piece(King.new(:black, [0, 4], board), [0, 4])
        board.place_piece(EmptyPiece.new, [0, 3])
        board.place_piece(EmptyPiece.new, [0, 2])
        board.place_piece(EmptyPiece.new, [0, 1])
        board.place_piece(Rook.new(:black, [0, 0], board), [0, 0])
        expect(board.castle_long_move_available?(:black)).to be true
      end

      it 'returns false if long castling is not available' do
        # Modify the board so that long castling is not available
        board.place_piece(King.new(:black, [0, 4], board), [0, 4])
        board.place_piece(Rook.new(:black, [0, 0], board), [0, 0])
        board.place_piece(Pawn.new(:black, [0, 1], board), [0, 1])
        expect(board.castle_long_move_available?(:black)).to be false
      end
    end
  end
end
