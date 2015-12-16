#Sudoku Solver

This is based on an Upcase project that I had a lot of fun with. Two of the tests in the `sudoku_solver_spec` file, and the `.sudoku` files, are their creations. Everything in `lib` and the rest of what's in `spec` is my code.

##How to use this solver

There are two ways to solve a sudoku puzzle with the app.

###1. String formatting
If you want to format a puzzle like this:

```
3 0 6 |0 1 5 |0 0 0
0 0 4 |0 0 0 |3 0 0
0 0 0 |0 6 8 |1 9 4
------+------+------
0 8 0 |0 0 6 |0 0 0
0 0 0 |2 4 9 |6 0 1
6 4 0 |0 0 0 |2 0 5
------+------+------
0 0 8 |0 0 3 |0 1 0
0 3 7 |8 9 1 |4 6 2
0 2 0 |6 0 0 |8 0 0
```

(which is Upcase's style), you can save the formatted puzzle as a string and use `SudokuSolver.solve(puzzle_string)` to create a solved puzzle. It will return a similarly formatted string.

###2. Matrix formatting
The way the different objects talk to each other is by passing matrices (nested arrays) around. You can format the same puzzle like this:

```
[ [3, nil, 6, nil, 1, 5, nil, nil, nil],
  [nil, nil, 4, nil, nil, nil, 3, nil, nil],
  [nil, nil, nil, nil, 6, 8, 1, 9, 4],
  [nil, 8, nil, nil, nil, 6, nil, nil, nil],
  [nil, nil, nil, 2, 4, 9, 6, nil, 1],
  [6, 4, nil, nil, nil, nil, 2, nil, 5],
  [nil, nil, 8, nil, nil, 3, nil, 1, nil],
  [nil, 3, 7, 8, 9, 1, 4, 6, 2],
  [nil, 2, nil, 6, nil, nil, 8, nil, nil] ]
```

Note that zeroes have been replaced with nil. Use `GraphSearcher.new(matrix).result`
to get a solved, similarly-formatted matrix in return.

##How does it work?
I'm so glad you asked. There are a lot of objects at work here so I'll try to explain how the important ones are working together.

The [GraphSearcher](./lib/graph_searcher.rb) object is managing all the hard work. All that [SudokuSolver](./sudoku_solver.rb) does is format the `puzzle_string` into a `matrix`, hand it over to the GraphSearcher, and reformat the `result` back into a puzzle_string.

The GraphSearcher works in two phases. First, it creates a `Grid` object and uses what I think of as "human style" solving algorithms to narrow down the possible values of every cell. (More on how below.) Second, if phase one hasn't resulted in a solution, it finds the first unsolved cell in the matrix and creates a GraphSearcher object for each possible value of that cell. **Recursion!** If all those objects fail to find a solution, it returns `false`.

###Human-style solving in the Grid
[Grid](./lib/grid.rb) takes a matrix of integers and nil values and transforms it into a 9x9 matrix of [Cell](./lib/cell.rb) objects. Each cell is then assigned to three of 27 [BlockOfNine](./lib/block_of_nine.rb) objects, i.e. one of nine rows, one of nine columns and one of nine "subgroups" (3x3 squares).

####Cell
A Cell object holds all the location's possible values. It can be solved in two ways: actively by calling `solve!` on it with a specific value, or passively by calling `remove!` until only one value remains. `solve!` and `remove!` both return `true` if successful and `false` if unsuccessful. You'll see why this is important shortly.

####BlockOfNine
The BlockOfNine object is where the real solving action happens, just as it does when we're solving a sudoku puzzle in meatspace. (The difference, of course, in that a Ruby object can apply these tactics in a systematic, algorithmic way.) Calling `hit!` on a block (...method naming is hard...) triggers two kinds of solving.

The first I'm calling `clean_sweep!`, which looks at the known values in the block and `remove!`s those values as options for the unsolved cells.

The second I'm calling `heat_seek!`, which looks at all the values we _haven't_ found yet and determines if that value can only be in one specific cell. If it finds that, for instance, only one cell can be 7, it will call `solve!(7)` on that cell. The next time we have a `clean_sweep!`, 7 will be removed as an option from the other cells in that cells's row, column and subgroup.

If even a single call of `remove!` or `solve!` on a cell returns `true`, the block is considered to have made progress and `hit!` will return `true` as well.

####The loop in Grid.solve!
Now that you understand how Cell and BlockOfNine methods work, the loop in `Grid#solve!` is easier to understand. The loop iterates over all 27 BlockOfNine objects, calling `hit!` on all of them. If even a single change is made to any cell, that change propagates up to the grid level. `Cell#remove!` or `#solve!` returns `true`, so `BlockOfNine#hit!` returns `true`, so `Grid#hit_all!` returns true, so our local variable in Grid, `making_progress`, will be `true` as well. If we iterate over all 27 blocks and not a single cell changes, the loop halts and Grid returns control to the GraphSearcher.

###Back in the GraphSearcher

As far as I can tell, most sudoku puzzles that you'll find in the real world can be solved by the Grid methods alone. But for those that can't, there's recursive graph search!

Our Grid object contains two matrixes for the GraphSearcher to use. `Grid#values_matrix` contains all the solved squares and `Grid#possibilities_matrix` contains all the legal options for the unsolved squares.

Inside the `GraphSearcher#valid_next_iterations` method, we locate a single unsolved cell. We can find all possible values of that cell, and create a new GraphSearch object for all of them.

For instance, say that a specific cell can be 1, 2 or 3. This method makes a GraphSearcher instance assuming that the cell is 1, another assuming that it's 2, and a third assuming that it's 3. Each of those instances then revert to the human-style solving methods of the Grid. If a successful solution can't be found, the `result` will be `false` instead of a matrix.

The "hard puzzle" test (Upcase's) takes about 15 seconds to run. An initial iteration that used only graph search and no human-style solving ran for 90 minutes without errors but didn't find a solution. (I Ctrl-C'ed the run.) On the other hand, using only the human-style solving patterns can't solve it either. Only the combination of both makes a timely solution possible.