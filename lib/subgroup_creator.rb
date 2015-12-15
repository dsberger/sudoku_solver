require_relative "../modules/matrix_tools"

class SubgroupCreator
  include MatrixTools

  def initialize(cell_matrix)
    @cell_matrix = cell_matrix
  end

  def subgroups
    @subgroups ||= create_subgroups
  end


  private

  attr_reader :cell_matrix

  def create_subgroups
    SUBGROUP_TOP_LEFT_COORDINATES.each_with_object([]) do |coords, arr|
      x, y = coords
      cells = subgroup_from(cell_matrix, x, y)
      arr << BlockOfNine.new_from(cells)
    end
  end
end
