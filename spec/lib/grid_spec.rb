require_relative '../../lib/grid'

describe Grid do

  describe ".new" do
    it "is private" do
      expect(Grid.new).to raise "private method `new' called for Grid:Class"
    end
  end
end
