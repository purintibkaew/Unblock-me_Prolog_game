cmdLexer(Height,Width,Board):-
  (isWinCond(Board,Bool), Bool = 0,
  (showBoard(Width,Board),!),
  write('Sisestada semikooloniga eraldatud korraldus. (N2iteks "1;F".)'),nl,
  write('Veenduge, et korraldus on ulaltoodud viisil jutum2rkide vahel ning viimasena on kirjas punkt.'),
  nl,nl,getString(Command),
  split_string(Command,";","",Cmd),
  nth0(0, Cmd, BlockNr),last(Cmd, Direction),
  atom_string(BlockNrAtom,BlockNr),atom_string( DirAtom,Direction),
  cmdParser(BlockNrAtom,DirAtom,Height,Width,Board));
  ((showBoard(Width,Board),!),
  write('------------'),nl,
  write('|FINISH|'),nl,
  write('------------'),nl),!.

cmdParser(BlockNr,Direction,Height,Width,Board):-
  (atom(BlockNr),atom(Direction),
    atom_length(BlockNr,1),atom_length(Direction,1),
    moveElem(BlockNr,Board,Direction,NewBoard),
    cmdLexer(Height,Width,NewBoard));
  write('Vigane sisend'),nl,cmdLexer(Height,Width,Board).

getString(String):-read(StringCodes),atom_codes(String, StringCodes).   

isWinCond(Board,Bool):-
  getWinCell(Board,WinCellCoordinate),
  getFirstLastCell('0',Board,_,ZeroLastCell),
  memberchk(ZeroLastCell,[WinCellCoordinate]),
  Bool is 1,!;Bool is 0,!.
