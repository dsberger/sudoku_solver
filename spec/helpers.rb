module Helpers

  def valid_complete
    [ [ 8, 5, 9, 6, 1, 2, 4, 3, 7 ],
      [ 7, 2, 3, 8, 5, 4, 1, 6, 9 ],
      [ 1, 6, 4, 3, 7, 9, 5, 2, 8 ],
      [ 9, 8, 6, 1, 4, 7, 3, 5, 2 ],
      [ 3, 7, 5, 2, 6, 8, 9, 1, 4 ],
      [ 2, 4, 1, 5, 9, 3, 7, 8, 6 ],
      [ 4, 3, 2, 9, 8, 1, 6, 7, 5 ],
      [ 6, 1, 7, 4, 2, 5, 8, 9, 3 ],
      [ 5, 9, 8, 7, 3, 6, 2, 4, 1 ] ]
  end

  def valid_incomplete
    [ [ 8, 5, nil, nil, nil, 2, 4, nil, nil],
      [ 7, 2, nil, nil, nil, nil, nil, nil, 9],
      [ nil, nil, 4, nil, nil, nil, nil, nil, nil],
      [ nil, nil, nil, 1, nil, 7, nil, nil, 2],
      [ 3, nil, 5, nil, nil, nil, 9, nil, nil],
      [ nil, 4, nil, nil, nil, nil, nil, nil, nil],
      [ nil, nil, nil, nil, 8, nil, nil, 7, nil],
      [ nil, 1, 7, nil, nil, nil, nil, nil, nil],
      [ nil, nil, nil, nil, 3, 6, nil, 4, nil] ]
  end

  def invalid_due_to_row_dupe
    [ [8, 8, nil, nil, nil, 2, 4, nil, nil],
      [7, 2, nil, nil, nil, nil, nil, nil, 9],
      [nil, nil, 4, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, 1, nil, 7, nil, nil, 2],
      [3, nil, 5, nil, nil, nil, 9, nil, nil],
      [nil, 4, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, 8, nil, nil, 7, nil],
      [nil, 1, 7, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, 3, 6, nil, 4, nil] ]
  end

  def invalid_due_to_column_dupe
    [ [8, 5, 9, 6, 1, 2, 4, 3, 7],
      [7, 2, 3, 8, 5, 4, 1, 6, 9],
      [1, 6, 4, 3, 7, 9, 5, 2, 8],
      [9, 8, 6, 1, 4, 7, 3, 5, 2],
      [3, 7, 5, 8, 6, 2, 9, 1, 4],
      [2, 4, 1, 5, 9, 3, 7, 8, 6],
      [4, 3, 2, 9, 8, 1, 6, 7, 5],
      [6, 1, 7, 4, 2, 5, 8, 9, 3],
      [5, 9, 8, 7, 3, 6, 2, 4, 1] ]
  end

  def invalid_due_to_subgroup_dupe
    [ [1, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, 1, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil] ]
  end


  def one_cell_left
      [ [ 3, 9, 6, 4, 1, 5, 7, 2, 8],
        [ 8, 1, 4, 9, 7, 2, 3, 5, 6],
        [ 2, 7, 5, 3, 6, 8, 1, 9, 4],
        [ 1, 8, 2, 5, 3, 6, 9, 4, 7],
        [ 7, 5, 3, 2, nil, 9, 6, 8, 1],
        [ 6, 4, 9, 1, 8, 7, 2, 3, 5],
        [ 4, 6, 8, 7, 2, 3, 5, 1, 9],
        [ 5, 3, 7, 8, 9, 1, 4, 6, 2],
        [ 9, 2, 1, 6, 5, 4, 8, 7, 3] ]
  end

  def easy_solution
      [ [ 3, 9, 6, 4, 1, 5, 7, 2, 8],
        [ 8, 1, 4, 9, 7, 2, 3, 5, 6],
        [ 2, 7, 5, 3, 6, 8, 1, 9, 4],
        [ 1, 8, 2, 5, 3, 6, 9, 4, 7],
        [ 7, 5, 3, 2, 4, 9, 6, 8, 1],
        [ 6, 4, 9, 1, 8, 7, 2, 3, 5],
        [ 4, 6, 8, 7, 2, 3, 5, 1, 9],
        [ 5, 3, 7, 8, 9, 1, 4, 6, 2],
        [ 9, 2, 1, 6, 5, 4, 8, 7, 3] ]
  end
end
