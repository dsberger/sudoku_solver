class Grid

  def initialize(cell_matrix:, rows:, columns:, subgroups:)
    @cell_matrix = cell_matrix
    @rows = rows
    @columns = columns
    @subgroups = subgroups
    solve!
  end

  def self.new_from_matrix(matrix)
    cell_matrix = CellMatrixCreator.new(matrix).cell_matrix
    rows = StraightLineCreator.new(cell_matrix).lines
    columns = StraightLineCreator.new(cell_matrix.transpose).lines
    subgroups = SubgroupCreator.new(cell_matrix).subgroups

    Grid.new(
      cell_matrix: cell_matrix,
      rows: rows,
      columns: columns,
      subgroups: subgroups
    )
  end

  def values_matrix
    cell_matrix.map do |row|
      row.map { |cell| cell.value }
    end
  end

  def possibilities_matrix
    cell_matrix.map do |row|
      row.map { |cell| cell.possibilities }
    end
  end


  private

  attr_reader :cell_matrix, :rows, :columns, :subgroups

  def solve!
    loop do

      row_progress = hit_all!(:rows)
      column_progress = hit_all!(:columns)
      subgroup_progress = hit_all!(:subgroups)

      @making_progress =  row_progress ||
                          column_progress ||
                          subgroup_progress

      break unless @making_progress
    end
  end

  def hit_all!(sym)
    send(sym).each_with_object([]) do |item, success|
      success << item.hit!
    end.any?
  end
end
