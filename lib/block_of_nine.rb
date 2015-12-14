class BlockOfNine

  def initialize
    @cells = []
  end

  def add_cell(cell)
    @cells << cell
  end

  def remove!(n)
    remove_from_unsolved_cells(n) unless found(n)
  end

  def hit!
    sweep_clean!
    heat_seek!
  end

  private

  attr_reader :cells

  def remove_from_unsolved_cells(n)
    unsolved_cells.each { |cell| cell.remove!(n) }
  end

  def found(n)
    found_values.include?(n)
  end

  def sweep_clean!
    found_values.each { |n| remove_from_unsolved_cells(n) }
  end

  def heat_seek!
    looking_for = unfound_values
    looking_for.each do |n|
      capture = cells_that_might_be(n)
      capture[0].solve!(n) if capture.length == 1
    end
  end

  def unfound_values
    (1..9).to_a - found_values
  end

  def cells_that_might_be(n)
    unsolved_cells.select { |cell| cell.possibilities.include?(n) }
  end

  def found_values
    solved_cells.map { |cell| cell.value }.sort
  end

  def unsolved_cells
    cells.reject { |cell| cell.value }
  end

  def solved_cells
    cells.select { |cell| cell.value }
  end
end
