require "subgroup_creator"
require_relative "../helpers"

describe SubgroupCreator do
  include Helpers

  let(:cell_matrix){ CellMatrixCreator.new(valid_complete).cell_matrix }
  let(:creator){ SubgroupCreator.new(cell_matrix) }

  describe "#subgroups" do
    it "returns an array" do
      expect(creator.subgroups).to be_a Array
    end

    it "has nine items" do
      expect(creator.subgroups.length).to eq 9
    end

    it "contains only BlockOfNine objects" do
      all_block_of_nines = creator.subgroups.all? { |item| item.is_a?(BlockOfNine) }
      expect(all_block_of_nines).to eq true
    end
  end
end
