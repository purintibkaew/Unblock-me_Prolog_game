:- consult('blockmovement').
:- consult('dimensioncheck').
:- consult('printer').
:- consult('inputreader').
:- consult('cmdutils').
:- use_module(library(assoc)).

%% Menüü ja valikute valimise "selection()" ja "execute()" kontrolli idee päritolu allikas: 
%% https://github.com/pedrorfernandes/hanjie/blob/proj2/src/hanjie.pl
main:-
  write('EESM2RK: Laud loetakse lahendatuks, kui 0-plokk seisab vahetult augu ees.'),nl,
  write('Valige palun alltoodud valikute vahel.'),nl,
  write('Kirjutage valikunumber ning vajutage ENTER-klahvi.'),nl,
  write('------------'),nl,
  write('|Unblock me|'),nl,
  write('------------'),nl,
  write('0 - Autosolve'), nl,
  write('1 - M2ngi'), nl,
  write('2 - Lahku'), nl,nl,
  selection(Selected), !,
  execute(Selected).
execute(0):-
  write('Sisestage projektikaustas oleva lauafaili nimi (N2ide: "laud.txt".)'),nl,
  write('Veenduge, et failinimi on ulaltoodud viisil jutum2rkide vahel ning viimasena on kirjas punkt.'),
  nl,nl,getString(Filename),
  getFileInfo(Filename,_,_,Width,Board),
  search(Width,Board),true.
  %% write(Result),nl,true.
execute(1):-
  write('Sisestage projektikaustas oleva lauafaili nimi (N2ide: "laud.txt".)'),nl,
  write('Veenduge, et failinimi on ulaltoodud viisil jutum2rkide vahel ning viimasena on kirjas punkt.'),
  nl,nl,getString(Filename),
  getFileInfo(Filename,_,Height,Width,Board),
  write('VAHEND: Horisontaalse ploki liigutamiseks paremale sisestada "BLOKI_NR;F". (N2ide: "1;F".)'),nl,
  write('VAHEND: Horisontaalse ploki liigutamiseks vasakule sisestada "BLOKI_NR;B". (N2ide: "1;B".)'),nl,
  write('VAHEND: Vertikaalse ploki liigutamiseks alla sisestada "BLOKI_NR;B". (N2ide: "1;B".)'),nl,
  write('VAHEND: Vertikaalse ploki liigutamiseks üles sisestada "BLOKI_NR;F". (N2ide: "1;F".)'),nl,
  write('START: '),nl,
  cmdLexer(Height,Width,Board),!,skip_line,
  main.
execute(2):-
  true.

selection(Selected):-
  get_code(Code),CSelected is Code-48,skip_line,
  ((CSelected < 0 ; CSelected > 2)->write('Vigane sisend'),nl,selection(Selected);Selected is CSelected).


search(Width,Board):-
  %% showBoard(Width,Board),
  assoc_to_values(Board, List),
  gatherElems([],List,Elems),
  (generateNextLevel(Width,Board,[Board],Elems,NextLevel),!,true),
  checkLevels(Width,NextLevel,Bool),
  searchLooper(Width,Board,Elems,NextLevel,Bool).

gatherElems(S,[],S):-!,true.
gatherElems(Start,[X|Xs],Elems):-
  ((X = '0';X = '1';X = '2';X = '3';X = '4';X = '5';X = '6';X = '7';X = '8';X = '9'),
  not(member(X,Start)),append([X],Start,Y),gatherElems(Y,Xs,Elems),!,true);gatherElems(Start,Xs,Elems),!,true.

generateNextLevel(_,_,S,[],S):-!.
generateNextLevel(Width,Board,Start,[E|Es],NextLevel):-
  (moveElem(E,Board,'F',NewBoard1),moveElem(E,Board,'B',NewBoard2),
    not(member(NewBoard1,Start)), not(member(NewBoard2,Start)),
    isWinCond(NewBoard1,Bool1),isWinCond(NewBoard2,Bool2),Bool1=0, Bool2=0,
    append(Start,[[NewBoard1,NewBoard2]],NLevel),generateNextLevel(Width,Board,NLevel,Es,NextLevel));
  (moveElem(E,Board,'F',NewBoard1),not(member(NewBoard1,Start)),
    isWinCond(NewBoard1,Bool),Bool=0,append(Start,[[NewBoard1]],NLevel),
    generateNextLevel(Width,Board,NLevel,Es,NextLevel));
  (moveElem(E,Board,'F',NewBoard1),not(member(NewBoard1,Start)),
    isWinCond(NewBoard1,Bool),Bool=1,
    append(Start,[[NewBoard1]],NextLevel));
  (moveElem(E,Board,'B',NewBoard2),not(member(NewBoard2,Start)),
    isWinCond(NewBoard2,Bool),Bool=0,append(Start,[[NewBoard2]],NLevel),
    generateNextLevel(Width,Board,NLevel,Es,NextLevel));
  (moveElem(E,Board,'B',NewBoard2),not(member(NewBoard2,Start)),
    isWinCond(NewBoard2,Bool),Bool=1,
    append(Start,[[NewBoard2]],NextLevel));
  (isWinCond(Board,Bool),Bool=0, generateNextLevel(Width,Board,Start,Es,NextLevel));
  (isWinCond(Board,Bool),Bool=1, generateNextLevel(_,_,Start,[],NextLevel)).

checkLevels(Width,[X|Xs],Bool):-
  (isWinCond(X,Bool),Bool=1);
  checkpleasehelp(Width,Xs,Bool).

checkpleasehelp(_,[],_):-!.
checkpleasehelp(Width,[X|Xs],Bool):-
  checkphelp(Width,X,Bool),checkpleasehelp(Width,Xs,Bool).

checkphelp(_,[],_):-!.
checkphelp(Width,[X|Xs],Bool):-
  (isWinCond(X,Bool),Bool=1,showBoard(Width,X));checkphelp(Width,Xs,Bool),Bool is 0.

flattenList(Start,[X|Xs],Result):-
  append([X],Start,Y),
  flattenChildren(Y,Xs,Result).

flattenChildren(Result,[],Result):-!.
flattenChildren(Start,[X|Xs],Result):-
  flattify(Start,X,Y),flattenChildren(Y,Xs,Result).

flattify(Result,[],Result):-!.
flattify(Start,[X|Xs],Result):-
  append(Start,[X],Y),flattify(Y,Xs,Result).

showFlattenList(_,[]).
showFlattenList(Width,[X|Xs]):-
  (isWinCond(X,Bool),Bool=1,showBoard(Width,X));showFlattenList(Width,Xs).

fwdSearch(_,_,[]).
fwdSearch(FlatList,Width,[X|Xs]):-
  intelliSearch(FlatList,Width,X),nl,fwdSearch(FlatList,Width,Xs).

intelliSearch(FlatList,Width,Board):-
  showBoard(Width,Board),
  assoc_to_values(Board, List),
  gatherElems([],List,Elems),
  (generateNextLevel(Width,Board,FlatList,Elems,NextLevel),!,true),
  flatten(NextLevel, FlatNextLevel),
  showFlattenList(Width,FlatNextLevel). %% Siia oleks muidu uuesti keerulisel juhul SearchLooperit vaja.

  searchLooper(Width,Board,_,NextLevel,Bool):-
  (Bool = 1, write("FINISH"));
  (Bool = 0,write("VAJA OTSIDA"),nl,flatten(NextLevel,FlatList),nl,showFlattenList(Width,FlatList)),
  delete(FlatList, Board, SearchList),
  fwdSearch(FlatList,Width,SearchList).
