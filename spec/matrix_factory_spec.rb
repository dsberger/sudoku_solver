require_relative '../lib/matrix_factory'

describe MatrixFactory do
  describe "#matrix" do

    describe "general return values" do

      before do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        @factory = MatrixFactory.new(file)
      end

      it "returns an array" do
        expect(@factory.matrix).to be_a Array
      end

      it "returns an array of length nine" do
        expect(@factory.matrix.length).to eq 9
      end

      it "each array is an array of length 9" do
        lengths = @factory.matrix.map { |arr| arr.length }
        expect(lengths).to eq([9] * 9)
      end
    end

    describe "specific return values" do
      it "converts valid_incomplete correctly" do
        file = File.read("spec/fixtures/valid_incomplete.sudoku")
        factory = MatrixFactory.new(file)

        output = [
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

        expect(factory.matrix).to eq output
      end

      it "converts valid_complete correctly" do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        factory = MatrixFactory.new(file)

        output = [
          [ 8, 5, 9, 6, 1, 2, 4, 3, 7 ],
          [ 7, 2, 3, 8, 5, 4, 1, 6, 9 ],
          [ 1, 6, 4, 3, 7, 9, 5, 2, 8 ],
          [ 9, 8, 6, 1, 4, 7, 3, 5, 2 ],
          [ 3, 7, 5, 2, 6, 8, 9, 1, 4 ],
          [ 2, 4, 1, 5, 9, 3, 7, 8, 6 ],
          [ 4, 3, 2, 9, 8, 1, 6, 7, 5 ],
          [ 6, 1, 7, 4, 2, 5, 8, 9, 3 ],
          [ 5, 9, 8, 7, 3, 6, 2, 4, 1 ]
        ]

        expect(factory.matrix).to eq output
      end

      it "converts invalid_due_to_column_dupe correctly" do
        file = File.read("spec/fixtures/invalid_due_to_column_dupe.sudoku")
        factory = MatrixFactory.new(file)

        output = [
          [8, 5, 9, 6, 1, 2, 4, 3, 7],
          [7, 2, 3, 8, 5, 4, 1, 6, 9],
          [1, 6, 4, 3, 7, 9, 5, 2, 8],
          [9, 8, 6, 1, 4, 7, 3, 5, 2],
          [3, 7, 5, 8, 6, 2, 9, 1, 4],
          [2, 4, 1, 5, 9, 3, 7, 8, 6],
          [4, 3, 2, 9, 8, 1, 6, 7, 5],
          [6, 1, 7, 4, 2, 5, 8, 9, 3],
          [5, 9, 8, 7, 3, 6, 2, 4, 1]
        ]

        expect(factory.matrix).to eq output
      end
    end
  end
end
