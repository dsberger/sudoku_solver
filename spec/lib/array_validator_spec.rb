require "array_validator"
require_relative "../helpers"

describe ArrayValidator do
  include Helpers

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
