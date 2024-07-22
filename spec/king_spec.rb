# frozen_string_literal: true

# spec/king_spec.rb

require_relative '../lib/pieces/king'
require_relative '../lib/board'
require_relative '../lib/pieces/empty_piece'

RSpec.describe King do
  let(:board) { Board.new }
  let(:white_king) { King.new(:white, [4, 4], board) }
  let(:black_king) { King.new(:black, [4, 4], board) }
  let(:white_pawn) { Pawn.new(:white, [5, 5], board) }
  let(:black_pawn) { Pawn.new(:black, [5, 5], board) }

  before do
    board.place_piece(white_king, [4, 4])
    board.place_piece(black_king, [4, 4])
  end

  describe '#unicode_symbol' do
    it 'returns the correct unicode symbol for white king' do
      expect(white_king.unicode_symbol).to eq("\u2654")
    end

    it 'returns the correct unicode symbol for black king' do
      expect(black_king.unicode_symbol).to eq("\u265A")
    end
  end

  describe '#valid_move?' do
    context 'with a valid move' do
      it 'returns true for a move one step up' do
        expect(white_king.valid_move?([4, 4], [5, 4])).to be true
      end

      it 'returns true for a move one step diagonally' do
        expect(white_king.valid_move?([4, 4], [5, 5])).to be true
      end
    end

    context 'with an invalid move' do
      it 'returns false for a move two steps away' do
        expect(white_king.valid_move?([4, 4], [6, 4])).to be false
      end

      it 'returns false for a move outside the board' do
        expect(white_king.valid_move?([4, 4], [8, 4])).to be false
      end

      it 'returns false if the destination is occupied by a piece of the same color' do
        board.place_piece(white_pawn, [5, 5])
        expect(white_king.valid_move?([4, 4], [5, 5])).to be false
      end

      it 'returns true if the destination is occupied by a piece of the opposite color' do
        board.place_piece(black_pawn, [5, 5])
        expect(white_king.valid_move?([4, 4], [5, 5])).to be true
      end
    end
  end
end
