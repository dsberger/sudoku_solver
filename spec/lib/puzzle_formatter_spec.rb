require_relative '../../lib/puzzle_formatter'

describe PuzzleFormatter do
  it "formats a matrix correctly" do
    input = [
      [ 8, 5, nil, nil, nil, 2, 4, nil, nil],
      [ 7, 2, nil, nil, nil, nil, nil, nil, 9],
      [ nil, nil, 4, nil, nil, nil, nil, nil, nil],
      [ nil, nil, nil, 1, nil, 7, nil, nil, 2],
      [ 3, nil, 5, nil, nil, nil, 9, nil, nil],
      [ nil, 4, nil, nil, nil, nil, nil, nil, nil],
      [ nil, nil, nil, nil, 8, nil, nil, 7, nil],
      [ nil, 1, 7, nil, nil, nil, nil, nil, nil],
      [ nil, nil, nil, nil, 3, 6, nil, 4, nil]
    ]

    file = File.read("spec/fixtures/valid_incomplete.sudoku")
    file.chomp!
    formatter = PuzzleFormatter.new(input)

    expect(formatter.puzzle_string).to eq file
  end
end
