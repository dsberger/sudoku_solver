class GraphSearcher

  attr_reader :result

  def initialize(matrix)
    @matrix = matrix
    @result = solve
  end

  private

  def solve
    return matrix if solved?

    queue = valid_next_iterations
    complete_solution = false

    until complete_solution || queue.empty?
      active_puzzle = queue.shift
      complete_solution = active_puzzle.result
    end

    complete_solution

  end

  attr_reader :matrix

  def duped_matrix
    matrix.each_with_object([]) do |row, dupe|
      dupe << row.dup
    end
  end

  def valid_next_iterations
    x, y = coords_of_first_empty_cell
    queue = []

    (1..9).each do |num|
      temp_matrix = duped_matrix
      temp_matrix[x][y] = num
      if SolutionValidator.new(temp_matrix).valid?
        queue << GraphSearcher.new(temp_matrix)
      end
    end

    queue
  end

  def coords_of_first_empty_cell
    (0..8).each do |row|
      (0..8).each do |col|
        return [row, col] if matrix[row][col].nil?
      end
    end
  end

  def solved?
    SolutionValidator.new(matrix).solved?
  end
end
