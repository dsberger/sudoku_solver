require "matrix_factory"
require_relative "../helpers"

describe MatrixFactory do
  include Helpers

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

        expect(factory.matrix).to eq valid_incomplete
      end

      it "converts valid_complete correctly" do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        factory = MatrixFactory.new(file)

        expect(factory.matrix).to eq valid_complete
      end

      it "converts invalid_due_to_column_dupe correctly" do
        file = File.read("spec/fixtures/invalid_due_to_column_dupe.sudoku")
        factory = MatrixFactory.new(file)

        expect(factory.matrix).to eq invalid_due_to_column_dupe
      end
    end
  end
end
