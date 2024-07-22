# frozen_string_literal: true

require_relative '../lib/coordinate_converter'

RSpec.describe CoordinateConverter do
  subject(:converter) { described_class.new }

  describe '#convert_from_alg_notation' do
    it 'converts chess notation to board coordinates' do
      expect(converter.convert_from_alg_notation('a8')).to eq([0, 0])
      expect(converter.convert_from_alg_notation('h1')).to eq([7, 7])
    end

    it 'works on uppercase inputs' do
      expect(converter.convert_from_alg_notation('A8')).to eq([0, 0])
      expect(converter.convert_from_alg_notation('H1')).to eq([7, 7])
    end

    it 'returns nil for invalid input' do
      expect(converter.convert_from_alg_notation('z8')).to eq(nil)
    end
  end
end
