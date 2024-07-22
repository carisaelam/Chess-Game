# frozen_string_literal: true

require 'rspec'
require_relative '../lib/pieces/knight'
require_relative '../lib/board'
require_relative '../lib/piece'

RSpec.describe Knight do
  let(:board) { instance_double('Board') }
  let(:white_knight) { Knight.new(:white, [0, 1], board) }
  let(:black_knight) { Knight.new(:black, [7, 1], board) }
  let(:empty_square) { instance_double('Piece', color: :empty) }
  let(:friendly_piece) { instance_double('Piece', color: :white) }
  let(:enemy_piece) { instance_double('Piece', color: :black) }

  before do
    allow(board).to receive(:piece_at).and_return(empty_square)
  end

  describe '#unicode_symbol' do
    it 'returns the correct symbol for a white knight' do
      expect(white_knight.unicode_symbol).to eq("\u2658")
    end

    it 'returns the correct symbol for a black knight' do
      expect(black_knight.unicode_symbol).to eq("\u265E")
    end
  end

  describe '#valid_move?' do
    context 'when the move is valid' do
      it 'returns true for a valid L-shaped move' do
        allow(board).to receive(:piece_at).with([2, 2]).and_return(empty_square)
        expect(white_knight.valid_move?([0, 1], [2, 2])).to be true
      end

      it 'returns true for another valid L-shaped move' do
        allow(board).to receive(:piece_at).with([1, 3]).and_return(empty_square)
        expect(white_knight.valid_move?([0, 1], [1, 3])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for an invalid move' do
        allow(board).to receive(:piece_at).with([3, 3]).and_return(empty_square)
        expect(white_knight.valid_move?([0, 1], [3, 3])).to be false
      end

      it 'returns false for a straight move' do
        allow(board).to receive(:piece_at).with([0, 3]).and_return(empty_square)
        expect(white_knight.valid_move?([0, 1], [0, 3])).to be false
      end

      it 'returns false for a diagonal move' do
        allow(board).to receive(:piece_at).with([2, 3]).and_return(empty_square)
        expect(white_knight.valid_move?([0, 1], [2, 3])).to be false
      end
    end

    context 'when the destination square is occupied by a friendly piece' do
      it 'returns false' do
        allow(board).to receive(:piece_at).with([2, 2]).and_return(friendly_piece)
        expect(white_knight.valid_move?([0, 1], [2, 2])).to be false
      end
    end

    context 'when the destination square is occupied by an enemy piece' do
      it 'returns true' do
        allow(board).to receive(:piece_at).with([2, 2]).and_return(enemy_piece)
        expect(white_knight.valid_move?([0, 1], [2, 2])).to be true
      end
    end
  end

  describe '#all_valid_moves' do
    it 'generates all possible valid moves' do
      expected_moves = [[1, 3], [2, 2], [2, 0]]
      allow(board).to receive(:piece_at).with([1, 3]).and_return(empty_square)
      allow(board).to receive(:piece_at).with([2, 2]).and_return(empty_square)
      allow(board).to receive(:piece_at).with([2, 0]).and_return(empty_square)
      expect(white_knight.all_valid_moves([0, 1])).to match_array(expected_moves)
    end
  end
end
