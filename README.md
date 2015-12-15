# Sudoku Solver

This is based on an Upcase project that I had a lot of fun with. Two of the tests in the `sudoku_solver_spec` file, and the sudoku files, are their creations. Everything in `lib` and the rest of what's in `spec` is my code.

The core of the solution is a GraphSearcher object that:

1. creates a board state (`Grid`),
2. tries to solve the grid by cycling though human-style search patterns until it's no longer making progress, then
3. recursively creates a new GraphSearcher for the remaining options.

The "hard puzzle" test takes about 15 seconds to run. Interesting observation: An initial iteration that used only graph search and no human-style solving ran for 90 minutes, without errors, but didn't find a solution. (I Ctrl-C'ed the run.) On the other hand, using just the human-style solving patterns can't solve it either. Only the combination of both makes a timely solution possible.
