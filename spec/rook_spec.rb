require_relative '../lib/pieces/rook'
require_relative '../lib/board'

RSpec.describe Rook do
  it 'should receive a Board instance' do
    board = Board.new
    rook = Rook.new(:white, [7, 0], board)

    expect(rook.board).to be_an_instance_of(Board)
  end
end
