# Farmer-s-Problem

## Overview

The classic Farmer's problem, where a farmer needs to get a wolf, a goat, and a cabbage across a river. The boat can only carry one of them at a time, and certain combinations are unsafe to leave together. The code uses both Depth-First Search (DFS) and Breadth-First Search (BFS) algorithms to find the solution.

## Dependencies

- SWI-Prolog

## Features

1. **DFS Algorithm**: Solves the problem using Depth-First Search.
2. **BFS Algorithm**: Solves the problem using Breadth-First Search.
3. **Safety Checks**: Includes rules to ensure the combinations left on either side of the river are safe.
4. **Solution Display**: Outputs the steps of the solution.

## Usage

1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Run the Prolog interpreter:
    ```bash
    swipl
    ```
4. Load the desired Prolog file:
    ```prolog
    [Farmer's_Problem.pl].
    ```
5. Run the main function to find the solution:
    ```prolog
    find_dfs_solution.
    ```
   Or for BFS:
    ```prolog
    find_bfs_solution.
    ```

