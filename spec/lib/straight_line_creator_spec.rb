require "straight_line_creator"
require_relative "../helpers"

describe StraightLineCreator do
  include Helpers

  let(:cell_matrix){ CellMatrixCreator.new(valid_complete).cell_matrix }
  let(:creator){ StraightLineCreator.new(cell_matrix) }

  describe "#lines" do
    it "returns an array" do
      expect(creator.lines).to be_a Array
    end

    it "has nine items" do
      expect(creator.lines.length).to eq 9
    end

    it "contains only BlockOfNine objects" do
      all_block_of_nines = creator.lines.all? { |item| item.is_a?(BlockOfNine) }
      expect(all_block_of_nines).to eq true
    end
  end
end
