class ArrayValidator

  def initialize(matrix)
    @matrix = matrix
  end

  def valid?
    matrix.map { |row| has_duplicates?(row) }.none?
  end


  private

  attr_reader :matrix

  def has_duplicates?(test_array)
    test_array = test_array.compact
    test_array.length != test_array.uniq.length
  end
end
