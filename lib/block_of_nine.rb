class BlockOfNine

  def initialize
    @cells = []
    @made_progress = false
  end

  def add_cell(cell)
    @cells << cell
  end

  def hit!
    @made_progress = false
    sweep_clean!
    heat_seek!
    made_progress
  end


  private

  attr_reader :cells, :made_progress

  def sweep_clean!
    found_values.each { |n| remove_from_unsolved_cells(n) }
  end

  def remove_from_unsolved_cells(n)
    removed = []
    unsolved_cells.each do |cell|
      removed << cell.remove!(n)
    end
    @made_progress = removed.any? unless made_progress
  end

  def heat_seek!
    looking_for = unfound_values
    looking_for.each { |n| try_to_solve_only_remaining(n) }
  end

  def try_to_solve_only_remaining(n)
    solved = false
    capture = cells_that_might_be(n)
    if capture.length == 1
      solved = capture[0].solve!(n)
    end
    @made_progress = solved unless made_progress
  end

  def found(n)
    found_values.include?(n)
  end

  def cells_that_might_be(n)
    unsolved_cells.select { |cell| cell.possibilities.include?(n) }
  end

  def found_values
    solved_cells.map { |cell| cell.value }.sort
  end

  def unfound_values
    (1..9).to_a - found_values
  end

  def unsolved_cells
    cells.reject { |cell| cell.value }
  end

  def solved_cells
    cells.select { |cell| cell.value }
  end
end
