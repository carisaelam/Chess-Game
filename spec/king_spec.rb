# frozen_string_literal: true

# spec/king_spec.rb

require_relative '../lib/pieces/king'
require_relative '../lib/board'

RSpec.describe King do
  let(:board) { Board.new }
  let(:white_king) { King.new(:white, [4, 4], :board) }
  let(:black_king) { King.new(:black, [4, 4], :board) }

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
    end
  end
end
