class SudokuSolver

  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def self.solve(puzzle_string)
    matrix = MatrixFactory.new(puzzle_string).matrix
    new(matrix).solve
  end

  def solve
    matrix = graph_search
    PuzzleFormatter.new(matrix).puzzle_string
  end

  def solved?
    valid? && complete?
  end

  protected

  # return a solved matrix or false
  def graph_search
    return matrix if solved?

    queue = valid_next_iterations
    result = false

    until result || queue.empty?
      active_puzzle = queue.shift
      result = active_puzzle.graph_search
    end

    result

  end

  def valid?
    SolutionValidator.new(matrix).valid?
  end

  private

  attr_writer :matrix

  def valid_next_iterations
    x, y = coords_of_first_empty_cell
    queue = []

    (1..9).each do |num|
      temp_matrix = duped_matrix
      temp_matrix[x][y] = num
      queue << SudokuSolver.new(temp_matrix)
    end

    queue.select { |sudoku| sudoku.valid? }
  end

  def complete?
    SolutionValidator.new(matrix).complete?
  end

  def duped_matrix
    matrix.each_with_object([]) do |row, dupe|
      dupe << row.dup
    end
  end

  def coords_of_first_empty_cell
    (0..8).each do |row|
      (0..8).each do |col|
        return [row, col] if matrix[row][col].nil?
      end
    end
  end
end
