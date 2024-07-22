# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/empty_piece'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:pawn) { Pawn.new(:white, [1, 1], board) }
  let(:rook) { Rook.new(:black, [0, 0], board) }
  let(:empty_piece) { EmptyPiece.new }

  before do
    board.starting_positions
  end

  describe '#initialize' do
    it 'creates an 8x8 board with the correct initial setup' do
      expect(board.instance_variable_get(:@board).size).to eq(8)
      expect(board.instance_variable_get(:@board).all? { |row| row.size == 8 }).to be true
    end
  end

  describe '#place_piece' do
    it 'places a piece at a specified position' do
      board.place_piece(pawn, [2, 2])
      expect(board.piece_at([2, 2])).to eq(pawn)
    end

    it 'raises an error if the piece is not a Piece' do
      expect { board.place_piece('not_a_piece', [2, 2]) }.to raise_error('Expected Piece, got String')
    end
  end

  describe '#piece_at' do
    it 'returns the piece at a specified position' do
      board.place_piece(pawn, [3, 3])
      expect(board.piece_at([3, 3])).to eq(pawn)
    end

    it 'raises an error for invalid positions' do
      expect { board.piece_at([8, 8]) }.to raise_error(ArgumentError, 'Invalid position')
    end
  end

  describe '#valid_position?' do
    it 'returns true for valid positions' do
      expect(board.valid_position?([0, 0])).to be true
      expect(board.valid_position?([7, 7])).to be true
    end

    it 'returns false for invalid positions' do
      expect(board.valid_position?([8, 8])).to be false
      expect(board.valid_position?([-1, 0])).to be false
      expect(board.valid_position?([0, 8])).to be false
    end
  end

  describe '#starting_positions' do
    it 'places all pieces in their starting positions' do
      expect(board.piece_at([0, 0])).to be_a(Rook)
      expect(board.piece_at([7, 7])).to be_a(Rook)
      expect(board.piece_at([1, 0])).to be_a(Pawn)
      expect(board.piece_at([6, 4])).to be_a(Pawn)
    end

    it 'places empty pieces in the correct positions' do
      expect(board.piece_at([2, 0])).to be_a(EmptyPiece)
      expect(board.piece_at([3, 4])).to be_a(EmptyPiece)
    end
  end
end
