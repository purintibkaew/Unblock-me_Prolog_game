isVertical(Elem,Board,Bool):-
  getElem(Elem,Board,Coordinates),
  verticalCheck(Coordinates),
  Bool is 1,!; Bool is 0,!.

verticalCheck([[X,_],[Z,_]]):-X\=Z,!.
verticalCheck([[X,_],[Z,W]|Xs]):-
  X\=Z,verticalCheck([[Z,W]|Xs]).

horizontalCheck(List):- 
  not(verticalCheck(List)).

isHorizontal(Elem,Board,Bool):-
  getElem(Elem,Board,Coordinates),
  horizontalCheck(Coordinates),
  Bool is 1,!; Bool is 0,!.  

getWinCell(Board,[X,Y]):- 
  getElem('0',Board,ZeroCoordinates),
  getElem('#',Board,WallCoordinates),
  nth0(0, ZeroCoordinates, FirstCell),
  nth0(0, FirstCell, X),
  last(WallCoordinates, LastCell),
  nth0(1, LastCell, AlmostY),
  Y is AlmostY-1.
