require_relative "../modules/matrix_tools"

class SubgroupValidator
  include MatrixTools

  def initialize(matrix)
    @matrix = matrix
  end

  def valid?
    SUBGROUP_TOP_LEFT_COORDINATES
      .map do |coords|
        x, y = coords
        group = subgroup_from(matrix, x, y)
        has_duplicates?(group)
      end.none?
  end


  private

  attr_reader :matrix

end
