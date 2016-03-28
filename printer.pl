showBoard(Width,BoardMaterial):-
  assoc_to_keys(BoardMaterial,K),
  boardPrinter(Width,Width,BoardMaterial,K),nl,!.

boardPrinter(_,_,_,[]):-nl,!.
boardPrinter(Width,0,BoardMaterial,Xs):-
  nl,Wi is Width,boardPrinter(Width,Wi,BoardMaterial,Xs);!.
boardPrinter(Width,Wi,BoardMaterial,[X|Xs]):-
  get_assoc(X,BoardMaterial,V),
  write(V), W is Wi-1,
  boardPrinter(Width,W,BoardMaterial,Xs).
