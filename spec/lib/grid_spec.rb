require_relative '../../lib/grid'

describe Grid do

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

  describe "#values_matrix" do
    context "with a complete board" do
      it "returns a matrix of completed values" do
        grid = Grid.new_from_matrix(valid_complete)
        expect(grid.values_matrix).to eq valid_complete
      end
    end

    context "with an incomplete board" do
      it "returns a matrix of completed values" do
        grid = Grid.new_from_matrix(valid_incomplete)
        expect(grid.values_matrix).to eq valid_incomplete
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

    context "with an unsolved, incomplete board" do
      it "returns nil where there's a number and a 1 to 9 range where there is not" do
        grid = Grid.new_from_matrix(valid_incomplete)

        test_matrix = create_inverted_matrix(valid_incomplete)

        expect(grid.possibilities_matrix).to eq test_matrix
      end
    end
  end

  describe "#solve!" do
    it "doesn't do anything to a complete array" do
      grid = Grid.new_from_matrix(valid_complete)

      grid.solve!
      expect(grid.values_matrix).to eq valid_complete
    end

    it "completes a matrix with one cell left" do
      input = [
        [ 3, 9, 6, 4, 1, 5, 7, 2, 8],
        [ 8, 1, 4, 9, 7, 2, 3, 5, 6],
        [ 2, 7, 5, 3, 6, 8, 1, 9, 4],
        [ 1, 8, 2, 5, 3, 6, 9, 4, 7],
        [ 7, 5, 3, 2, nil, 9, 6, 8, 1],
        [ 6, 4, 9, 1, 8, 7, 2, 3, 5],
        [ 4, 6, 8, 7, 2, 3, 5, 1, 9],
        [ 5, 3, 7, 8, 9, 1, 4, 6, 2],
        [ 9, 2, 1, 6, 5, 4, 8, 7, 3]
      ]

      grid = Grid.new_from_matrix(input)
      grid.solve!
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

  def easy_solution
      [
        [ 3, 9, 6, 4, 1, 5, 7, 2, 8],
        [ 8, 1, 4, 9, 7, 2, 3, 5, 6],
        [ 2, 7, 5, 3, 6, 8, 1, 9, 4],
        [ 1, 8, 2, 5, 3, 6, 9, 4, 7],
        [ 7, 5, 3, 2, 4, 9, 6, 8, 1],
        [ 6, 4, 9, 1, 8, 7, 2, 3, 5],
        [ 4, 6, 8, 7, 2, 3, 5, 1, 9],
        [ 5, 3, 7, 8, 9, 1, 4, 6, 2],
        [ 9, 2, 1, 6, 5, 4, 8, 7, 3]
      ]
  end
end
