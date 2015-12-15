module MatrixTools

  private

  SUBGROUP_TOP_LEFT_COORDINATES = [
    [0,0],[0,3],[0,6],[3,0],[3,3],[3,6],[6,0],[6,3],[6,6]
  ]

  def subgroup_from(any_matrix, x, y)
    any_matrix[x][y..y+2]   +
    any_matrix[x+1][y..y+2] +
    any_matrix[x+2][y..y+2]
  end

  def deep_dup(any_matrix)
    any_matrix.each_with_object([]) do |row, dupe|
      dupe << row.dup
    end
  end

  def has_duplicates?(test_array)
    test_array = test_array.compact
    test_array.length != test_array.uniq.length
  end

end
