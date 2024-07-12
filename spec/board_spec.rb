# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  # DRAW_BOARD
  # [ ] draws an empty board
  # [ ] draws a board with a symbol in a particular space

  describe '#draw_board' do
    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }

      it 'displays an empty board' do
        expected_output = [[[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']]]

        actual_output = empty_board.draw_board

        expect(actual_output).to eq(expected_output)
      end
    end

    context 'when the board has one piece' do
      it 'displays a board with one piece an X' do
        one_piece_board = described_class.new
        one_piece_board.board[0][0][1] = 'X'

        expected_output = [[[47, 'X'],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']]]

        actual_output = one_piece_board.draw_board

        expect(actual_output).to eq(expected_output)
      end
    end
  end
end
