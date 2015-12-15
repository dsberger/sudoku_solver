class StraightLineCreator

  attr_reader :lines

  def initialize(cell_matrix)
    @lines = create_lines(cell_matrix)
  end


  private

  def create_lines(cell_matrix)
    cell_matrix.each_with_object([]) do |row, arr|
      arr << BlockOfNine.new_from(row)
    end
  end
end
