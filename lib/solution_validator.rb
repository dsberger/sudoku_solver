class SolutionValidator

  def initialize(matrix)
    @matrix = matrix
  end

  def solved?
    valid? && complete?
  end

  def valid?
    valid_rows? &&
    valid_columns? &&
    valid_subgroups?
  end

  def complete?
    matrix.map { |row| row.include?(nil) }.none?
  end

  private

  attr_reader :matrix


  def valid_rows?
    ArrayValidator.new(matrix).valid?
  end

  def valid_columns?
    # Same validator as for rows, but with input transposed.
    ArrayValidator.new(matrix.transpose).valid?
  end

  def valid_subgroups?
    SubgroupValidator.new(matrix).valid?
  end
end
