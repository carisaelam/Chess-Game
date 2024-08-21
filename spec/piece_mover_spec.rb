# frozen_string_literal: true

require 'rspec'
require_relative '../lib/piece_mover'
require_relative '../lib/board'
require_relative '../lib/pieces/empty_piece'
require_relative '../lib/pieces/pawn'

RSpec.describe PieceMover do
  let(:board) { instance_double(Board) }
  let(:piece_mover) { PieceMover.new(board) }
  let(:start_position) { [1, 1] }
  let(:end_position) { [2, 1] }
  let(:empty_piece) { instance_double(EmptyPiece, color: :empty) }
  let(:pawn) { instance_double(Pawn, color: :white, valid_move?: true) }

  describe '#move_piece' do
    before do
      allow(piece_mover).to receive(:validate_move).and_return(true)
      allow(board).to receive(:place_piece)
      allow(board).to receive(:piece_at).with(start_position).and_return(pawn)
      allow(board).to receive(:piece_at).with(end_position).and_return(empty_piece)
    end

    it 'places the piece at the end position' do
      expect(board).to receive(:place_piece).with(pawn, end_position)
      piece_mover.move_piece(start_position, end_position)
    end

    it 'clears the piece from the start position' do
      expect(board).to receive(:place_piece).with(instance_of(EmptyPiece), start_position)
      piece_mover.move_piece(start_position, end_position)
    end
  end

  describe '#clear_pieces' do
    it 'places an empty piece at the given position' do
      allow(board).to receive(:place_piece)
      expect(board).to receive(:place_piece).with(instance_of(EmptyPiece), start_position)
      piece_mover.clear_pieces(start_position)
    end
  end

  describe '#validate_move' do
    it 'returns true for a valid move' do
      allow(piece_mover).to receive(:valid_move_for_type).and_return(true)
      expect(piece_mover.send(:validate_move, start_position, end_position)).to be true
    end

    it 'returns false for an invalid move for piece type' do
      allow(piece_mover).to receive(:valid_move_for_type).and_return(false)
      expect(piece_mover.send(:validate_move, start_position, end_position)).to be false
    end
  end

  describe '#perform_short_castle' do
    context 'when color is white' do
      it 'moves the king and rook to the short castle positions' do
        expect(piece_mover).to receive(:move_piece).with([7, 4], [7, 6])
        expect(piece_mover).to receive(:move_piece).with([7, 7], [7, 5])
        piece_mover.perform_short_castle(:white)
      end
    end

    context 'when color is black' do
      it 'moves the king and rook to the short castle positions' do
        expect(piece_mover).to receive(:move_piece).with([0, 4], [0, 6])
        expect(piece_mover).to receive(:move_piece).with([0, 7], [0, 5])
        piece_mover.perform_short_castle(:black)
      end
    end
  end

  describe '#perform_long_castle' do
    context 'when color is white' do
      it 'moves the king and rook to the long castle positions' do
        expect(piece_mover).to receive(:move_piece).with([7, 0], [7, 3])
        expect(piece_mover).to receive(:move_piece).with([7, 4], [7, 2])
        piece_mover.perform_long_castle(:white)
      end
    end

    context 'when color is black' do
      it 'moves the king and rook to the long castle positions' do
        expect(piece_mover).to receive(:move_piece).with([0, 0], [0, 3])
        expect(piece_mover).to receive(:move_piece).with([0, 4], [0, 2])
        piece_mover.perform_long_castle(:black)
      end
    end
  end
end
