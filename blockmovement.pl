getElem(Elem,Board,Coordinates):-
  assoc_to_list(Board, List),
  elemFinder(Elem,[],List,OneList),!,
  reverse(OneList,Coordinates).

elemFinder(_,Result,[],Result):-!.
elemFinder(Elem,Start,[Key-Value|Xs],Result):-
  (Value = Elem,append([Key],Start,Y),elemFinder(Elem,Y,Xs,Result));
  append([],Start,Y),elemFinder(Elem,Y,Xs,Result).
  
moveElem(Elem,Board,Dir,NewBoard):-
  Dir = 'B', isHorizontal(Elem,Board,Bool), Bool = 1, moveLeft(Elem,Board,NewBoard),!;
  Dir = 'F', isHorizontal(Elem,Board,Bool), Bool = 1, moveRight(Elem,Board,NewBoard),!;
  Dir = 'B', isVertical(Elem,Board,Bool), Bool = 1, moveDown(Elem,Board,NewBoard),!;
  Dir = 'F', isVertical(Elem,Board,Bool), Bool = 1, moveUp(Elem,Board,NewBoard),!;
  doNothing(Board,NewBoard),!.

doNothing(Board,Board).
getLeftCell([X,Y],[X,Z]):- Z is Y-1.
getRightCell([X,Y],[X,Z]):- Z is Y+1.
getLowerCell([X,Y],[Z,Y]):- Z is X+1.
getUpperCell([X,Y],[Z,Y]):- Z is X-1.

getFirstLastCell(Elem,Board,FirstCell,LastCell):-
  getElem(Elem,Board,Coordinates),
  nth0(0, Coordinates, FirstCell),
  last(Coordinates, LastCell).

moveLeft(Elem,Board,NewBoard):-
  getFirstLastCell(Elem,Board,FirstCell,LastCell),
  getLeftCell(FirstCell,LeftCell),
  get_assoc(LeftCell,Board,Value),
  Value = ' ',
  put_assoc(LeftCell,Board,Elem,HelpBoard),
  put_assoc(LastCell,HelpBoard,' ',NewBoard).

moveRight(Elem,Board,NewBoard):-
  getFirstLastCell(Elem,Board,FirstCell,LastCell),
  getRightCell(LastCell,RightCell),
  get_assoc(RightCell,Board,Value),
  Value = ' ',
  put_assoc(RightCell,Board,Elem,HelpBoard),
  put_assoc(FirstCell,HelpBoard,' ',NewBoard).

moveDown(Elem,Board,NewBoard):-
  getFirstLastCell(Elem,Board,FirstCell,LastCell),
  getLowerCell(LastCell,LowerCell),
  get_assoc(LowerCell,Board,Value),
  Value = ' ',
  put_assoc(LowerCell,Board,Elem,HelpBoard),
  put_assoc(FirstCell,HelpBoard,' ',NewBoard).

moveUp(Elem,Board,NewBoard):-
  getFirstLastCell(Elem,Board,FirstCell,LastCell),
  getUpperCell(FirstCell,UpperCell),
  get_assoc(UpperCell,Board,Value),
  Value = ' ',
  put_assoc(UpperCell,Board,Elem,HelpBoard),
  put_assoc(LastCell,HelpBoard,' ',NewBoard).
