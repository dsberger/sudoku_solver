require "grid"
require_relative "../helpers"

describe Grid do
  include Helpers

  describe "#values_matrix" do
    context "with a complete board" do
      it "returns a matrix of completed values" do
        grid = Grid.new_from_matrix(valid_complete)
        expect(grid.values_matrix).to eq valid_complete
      end
    end
  end

  describe "#possibilities_matrix" do
    context "with a complete board" do
      it "returns a 9x9 matrix of nils" do
        grid = Grid.new_from_matrix(valid_complete)
        expect(grid.possibilities_matrix).to eq matrix_of_nils
      end
    end
  end

  describe "#solve!" do
    it "doesn't do anything to a complete array" do
      grid = Grid.new_from_matrix(valid_complete)

      expect(grid.values_matrix).to eq valid_complete
    end

    it "completes a matrix with one cell left" do
      grid = Grid.new_from_matrix(one_cell_left)

      expect(grid.values_matrix).to eq easy_solution
    end
  end

  private

  def matrix_of_nils
    matrix = []
    9.times { matrix << [nil] * 9 }
    matrix
  end

  def create_inverted_matrix(matrix)
    matrix.map do |row|
      row.map do |cell|
        cell.nil? ? (1..9).to_a : nil
      end
    end
  end

end
