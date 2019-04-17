read_input(File,NumberOfStations) :-
    open(File,read,Stream),
    read_line(Stream,NumberOfStations).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ).

putNumbers([],_,[]).
putNumbers([A|List],Counter,[[Counter,A]|Result]):-
  K is Counter + 1,
  putNumbers(List,K,Result).

makeRist([],_,[]).
makeRist([[_,B]|Rest],C,Result):-
  B =< C,
  makeRist(Rest,C,Result).
makeRist([[A,B]|Rest],C,[[A,B]|Result]):-
  B >= C,
  makeRist(Rest,B,Result).

secList(List,Answer):-
  reverse(List,[[A,B]|RevList]),
  makeRist(RevList,B,K),
  append([[A,B]],K,Answer).

makeLList([],_,[]).
makeLList([[_,B]|Rest],C,Result):-
  B >= C,
  makeLList(Rest,C,Result).
makeLList([[A,B]|Rest],C,[[A,B]|Result]):-
  B =< C,
  makeLList(Rest,B,Result).

makeL([[A,B]|List],[[A,B]|Result]):-
  makeLList(List,B,Result).

find([],[],[]).
find(List1,[B|List2],Result):-
  makeList(List1,B,T,Remain),
  find(Remain,List2,K),
  append(T,K,Result).
makeList([],_,[],[]).
makeList([[A,B]|Rest1],[_,D],[],[[A,B]|Rest1]):-
  B < D.
makeList([[A,B]|Rest1],[C,D],[Z|Result],Rest):-
  B >= D,
  Z is A - C,
  makeList(Rest1,[C,D],Result,Rest).

do(I,K,Result):-
  once(lister(I,K,Z)),
  my_max(Z,Result).

findMax([],0).
findMax([A|List],Max):-
  findMax(List,Max),
  A < Max.
findMax([A|List],A):-
  findMax(List,Z),
  A > Z.
lister(_,0,[]).
lister(A,Counter,Result):-
  Z is Counter - 1,
  K is A + 1,
  append([A],Rest,Result),
  lister(K,Z,Rest).
solve(List1,List2,Result):-
  once(find(List1,List2,X)),
  once(findMax(X,Result)).

my_max([], Result, Result). 
my_max([X|Xs], TempResult, Result):-
    X > TempResult, my_max(Xs, X, Result).
my_max([X|Xs], TempResult, Result):-
    X =< TempResult, my_max(Xs, TempResult, Result).
my_max([X|Xs], Result):-
    my_max(Xs, X, Result). 

skitrip(Filename,Result):-
    open(Filename,read,Stream),
    read_line(Stream,_),
    read_line(Stream,List),
  putNumbers(List,0,ModList),
  once(makeL(ModList,R)),
  once(secList(ModList,T)),
  reverse(T,L),
  once(find(L,R,E)),
  my_max(E,Result).
        

      