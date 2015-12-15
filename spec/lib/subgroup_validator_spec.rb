require "subgroup_validator"
require_relative "../helpers"

describe SubgroupValidator do
  include Helpers

  describe "#valid?" do
    it "returns true when valid and complete" do
      validator = SubgroupValidator.new(valid_complete)
      expect(validator.valid?).to eq true
    end

    it "returns true when valid and incomplete" do
      validator = SubgroupValidator.new(valid_incomplete)
      expect(validator.valid?).to eq true
    end

    it "returns false when invalid due to subgroup dupe" do
      validator = SubgroupValidator.new(invalid_due_to_subgroup_dupe)
      expect(validator.valid?).to eq false
    end
  end
end
