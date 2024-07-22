# frozen_string_literal: true

require 'rspec'
require_relative '../lib/pieces/empty_piece'

RSpec.describe EmptyPiece do
  let(:empty_piece) { EmptyPiece.new }

  describe '#initialize' do
    it 'sets the color to :empty' do
      expect(empty_piece.color).to eq(:empty)
    end

    it 'sets the position to [0, 0]' do
      expect(empty_piece.position).to eq([0, 0])
    end

    it 'sets the board to nil' do
      expect(empty_piece.board).to be_nil
    end
  end

  describe '#unicode_symbol' do
    it 'returns a space character for an empty piece' do
      expect(empty_piece.unicode_symbol).to eq(' ')
    end
  end
end
