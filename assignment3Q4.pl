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

% Main function to find the solution
find_bfs_solution :-
    initial_state(Start),
    bfs([[Start]], Solution),
    write('BFS Solution: '), write(Solution), nl.
