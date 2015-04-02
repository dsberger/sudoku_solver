class SudokuSolver
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.solve(puzzle_string)
    new(puzzle_string).solve
  end

  def solve
    # Start creating your solution here.
    #
    # It's likely that you'll want to have many more classes than this one that
    # was provided for you. Don't be hesistant to extract new objects (and
    # write tests for them).
  end
end
