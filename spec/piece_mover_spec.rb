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
  let(:pawn) { instance_double(Pawn, color: :white) }

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

    it 'returns false if the move is not valid' do
      allow(piece_mover).to receive(:validate_move).and_return(false)
      expect(piece_mover.move_piece(start_position, end_position)).to be false
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
      allow(piece_mover).to receive(:check_in_bounds).and_return(true)
      allow(piece_mover).to receive(:valid_move_for_type).and_return(true)
      expect(piece_mover.send(:validate_move, start_position, end_position)).to be true
    end

    it 'returns false for an out of bounds move' do
      allow(piece_mover).to receive(:check_in_bounds).and_return(false)
      expect(piece_mover.send(:validate_move, start_position, end_position)).to be false
    end

    it 'returns false for an invalid move for piece type' do
      allow(piece_mover).to receive(:check_in_bounds).and_return(true)
      allow(piece_mover).to receive(:valid_move_for_type).and_return(false)
      expect(piece_mover.send(:validate_move, start_position, end_position)).to be false
    end
  end

  describe '#check_in_bounds' do
    it 'returns true for positions within the board' do
      expect(piece_mover.send(:check_in_bounds, [4, 4])).to be true
    end

    it 'returns false for positions out of the board' do
      expect(piece_mover.send(:check_in_bounds, [8, 8])).to be false
    end
  end

  describe '#start_point' do
    it 'returns the piece at the start position' do
      allow(board).to receive(:piece_at).with(start_position).and_return(pawn)
      expect(piece_mover.send(:start_point, start_position)).to eq(pawn)
    end
  end

  describe '#set_pieces' do
    it 'raises an error if there is no piece at the start position' do
      allow(board).to receive(:piece_at).with(start_position).and_return(nil)
      expect do
        piece_mover.send(:set_pieces, start_position, end_position)
      end.to raise_error('No piece at start position')
    end

    it 'places the piece from start to end position' do
      allow(board).to receive(:piece_at).with(start_position).and_return(pawn)
      expect(board).to receive(:place_piece).with(pawn, end_position)
      piece_mover.send(:set_pieces, start_position, end_position)
    end
  end
end
