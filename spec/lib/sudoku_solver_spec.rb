require "sudoku_solver"

describe SudokuSolver do
  describe ".solve" do
    it "returns a solved puzzle" do
      puzzle = open_sudoku_puzzle("solved")

      expect(SudokuSolver.solve(puzzle)).to eq(easy_solution)
    end

    it "solves a puzzle with one square left" do
      puzzle = open_sudoku_puzzle("one_left")

      expect(SudokuSolver.solve(puzzle)).to eq(easy_solution)
    end

    it "solves a puzzle with one subgroup empty" do
      puzzle = open_sudoku_puzzle("empty_subgroup")

      expect(SudokuSolver.solve(puzzle)).to eq(easy_solution)
    end

    it "solves an easy puzzle" do
      puzzle = open_sudoku_puzzle("easy")

      expect(SudokuSolver.solve(puzzle)).to eq(easy_solution)
    end

    xit "solves an hard puzzle" do
      puzzle = open_sudoku_puzzle("hard")

      expect(SudokuSolver.solve(puzzle)).to eq(hard_solution)
    end

    def easy_solution
      <<EOS.sub(/\s+$/, "")
3 9 6 |4 1 5 |7 2 8
8 1 4 |9 7 2 |3 5 6
2 7 5 |3 6 8 |1 9 4
------+------+------
1 8 2 |5 3 6 |9 4 7
7 5 3 |2 4 9 |6 8 1
6 4 9 |1 8 7 |2 3 5
------+------+------
4 6 8 |7 2 3 |5 1 9
5 3 7 |8 9 1 |4 6 2
9 2 1 |6 5 4 |8 7 3
EOS
    end

    def hard_solution
      <<EOS.sub(/\s+$/, "")
4 1 7 |3 6 9 |8 2 5
6 3 2 |1 5 8 |9 4 7
9 5 8 |7 2 4 |3 1 6
------+------+------
8 2 5 |4 3 7 |1 6 9
7 9 1 |5 8 6 |4 3 2
3 4 6 |9 1 2 |7 5 8
------+------+------
2 8 9 |6 4 3 |5 7 1
5 7 3 |2 9 1 |6 8 4
1 6 4 |8 7 5 |2 9 3
EOS
    end
  end

  def open_sudoku_puzzle(file_name)
    File.read("spec/fixtures/" + file_name + ".sudoku")
  end
end
