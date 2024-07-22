# frozen_string_literal: true

class CoordinateConverter
  SQUARE_COORDINATES = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7,

    '1' => 7,
    '2' => 6,
    '3' => 5,
    '4' => 4,
    '5' => 3,
    '6' => 2,
    '7' => 1,
    '8' => 0

  }.freeze

  def initialize
    @coordinates = SQUARE_COORDINATES
  end

  # converts chess notation to board coordinates
  def convert_from_alg_notation(input)
    string = process_coordinate_input(input.downcase)

    [square_coordinates[string[1]], square_coordinates[string[0]]]
  end

  def process_coordinate_input(input)
    [input[0], input[1]]
  end

  def square_coordinates
    SQUARE_COORDINATES
  end
end
