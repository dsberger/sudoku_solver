class CellMatrixCreator

  attr_reader :cell_matrix

  def initialize(matrix)
    @cell_matrix = create_cell_matrix(matrix)
  end

  private

  def create_cell_matrix(matrix)
    matrix.each_with_object([]) do |row, arr|
      arr << create_row_of_new_cells(row)
    end
  end

  def create_row_of_new_cells(row)
    row.each_with_object([]) do |value, arr|
      arr << Cell.new(value)
    end
  end

end
