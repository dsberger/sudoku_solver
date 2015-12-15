require_relative "../modules/matrix_tools"

class SudokuSolver
  include MatrixTools

  def initialize(matrix)
    @matrix = matrix
  end

  def self.solve(puzzle_string)
    matrix = MatrixFactory.new(puzzle_string).matrix
    new(matrix).solve
  end

  def solve
    matrix = GraphSearcher.new(duped_matrix).result
    PuzzleFormatter.new(matrix).puzzle_string
  end


  private

  attr_accessor :matrix

  def duped_matrix
    deep_dup(matrix)
  end

end
