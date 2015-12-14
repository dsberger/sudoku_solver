require_relative "../lib/graph_searcher"
require_relative "../lib/grid"

class SudokuSolver

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
    matrix.each_with_object([]) do |row, dupe|
      dupe << row.dup
    end
  end

end
