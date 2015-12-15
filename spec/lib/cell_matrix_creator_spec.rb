require "cell_matrix_creator"
require_relative "../helpers"

describe CellMatrixCreator do
  include Helpers

  describe "#cell_matrix" do

    let(:creator){ CellMatrixCreator.new(valid_complete) }

    it "is an array" do
      expect(creator.cell_matrix).to be_a Array
    end

    it "is an array with nine items" do
      expect(creator.cell_matrix.length).to eq 9
    end

    it "all nine items are arrays" do
      cell_matrix = creator.cell_matrix
      all_arrays = cell_matrix.all? { |row| row.is_a?(Array) }
      expect(all_arrays).to eq true
    end

    it "all subarrays have nine members" do
      cell_matrix = creator.cell_matrix
      arrays_of_nine = cell_matrix.all? { |row| row.length == 9 }
      expect(arrays_of_nine).to eq true
    end

    it "contains only Cell objects" do
      cell_matrix = creator.cell_matrix
      all_cells = cell_matrix.flatten.all? { |cell| cell.is_a? Cell}
      expect(all_cells).to eq true
    end
  end
end
