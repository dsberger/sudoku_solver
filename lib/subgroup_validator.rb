class SubgroupValidator

  def initialize(matrix)
    @matrix = matrix
  end

  def valid?
    SUBGROUP_TOP_LEFT_COORDINATES
      .map { |coords| has_duplicates?(subgroup(coords)) }
      .none?
  end


  private

  SUBGROUP_TOP_LEFT_COORDINATES = [
    [0,0],[0,3],[0,6],[3,0],[3,3],[3,6],[6,0],[6,3],[6,6]
  ]

  attr_reader :matrix

  def subgroup(coords)
    x, y = coords
    matrix[x][y..y+2] + matrix[x+1][y..y+2] + matrix[x+2][y..y+2]
  end

  def has_duplicates?(test_array)
    test_array = test_array.compact
    test_array.length != test_array.uniq.length
  end
end
