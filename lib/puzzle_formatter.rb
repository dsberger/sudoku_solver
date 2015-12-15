class PuzzleFormatter

  def initialize(matrix)
    @matrix = matrix
  end

  def puzzle_string
    array_of_row_strings = stringify_rows(matrix)
    array_of_row_strings.insert(6, divider)
    array_of_row_strings.insert(3, divider)
    array_of_row_strings.join("\n")
  end


  private

  attr_reader :matrix

  def stringify_rows(matrix)
    matrix.each_with_object([]) do |row, arr|
      row_array = replace_nil_with_zero(row)
      arr << string_format(row_array)
    end
  end

  def divider
    "------+------+------"
  end

  def string_format(row_array)
    [ row_array[0..2].join(" "),
      row_array[3..5].join(" "),
      row_array[6..8].join(" ") ].join(" |")
  end

  def replace_nil_with_zero(row_array)
    row_array.map { |cell| cell.nil? ? 0 : cell }
  end
end
