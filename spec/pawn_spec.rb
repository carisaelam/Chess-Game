# frozen_string_literal: true

require 'rspec'
require_relative '../lib/pieces/pawn'
require_relative '../lib/board'

RSpec.describe Pawn do
  let(:board) { instance_double('Board') }
  let(:white_pawn) { Pawn.new(:white, [6, 4], board) }
  let(:black_pawn) { Pawn.new(:black, [1, 4], board) }
  let(:black_first_move_pawn) { Pawn.new(:black, [1, 0], board) }

  describe '#unicode_symbol' do
    it 'returns the correct symbol for a white pawn' do
      expect(white_pawn.unicode_symbol).to eq("\u2659")
    end

    it 'returns the correct symbol for a black pawn' do
      expect(black_pawn.unicode_symbol).to eq("\u265F")
    end
  end

  describe '#valid_move?' do
    before do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))
    end

    context 'when the move is valid' do
      it 'returns true for a forward move' do
        expect(white_pawn.valid_move?([6, 4], [5, 4])).to be true
        expect(black_pawn.valid_move?([1, 4], [2, 4])).to be true
      end

      it 'returns true for a diagonal capture' do
        allow(board).to receive(:piece_at).with([5, 3]).and_return(instance_double('Piece', color: :black))
        allow(board).to receive(:piece_at).with([5, 5]).and_return(instance_double('Piece', color: :black))
        allow(board).to receive(:piece_at).with([2, 3]).and_return(instance_double('Piece', color: :white))
        allow(board).to receive(:piece_at).with([2, 5]).and_return(instance_double('Piece', color: :white))

        expect(white_pawn.valid_move?([6, 4], [5, 3])).to be true
        expect(white_pawn.valid_move?([6, 4], [5, 5])).to be true
        expect(black_pawn.valid_move?([1, 4], [2, 3])).to be true
        expect(black_pawn.valid_move?([1, 4], [2, 5])).to be true
      end

      it 'returns true for double step on first move' do
        allow(board).to receive(:piece_at).with([1, 1]).and_return(instance_double('Piece', color: :black))
        expect(black_first_move_pawn.valid_move?([1, 0], [3, 0])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for a move out of bounds' do
        expect(white_pawn.valid_move?([6, 4], [7, 4])).to be false
      end

      it 'returns false for a non-forward, non-diagonal move' do
        expect(white_pawn.valid_move?([6, 4], [6, 5])).to be false
        expect(black_pawn.valid_move?([1, 4], [1, 5])).to be false
      end

      it 'returns false for a diagonal move with no capture' do
        expect(white_pawn.valid_move?([6, 4], [5, 3])).to be false
        expect(white_pawn.valid_move?([6, 4], [5, 5])).to be false
        expect(black_pawn.valid_move?([1, 4], [2, 3])).to be false
        expect(black_pawn.valid_move?([1, 4], [2, 5])).to be false
      end
    end
  end

  describe '#generate_moves' do
    it 'generates valid moves for a pawn' do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))

      expect(white_pawn.send(:generate_moves, [6, 4])).to include([5, 4])
      expect(black_pawn.send(:generate_moves, [1, 4])).to include([2, 4])
    end

    it 'includes diagonal captures' do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))
      allow(board).to receive(:piece_at).with([5, 3]).and_return(instance_double('Piece', color: :black))
      allow(board).to receive(:piece_at).with([5, 5]).and_return(instance_double('Piece', color: :black))
      allow(board).to receive(:piece_at).with([2, 3]).and_return(instance_double('Piece', color: :white))
      allow(board).to receive(:piece_at).with([2, 5]).and_return(instance_double('Piece', color: :white))

      expect(white_pawn.send(:generate_moves, [6, 4])).to include([5, 3], [5, 5])
      expect(black_pawn.send(:generate_moves, [1, 4])).to include([2, 3], [2, 5])
    end
  end

  describe '#in_bounds?' do
    it 'returns true for a position within the board bounds' do
      expect(white_pawn.send(:in_bounds?, [5, 4])).to be true
    end

    it 'returns false for a position outside the board bounds' do
      expect(white_pawn.send(:in_bounds?, [8, 4])).to be false
    end
  end

  describe '#add_valid_move' do
    it 'adds a valid forward move' do
      moves = []
      allow(board).to receive(:piece_at).with([5, 4]).and_return(instance_double('Piece', color: :empty))

      white_pawn.send(:add_valid_move, moves, [5, 4], :empty)
      expect(moves).to include([5, 4])
    end

    it 'adds a valid diagonal capture move' do
      moves = []
      allow(board).to receive(:piece_at).with([5, 3]).and_return(instance_double('Piece', color: :black))

      white_pawn.send(:add_valid_move, moves, [5, 3], :white, enemy_check: true)
      expect(moves).to include([5, 3])
    end

    it 'does not add an invalid move' do
      moves = []
      allow(board).to receive(:piece_at).with([5, 4]).and_return(instance_double('Piece', color: :white))

      white_pawn.send(:add_valid_move, moves, [5, 4], :empty)
      expect(moves).to be_empty
    end
  end
end
