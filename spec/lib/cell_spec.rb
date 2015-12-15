require "cell"

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
        cell = Cell.new
        (1..7).each { |n| cell.remove!(n) }
        expect(cell.value).to eq nil
      end

      it "returns the value when only one possibility remains" do
        cell = Cell.new
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
        cell = Cell.new
        expect(cell.possibilities).to eq (1..9).to_a
      end

      it "returns remaining possible values after some have been removed" do
        cell = Cell.new
        (1..5).each { |n| cell.remove!(n) }
        cell.remove!(8)
        expect(cell.possibilities).to eq [6,7,9]
      end

      it "returns nil when only one possibility remains" do
        cell = Cell.new
        (2..9).each { |n| cell.remove!(n) }
        expect(cell.possibilities).to eq nil
      end
    end
  end

  describe "#remove!" do
    context "when the argument is in the array of possible values" do
      it "removes the integer from the array" do
        cell = Cell.new
        cell.remove!(2)
        expect(cell.possibilities).to eq [1,3,4,5,6,7,8,9]
      end

      it "returns true" do
        cell = Cell.new
        expect(cell.remove!(2)).to eq true
      end
    end

    context "when the argument is not in the array of possible values" do
      it "returns false" do
        cell = Cell.new
        (1..7).each { |n| cell.remove!(n)}
        expect(cell.remove!(1)).to eq false
      end
    end

    context "when the argument is the only remaining value" do
      it "does not delete the only remaining value" do
        cell = Cell.new(4)
        cell.remove!(4)
        expect(cell.value).to eq 4
      end

      it "returns false" do
        cell = Cell.new(4)
        expect(cell.remove!(4)).to eq false
      end
    end
  end

  describe "solve!" do
    context "argument is found in possibilities" do
      it "deletes all other possibilities" do
        cell = Cell.new
        (1..6).each { |n| cell.remove!(n) }
        cell.solve!(8)
        expect(cell.value).to eq 8
      end

      it "returns true" do
        cell = Cell.new
        (1..6).each { |n| cell.remove!(n) }
        expect(cell.solve!(8)).to eq true
      end
    end

    context "argument is not found in possibilities" do
      it "does nothing" do
        cell = Cell.new
        (1..6).each { |n| cell.remove!(n) }
        cell.solve!(5)
        expect(cell.possibilities).to eq [7, 8, 9]
      end

      it "returns false" do
        cell = Cell.new
        (1..6).each { |n| cell.remove!(n) }
        expect(cell.solve!(5)).to eq false
      end
    end

    context "cell is already solved" do
      it "does nothing" do
        cell = Cell.new(4)
        cell.solve!(8)
        expect(cell.value).to eq 4
      end

      it "returns false" do
        cell = Cell.new(4)
        expect(cell.solve!(8)).to eq false
      end
    end
  end
end
