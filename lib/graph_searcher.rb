class GraphSearcher

  attr_reader :result

  def initialize(matrix)
    @matrix = matrix
    grid = Grid.new_from_matrix(deep_dup(matrix))
    @possibilities_matrix = grid.possibilities_matrix
    @values_matrix = grid.values_matrix
    @result = solve
  end


  private

  attr_reader :matrix, :values_matrix, :possibilities_matrix

  # In Railsy fashion, this returns either a solved matrx or false.
  def solve
    if validator.solved?
      values_matrix                     # <= solved matrix
    elsif validator.valid?
      process_queue_of_next_iterations  # <= solved matrix or false
    else
      false                             # <= false
    end
  end

  def process_queue_of_next_iterations
    queue = valid_next_iterations
    complete_solution = false

    until complete_solution || queue.empty?
      active_graph_search = queue.shift
      complete_solution = active_graph_search.result
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
    possible_values = possibilities_matrix[x][y]

    possible_values.each_with_object([]) do |num, queue|
      temp_values_matrix = deep_dup(values_matrix)
      temp_values_matrix[x][y] = num
      queue << GraphSearcher.new(temp_values_matrix)
    end
  end

  def coords_of_first_empty_cell
    (0..8).each do |row|
      (0..8).each do |col|
        return [row, col] if values_matrix[row][col].nil?
      end
    end
  end

  def validator
    SolutionValidator.new(values_matrix)
  end
end
