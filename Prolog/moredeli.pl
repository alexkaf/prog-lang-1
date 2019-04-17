moredeli(Filename,Cost,Solution):-
    open(Filename,read,InStream),
    read_from_stream(InStream,PList,Steps,M,Allpos,S,E),
    K is Allpos div M,
    list_to_assoc(PList,Maplist),list_to_assoc(Steps,SA),
    heap_size(X,0),add_to_heap(X,0,S,PQ),
    put_assoc(S,SA,[a,-1,0],SF),
    findCost(Maplist,PQ,Allpos,K,SF,SR),
    get_assoc(E,SR,[_,_,Cost]),
    findRoute(S,E,SR,Solution).

read_from_stream(InStream,[0 -88|PList],Steps,M,Counter,S,E):-
    get_code(InStream,A),
    checkInput(0,1,InStream,A,PList,Steps,M,Counter,S,E),!.
checkInput(M,Counter,_,-1,[Counter - 88],[],M,Counter,_,_):-!.
checkInput(M,Counter,InStream,10,[Counter - 88|Rest1],Rest2,F,RC,S,E):-
    get_code(InStream,A),
    Z is Counter + 1, K is M + 1,
    checkInput(K,Z,InStream,A,Rest1,Rest2,F,RC,S,E).
checkInput(M,Counter,InStream,83,[Counter - 83|Rest1],[Counter - [a,-1,0]|Rest2],F,RC,Counter,E):-
    get_code(InStream,C),
    Z is Counter + 1,
    checkInput(M,Z,InStream,C,Rest1,Rest2,F,RC,Counter,E),!.
checkInput(M,Counter,InStream,69,[Counter - 69|Rest1],[Counter - [a,-1,4000000]|Rest2],F,RC,S,Counter):-
    get_code(InStream,C),
    Z is Counter + 1,
    checkInput(M,Z,InStream,C,Rest1,Rest2,F,RC,S,Counter),!.
checkInput(M,Counter,InStream,A,[Counter - A|Rest1],[Counter - [a,-1,4000000]|Rest2],F,RC,S,E):-
    get_code(InStream,C),
    Z is Counter + 1,
    checkInput(M,Z,InStream,C,Rest1,Rest2,F,RC,S,E),!.

add_heap(Heap,A - B,NewHeap):- add_to_heap(Heap,A,B,NewHeap).

takeNode(Heap,[A - B],NewHeap):- 
    min_of_heap(Heap,A,B),
    get_from_heap(Heap,A,B,NewHeap).

stepLeft(_,_,Assoc,CurrentPos,NextPos):-
    NextPos is CurrentPos - 1,
    get_assoc(NextPos,Assoc,Result),
    allow(Result).
stepUp(M,_,Assoc,CurrentPos,NextPos):-
    NextPos is CurrentPos - M, NextPos > 0,
    get_assoc(NextPos,Assoc,Result),
    allow(Result).
stepRight(_,_,Assoc,CurrentPos,NextPos):-
    NextPos is CurrentPos + 1,
    get_assoc(NextPos,Assoc,Result),
    allow(Result).
stepDown(M,Allpos,Assoc,CurrentPos,NextPos):-
    NextPos is CurrentPos + M, NextPos < Allpos,
    get_assoc(NextPos,Assoc,Result),
    allow(Result).

check(CurrentPos,NextPos,Cost,PQ,NPQ,M,S,NS):-
    get_assoc(CurrentPos,S,[_,_,C1]),
    get_assoc(NextPos,S,[_,_,C2]),
    Z is C1 + Cost,
    (Z < C2 -> add_to_heap(PQ,Z,NextPos,NPQ), 
        K is CurrentPos - NextPos,
        (K =:= 1 -> put_assoc(NextPos,S,[l,CurrentPos,Z],NS);true),
        (K =:= -1 -> put_assoc(NextPos,S,[r,CurrentPos,Z],NS);true),
        (K=:= M -> put_assoc(NextPos,S,[u,CurrentPos,Z],NS);true),
        (K =:= -M -> put_assoc(NextPos,S,[d,CurrentPos,Z],NS);true);
            NS = S, NPQ = PQ).

allow(NextStep):- NextStep =\= 88.

visit(VisitedNode,Assoc,NewAssoc):- put_assoc(VisitedNode,Assoc,88,NewAssoc).

findCost(_,PQ,_,_,SB,SB):-heap_size(PQ,0),!.

findCost(Maplist,PQ,Allpos,M,S,SF):-
    \+ heap_size(PQ,0),
    takeNode(PQ,[_ - Node],NPQ),
    visit(Node,Maplist,NMaplist),
    (stepLeft(_,_,NMaplist,Node,N1)-> check(Node,N1,2,NPQ,PQ1,M,S,S1); PQ1 = NPQ, S1 = S),!,
    (stepUp(M,_,NMaplist,Node,N2)-> check(Node,N2,3,PQ1,PQ2,M,S1,S2); PQ2 = PQ1 , S2 = S1),!,
    (stepRight(_,_,NMaplist,Node,N3)-> check(Node,N3,1,PQ2,PQ3,M,S2,S3); PQ3 = PQ2 , S3 = S2),!,
    (stepDown(M,Allpos,NMaplist,Node,N4)-> check(Node,N4,1,PQ3,PQ4,M,S3,S4); PQ4 = PQ3 ,  S4 = S3),!,
    findCost(NMaplist,PQ4,Allpos,M,S4,SF),!.

findRoute(S,S,_,[]).
findRoute(S,CurrentPos,SR,Route):-
    get_assoc(CurrentPos,SR,[Step,PrevPos,_]),
    findRoute(S,PrevPos,SR,R),!,
    append(R,[Step],Route).        

      