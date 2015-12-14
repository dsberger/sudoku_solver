require_relative "../../lib/cell"

describe Cell do

  describe "#value" do
    context "created with a value" do
      it "returns that value" do
        cell = Cell.new(8)
        expect(cell.value).to eq 8
      end
    end

    context "created without a value" do
      it "returns nil before any possibilities are removed" do
        cell = Cell.new
        expect(cell.value).to eq nil
      end

      it "returns nil while two possibilities still remain" do
        cell = cell_with_mocked_blocks
        (1..7).each { |n| cell.remove!(n) }
        expect(cell.value).to eq nil
      end

      it "returns the value when only one possibility remains" do
        cell = cell_with_mocked_blocks
        (1..8).each { |n| cell.remove!(n) }
        expect(cell.value).to eq 9
      end
    end
  end

  describe "#possibilities" do
    context "created with a value" do
      it "returns nil" do
        cell = Cell.new(4)
        expect(cell.possibilities).to eq nil
      end
    end

    context "created without a value" do
      it "returns all possible value before any have been removed" do
        cell = cell_with_mocked_blocks
        expect(cell.possibilities).to eq (1..9).to_a
      end

      it "returns remaining possible values after some have been removed" do
        cell = cell_with_mocked_blocks
        (1..5).each { |n| cell.remove!(n) }
        cell.remove!(8)
        expect(cell.possibilities).to eq [6,7,9]
      end

      it "returns nil when only one possibility remains" do
        cell = cell_with_mocked_blocks
        (2..9).each { |n| cell.remove!(n) }
        expect(cell.possibilities).to eq nil
      end
    end
  end

  describe "#remove!" do
    it "removes the integer from the array of possible values" do
      cell = cell_with_mocked_blocks
      cell.remove!(2)
      expect(cell.possibilities).to eq [1,3,4,5,6,7,8,9]
    end

    it "does not delete the only remaining value" do
      cell = cell_with_mocked_blocks(4)
      cell.remove!(4)
      expect(cell.value).to eq 4
    end

    it "calls remove! on the row" do
      cell = cell_with_mocked_blocks

      row = double("row")
      allow(row).to receive(:remove!).and_return(nil)
      cell.row = row

      expect(row).to receive(:remove!)
      cell.remove!(4)
    end

    it "calls remove! on the column" do
      cell = cell_with_mocked_blocks

      column = double("column")
      allow(column).to receive(:remove!).and_return(nil)
      cell.column = column

      expect(column).to receive(:remove!)
      cell.remove!(4)
    end

    it "calls remove! on the subgroup" do
      cell = cell_with_mocked_blocks

      subgroup = double("subgroup")
      allow(subgroup).to receive(:remove!).and_return(nil)
      cell.subgroup = subgroup

      expect(subgroup).to receive(:remove!)
      cell.remove!(4)
    end
  end

  describe "#row=" do
    it "allows a row to be assigned" do
      cell = Cell.new
      expect {
        cell.row = "foo"
      }.not_to raise_error
    end
  end

  describe "#column=" do
    it "allows a column to be assigned" do
      cell = Cell.new
      expect {
        cell.column = "foo"
      }.not_to raise_error
    end
  end

  describe "#subgroup=" do
    it "allows a subgroup to be assigned" do
      cell = Cell.new
      expect {
        cell.subgroup = "foo"
      }.not_to raise_error
    end
  end

  describe "solve!" do
    context "argument is found in possibilities" do
      it "deletes all other possibilities" do
        cell = cell_with_mocked_blocks
        (1..6).each { |n| cell.remove!(n) }
        cell.solve!(8)
        expect(cell.value).to eq 8
      end
    end

    context "argument is not found in possibilities" do
      it "does nothing" do
        cell = cell_with_mocked_blocks
        (1..6).each { |n| cell.remove!(n) }
        cell.solve!(5)
        expect(cell.possibilities).to eq [7, 8, 9]
      end
    end

    context "cell is already solved" do
      it "does nothing" do
        cell = cell_with_mocked_blocks(4)
        cell.solve!(8)
        expect(cell.value).to eq 4
      end
    end
  end

  private

  def cell_with_mocked_blocks(value = nil)
    cell = Cell.new(value)

    row = double("row")
    column = double("column")
    subgroup = double("subgroup")

    allow(row).to receive(:remove!).and_return(nil)
    allow(column).to receive(:remove!).and_return(nil)
    allow(subgroup).to receive(:remove!).and_return(nil)

    cell.row = row
    cell.column = column
    cell.subgroup = subgroup

    return cell
  end
end
