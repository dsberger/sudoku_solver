class GraphSearcher

  attr_reader :result

  def initialize(matrix)
    @matrix = matrix
    @result = solve
  end

  private

  def solve

    grid = Grid.new_from_matrix(deep_dup(matrix))
    grid.solve!

    @possibilities_matrix = grid.possibilities_matrix
    @values_matrix = grid.values_matrix

    validator = SolutionValidator.new(values_matrix)

    if validator.solved?
      values_matrix
    elsif validator.valid?
      process_queue_of_next_iterations
    else
      false
    end

  end

  attr_reader :matrix, :values_matrix, :possibilities_matrix

  def process_queue_of_next_iterations
    queue = valid_next_iterations.shuffle
    complete_solution = false

    until complete_solution || queue.empty?
      active_puzzle = queue.shift
      complete_solution = active_puzzle.result
    end

    complete_solution
  end

  def deep_dup(any_matrix)
    any_matrix.each_with_object([]) do |row, dupe|
      dupe << row.dup
    end
  end

  def valid_next_iterations
    x, y = coords_of_first_empty_cell
    queue = []

    possible_values = possibilities_matrix[x][y]
    possible_values.each do |num|
      temp_values_matrix = deep_dup(values_matrix)
      temp_values_matrix[x][y] = num
      queue << GraphSearcher.new(temp_values_matrix)
    end

    queue
  end

  def coords_of_first_empty_cell
    (0..8).each do |row|
      (0..8).each do |col|
        return [row, col] if values_matrix[row][col].nil?
      end
    end
  end
end
