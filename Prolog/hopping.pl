/*
 * NTUA ECE PL1 2016-2017 Set2 Hopping SWI-Prolog
 * Constantinos Karouzos ckarouzos@gmail.com 03114176
 * Alexandros Kafiris alexkafiris@gmail.com 03114044
*/

read_input(File, N, K, B, Steps, Broken) :-
    open(File, read, Stream),
    read_line(Stream, [N, K, B]),
    read_line(Stream, Steps),
    read_line(Stream, Broken).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ).

create_lader(N, N, [N-0]):-!.
create_lader(Num, N, Lader0) :-
	Num1 is Num +1,
	create_lader(Num1, N, Al),!,
	Lader0=[Num-0|Al].

broke_lader([], Lader, Lader) :- !.
broke_lader([H|T], Lader0, Lader) :-
	put_assoc(H, Lader0, -1, NewLader),
	broke_lader(T, NewLader, Lader),!.

check(_, -1, A) :- A is -1,!.
check(-1, _, A) :- A is -1,!.
check(_,  _, A) :- A is  0,!.

fixlader(_, NewLader, [], _,_, NewLader):-!.
fixlader(Goal, NewLader, [H|_], Thesi,_, NewLader) :-
	Thesi + H > Goal,!.
fixlader(Goal, Lader, [H|T], Thesi,A, NewLader) :-
	I is Thesi + H,
	get_assoc(I, Lader, K),
	K =:= -1,
	fixlader(Goal, Lader, T, Thesi,A, NewLader),!.
fixlader(Goal, Lader, [H|T], Thesi,A, NewLader) :-
	I is Thesi + H,
	get_assoc(I ,Lader, B),
	C is (A+B) mod 1000000009,
	put_assoc(I, Lader, C, NewLader0),
	fixlader(Goal, NewLader0, T, Thesi,A, NewLader),!.


count(N, Lader, _, N, Answer) :-
	get_assoc(N, Lader, A),
	Answer is A,!.
count(N, Lader, Steps, Thesi, Answer) :-
	del_assoc(Thesi, Lader,A,NewAssoc),
	A < 1,
	Thesi1 is Thesi + 1,
	count(N, NewAssoc, Steps, Thesi1, Answer),!.
count(N, Lader, Steps, Thesi, Answer) :-
	del_assoc(Thesi, Lader, A,NewAssoc),
	A >= 1,
	fixlader(N, NewAssoc, Steps, Thesi,A, NewLader),!,
	Thesi1 is Thesi + 1,
	count(N, NewLader, Steps, Thesi1, Answer),!.

hopping(File, Answer) :-
	read_input(File, N, _, _, ASteps, Broken),!,
	sort(ASteps,Steps),!,
	create_lader(1, N, Lader0),!,
	list_to_assoc(Lader0, Lader1),!,
	put_assoc(1, Lader1, 1, Lader2),!,
	broke_lader(Broken, Lader2, Lader),!,
	get_assoc(1, Lader, First),!,
	get_assoc(N, Lader, Last),!,
	check(First, Last, A),!,
	(A =:= 0 -> count(N, Lader, Steps, 1, Answer),! ; Answer = 0),!.
