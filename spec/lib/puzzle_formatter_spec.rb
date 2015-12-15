require "puzzle_formatter"
require_relative "../helpers"

describe PuzzleFormatter do
  include Helpers

  it "formats a matrix correctly" do
    file = File.read("spec/fixtures/valid_incomplete.sudoku")
    file.chomp!
    formatter = PuzzleFormatter.new(valid_incomplete)

    expect(formatter.puzzle_string).to eq file
  end
end
