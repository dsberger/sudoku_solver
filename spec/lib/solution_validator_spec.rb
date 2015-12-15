require "solution_validator"
require_relative "../helpers"

describe SolutionValidator do
  include Helpers

  describe "valid?" do
    it "returns true when valid and incomplete" do
      validator = SolutionValidator.new(valid_incomplete)
      expect(validator.valid?).to eq true
    end

    it "returns true when valid and complete" do
      validator = SolutionValidator.new(valid_complete)
      expect(validator.valid?).to eq true
    end

    it "returns false with a column dupe" do
      validator = SolutionValidator.new(invalid_due_to_column_dupe)
      expect(validator.valid?).to eq false
    end

    it "returns false with a row dupe" do
      validator = SolutionValidator.new(invalid_due_to_row_dupe)
      expect(validator.valid?).to eq false
    end

    it "returns false with a subgroup dupe" do
      validator = SolutionValidator.new(invalid_due_to_subgroup_dupe)
      expect(validator.valid?).to eq false
    end
  end

  describe "complete?" do
    it "returns true with no nil values" do
      validator = SolutionValidator.new(valid_complete)
      expect(validator.complete?).to eq true
    end

    it "returns false with one nil value" do
      validator = SolutionValidator.new(valid_incomplete)
      expect(validator.complete?).to eq false
    end
  end
end
