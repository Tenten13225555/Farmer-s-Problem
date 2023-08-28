Code (Depth-First Search)
% Define the initial state and the goal state.
initial_state(state(e, e, e, e)).
goal_state(state(w, w, w, w)).

% Check if a given state is safe.
is_safe(state(FP, GP, WP, CP)) :-
    (GP \= WP ; FP = WP),   % If goat and wolf are on different shores, or if they're on the same shore as the farmer.
    (GP \= CP ; FP = CP).   % If goat and cabbage are on different shores, or if they're on the same shore as the farmer.

% Possible moves:
% Farmer can move alone.
move(state(FP, GP, WP, CP), state(NP, GP, WP, CP)) :- opposite(FP, NP).

% Farmer can move with the goat.
move(state(FP, FP, WP, CP), state(NP, NP, WP, CP)) :- opposite(FP, NP).

% Farmer can move with the wolf.
move(state(FP, GP, FP, CP), state(NP, GP, NP, CP)) :- opposite(FP, NP).

% Farmer can move with the cabbage.
move(state(FP, GP, WP, FP), state(NP, GP, WP, NP)) :- opposite(FP, NP).

% Helper predicate to determine opposite shores.
opposite(e, w).
opposite(w, e).
% Depth-first search with cycle detection.
dfs(Current, _, Path, Path) :- goal_state(Current).  % If the current state is the goal state, we are done.
dfs(Current, Visited, _, _) :-
    member(Current, Visited), !, fail. % If we've seen this state before, cut and fail.
dfs(Current, Visited, CurrentPath, Solution) :-
    move(Current, NextState),
    is_safe(NextState),
    dfs(NextState, [Current|Visited], [NextState|CurrentPath], Solution).

% Main function to find the solution using DFS
find_dfs_solution :-
    initial_state(Start),
    dfs(Start, [], [Start], Solution),
    write('DFS Solution: '), write(Solution), nl.


Code (Breadth-First Search)
% Define the initial state and goal state
initial_state((e, e, e, e)).
goal_state((w, w, w, w)).

% Define the legal moves
legal((F, G, W, C), (NF, G, W, C)) :- move(F, NF), \+ unsafe(NF, G, W, C).
legal((F, F, W, C), (NF, NF, W, C)) :- move(F, NF), \+ unsafe(NF, NF, W, C).
legal((F, G, F, C), (NF, G, NF, C)) :- move(F, NF), \+ unsafe(NF, G, NF, C).
legal((F, G, W, F), (NF, G, W, NF)) :- move(F, NF), \+ unsafe(NF, G, W, NF).

% Define the unsafe states
unsafe(F, G, W, _) :- F \= G, G = W.
unsafe(F, G, _, C) :- F \= C, G = C.

% Define the possible moves for the farmer
move(e, w).
move(w, e).

% Breadth-First Search
bfs([[Node|Path]|_], [Node|Path]) :-
    goal_state(Node).

bfs([[Node|Path]|Paths], Solution) :-
    findall([Next, Node|Path],
            (legal(Node, Next), \+ member(Next, [Node|Path])),
            NewPaths),
    append(Paths, NewPaths, UpdatedPaths),
    bfs(UpdatedPaths, Solution).

% Main function to find the solution using BFS
find_bfs_solution :-
    initial_state(Start),
    bfs([[Start]], Solution),
    write('BFS Solution: '), write(Solution), nl.

