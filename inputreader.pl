:- consult('p99-readfile'). %% Natuke muutsin allikat: http://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/p99-readfile.pl

getFileInfo(FileName,Lines,Height,Width,Board):-
  read_lines(FileName,Lines),
  getBoardHeight(Lines,Height),
  getBoardWidth(Lines,Width),
  initBoard(Lines,Height,Width,Board).

getBoardWidth([Firstrow|_],Width):-
  length(Firstrow,Width).

getBoardHeight(Lines,Height):-
  length(Lines,Height).

uniteBoardRows(S,-1,_,S):- !.
uniteBoardRows(Start,Height,Width,UnitedRows):-
  Height >= 0,
  setBoardRows(Height,Width,Row),
  append([Row],Start,X),
  H is Height-1,
  uniteBoardRows(X,H,Width,UnitedRows).

setBoardRows(RowNr,Width,Cells):-
  range(RowNr,0,Width,Cells),true.

range(J,I,I,[[J,I]]):-!.
range(J,I,K,[[J,I]|L]) :- I < K, I1 is I + 1, range(J,I1,K,L).

initBoard(Lines,Height,Width,Board):-
  empty_assoc(Start),
  H is Height-1, W is Width-1,
  uniteBoardRows([],H,W,URows),
  boardKeyFiller(Lines,URows,Start,Board).

boardKeyFiller(_,[],S,S):- !.
boardKeyFiller([Y|Ys],[X|Xs],Start,Board):-
  fillerHelp(Y,X,Start,BoardMaterial),
  boardKeyFiller(Ys,Xs,BoardMaterial,Board).

fillerHelp(_,[],S,S):- !.
fillerHelp([Y|Ys],[X|Xs],Start,Board):-
  put_assoc(X,Start,Y,BoardMaterial),
  fillerHelp(Ys,Xs,BoardMaterial,Board).
