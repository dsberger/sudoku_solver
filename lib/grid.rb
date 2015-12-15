class Grid

  def initialize(cell_matrix:, rows:, columns:, subgroups:)
    @cell_matrix = cell_matrix
    @rows = rows
    @columns = columns
    @subgroups = subgroups
    solve!
  end

  def self.new_from_matrix(matrix)
    cell_matrix = create_cell_matrix(matrix)

    Grid.new(
      cell_matrix: cell_matrix,
      rows: create_array_groups(cell_matrix),
      columns: create_array_groups(cell_matrix.transpose),
      subgroups: create_subgroups(cell_matrix)
    )
  end

  def values_matrix
    cell_matrix.map { |row| row.map { |cell| cell.value } }
  end

  def possibilities_matrix
    cell_matrix.map { |row| row.map { |cell| cell.possibilities } }
  end


  private

  attr_reader :cell_matrix, :rows, :columns, :subgroups

  def solve!
    @making_progress = false
    loop do
      row_progress = hit_all_rows!
      column_progress = hit_all_columns!
      subgroup_progress = hit_all_subgroups!

      @making_progress = row_progress || column_progress || subgroup_progress

      break unless @making_progress
    end
  end

  def hit_all_rows!
    success = []
    rows.each { |row| success << row.hit! }
    success.any?
  end

  def hit_all_columns!
    success = []
    columns.each { |column| success << column.hit! }
    success.any?
  end

  def hit_all_subgroups!
    success = []
    subgroups.each { |subgroup| success << subgroup.hit! }
    success.any?
  end

  SUBGROUP_TOP_LEFT_COORDINATES = [
    [0,0],[0,3],[0,6],[3,0],[3,3],[3,6],[6,0],[6,3],[6,6]
  ]

  def self.create_array_groups(cell_matrix)
    cell_matrix.each_with_object([]) do |row, arr|
      arr << new_block_from(row)
    end
  end

  def self.create_subgroups(cell_matrix)
    SUBGROUP_TOP_LEFT_COORDINATES.each_with_object([]) do |coords, arr|
      x, y = coords
      arr << new_block_from(subgroup_cells_for(cell_matrix, x, y))
    end
  end

  def self.subgroup_cells_for(cell_matrix, x, y)
    cell_matrix[x][y..y+2] + cell_matrix[x+1][y..y+2] + cell_matrix[x+2][y..y+2]
  end

  def self.new_block_from(nine_cells)
    block = BlockOfNine.new
    nine_cells.each { |cell| block.add_cell(cell) }
    block
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
