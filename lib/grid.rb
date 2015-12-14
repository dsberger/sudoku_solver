class Grid

  private_class_method :new

  def initialize(cell_matrix:, rows:, columns:, subgroups:)
    @cell_matrix = cell_matrix
    @rows = rows
    @columns = columns
    @subgroups = subgroups
  end

  def self.new_from_matrix(matrix)
    cell_matrix = create_cell_matrix(matrix)

    Grid.new(
      cell_matrix: cell_matrix,
      rows: create_row_groups(cell_matrix),
      columns: create_column_groups(cell_matrix.transpose),
      subgroups: create_subgroups(cell_matrix)
    )
  end

  private

  def self.create_row_groups(cell_matrix)
    cell_matrix.each_with_object([]) do |row, arr|
      block = BlockOfNine.new
      row.each do |cell|
        block.add_cell(cell)
        cell.row = block
      end
      arr << block
    end
  end

  def self.create_column_groups(cell_matrix)
    cell_matrix.each_with_object([]) do |column, arr|
      block = BlockOfNine.new
      column.each do |cell|
        block.add_cell(cell)
        cell.column = block
      end
      arr << block
    end
  end

  def self.create_cell_matrix(matrix)
    matrix.each_with_object([]) do |row, arr|
      arr << create_row_of_new_cells(row)
    end
  end

  def self.create_row_of_new_cells(row)
    row.each_with_object([]) do |value, arr|
      arr << Cell.new(value)
    end
  end
end
