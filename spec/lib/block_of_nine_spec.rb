require_relative '../../lib/block_of_nine'

describe BlockOfNine do

  describe "#remove!" do
    context "when the value has already been found" do
      it "does nothing" do
        block = BlockOfNine.new
        cell_4 = Cell.new(4)
        block.add_cell(cell_4)
        expect(cell_4).not_to receive(:remove!)
        block.remove!(4)
      end
    end

    context "whin the value has not been found" do
      it "calls #remove! on every unsolved cell" do
        block = BlockOfNine.new

        cell_4 = Cell.new(4)
        cell_6 = Cell.new(6)
        cell_3 = Cell.new(3)
        cell_empty = Cell.new

        block.add_cell(cell_4)
        block.add_cell(cell_6)
        block.add_cell(cell_3)
        block.add_cell(cell_empty)

        expect(cell_4).not_to receive(:remove!)
        expect(cell_6).not_to receive(:remove!)
        expect(cell_3).not_to receive(:remove!)
        expect(cell_empty).to receive(:remove!)

        block.remove!(5)
      end
    end
  end
end
