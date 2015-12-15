require_relative '../../lib/array_validator'

describe ArrayValidator do

  let(:valid_complete) do
    [
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
  end

  let(:valid_incomplete) do
    [
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
  end

  let(:invalid_due_to_row_dupe) do
    [
      [8, 8, nil, nil, nil, 2, 4, nil, nil],
      [7, 2, nil, nil, nil, nil, nil, nil, 9],
      [nil, nil, 4, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, 1, nil, 7, nil, nil, 2],
      [3, nil, 5, nil, nil, nil, 9, nil, nil],
      [nil, 4, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, 8, nil, nil, 7, nil],
      [nil, 1, 7, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, 3, 6, nil, 4, nil]
    ]
  end

  let(:invalid_due_to_column_dupe) do
    [
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
  end

  describe "#valid?" do
    context "as row validator" do
      it "returns true when valid and complete" do
        validator = ArrayValidator.new(valid_complete)
        expect(validator.valid?).to eq true
      end

      it "returns true when valid and incomplete" do
        validator = ArrayValidator.new(valid_incomplete)
        expect(validator.valid?).to eq true
      end

      it "returns false when invalid due to row dupe" do
        validator = ArrayValidator.new(invalid_due_to_row_dupe)
        expect(validator.valid?).to eq false
      end
    end

    context "as column validator with transposed input" do
      it "returns true when valid and complete" do
        validator = ArrayValidator.new(valid_complete.transpose)
        expect(validator.valid?).to eq true
      end

      it "returns true when valid and incomplete" do
        validator = ArrayValidator.new(valid_incomplete.transpose)
        expect(validator.valid?).to eq true
      end

      it "returns false when invalid due to column dupe" do
        validator = ArrayValidator.new(invalid_due_to_column_dupe.transpose)
        expect(validator.valid?).to eq false
      end
    end
  end
end
