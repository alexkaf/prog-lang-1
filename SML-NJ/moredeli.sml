(*  
NTUA ECE PL1 2016-2017 Set2 Moredeli SML NJ 
Constantinos Karouzos ckarouzos@gmail.com 03114176
Alexandros Kafiris alexkafiris@gmail.com 03114044
 

Code(L19-45  from https://github.com/josepablocam/symfun/blob/master/priority_queue/src/ml/priority_queue.sml 8/5/2017

A simple implementation of a priority queue using ML, part of a series posted to symfun.wordpress.com

*)




fun moredeli file =             
    let       
        
    (* list of tuples is a queue *)
    datatype 'a queue = Q of ('a * int) list 
                        
    (* enqueue helper returns a list for enqueue to wrap in data constructor *)
    fun enqueue0 new [] = [new]
       |    enqueue0 (new as (n, p1)) (old as (e, p2) :: xs) = 
        if p1 > p2 then (e, p2) :: enqueue0 new xs 
        else new :: old
                
                
    (* returns a new queue with the element enqueued according to priority *)
    fun enqueue e p (Q q) = Q (enqueue0 (e, p) q)
                  
    (* returns a tuple of an option containing the element and new queue *)
    fun dequeue (Q []) = (NONE, Q [])
       |dequeue (Q ((e,p) :: xs)) = (SOME (e,p), Q xs)
                        
                        
    (* returns first element in queue,but not the new queue *)
    fun peek x = #1 (dequeue x)
            
            
    (* a helper for dequeue_pred which returns the first element to satisfy a predicate *)
    fun dequeue_pred0 f [] _ = (NONE, [])
       |    dequeue_pred0 f ((e, p) :: xs) ys = 
        if f (e, p) then (SOME e, (rev ys) @ xs) 
        else dequeue_pred0 f xs ((e, p) :: ys)
                   
                   
    fun dequeue_pred f (Q q) = 
            let 
        val (e, ls) = dequeue_pred0 f q [] 
            in 
        (e, Q ls) 
            end
        
    fun is_empty (Q []) = true
       |is_empty (Q ((e,p)::xs))= false
        
    fun parse file = (*string -> char list *)
            let
        fun next_String input = (TextIO.inputAll input) 
        val stream = TextIO.openIn file
        val a = next_String stream
            in
        explode a
            end
        
    fun findS (nil ) = 0 
       |findS ((x::xs):(char list))= (*char list -> int*)
            if x= #"S" then 0
            else (findS xs)+1
                
                
    fun NM (map :( char list))  = (*char list -> (int * int )*)
            let
        fun calculateM (nil) = 0 
           |calculateM (x::xs : (char list))=
            if x= #"\n" then 0
            else (calculateM xs)+1  
            in
        let
            val L= (length map)
            val M= calculateM map
            val N= L div (M+1)
        in
            (N,M)
        end
            end
        
    val Lmap= parse file
    val Vmap= Vector.fromList Lmap
    val L=(length Lmap)               
    val (N,M)=NM Lmap
    val S= findS Lmap
    val init=S
    val q= Q []
    val qi= enqueue init 0 q
        (*
        fun foo (x:char)= ~1 
    val prev0=Vector.map foo Vmap
        val prev=Vector.concat [prev0, prev0]
    val prev=Vector.update(prev,S,~2)
    *)
    val VMI=valOf (Int.maxInt)
    val prev=Array.array(L, (~1,#"A",VMI))
    val f=Array.update(prev, S, (~2, #"N", 0))
              
    fun MakeNext (t: int, cost : int, [], lqi, lprev)= (lqi,lprev) 
       |MakeNext (t: int, cost : int, G::RMovesL: char list, lqi, lprev)=
            let
        fun tnext #"L"=
            if t<>0  andalso ((t-1) mod (M+1)<>M) andalso (Vector.sub(Vmap, t-1) <> #"X")  then (t-1)
            else t
          | tnext #"R"=
            if t<>L-2 andalso ((t+1) mod (M+1)<>M) andalso (Vector.sub(Vmap, t+1) <> #"X") then t+1
            else t
          | tnext #"U"=
            if t>M andalso (Vector.sub(Vmap, t-(M+1)) <> #"X") then t-(M+1)
            else t
          | tnext #"D"=
            if t<L-M-1 andalso (Vector.sub(Vmap, t+M+1) <> #"X")  then t+M+1
            else t
          | tnext _= t
                 
        val next=tnext G

        fun eqnxt a=
            if a=next then true
            else false
                 
                 
        fun calcCost () =
            if (G = #"R") then 1
            else if(G= #"D") then 1
            else if (G= #"L") then 2
            else if (G= #"U") then 3
            else 0

        val c=calcCost()
                 
            in
        if (t <> next) andalso ((Array.sub(lprev,next) = (~1, #"A", VMI)) orelse ( #3 (Array.sub(lprev,next)) > (cost+c)  ))then
            let
            (*val l1prev= Vector.update(lprev,next,t)*)
            val f=Array.update(lprev, next, (t,G, (cost+c) ))
            (*val l1qi= enqueue next (cost+c) lqi*)
            in
            MakeNext (t, cost, RMovesL, (enqueue next (cost+c) lqi), lprev)
            end
        else MakeNext (t, cost,  RMovesL, lqi, lprev)
            end
        
    fun path (st, sprev)=
            let
        val (i, K, _)= Array.sub(sprev,st)
            in
        if (i= ~2) then nil
        else K::path(i, sprev)
            end
    fun reverse nil = nil
       |reverse (x::xs) = (reverse xs)@[x]
                           
                           
    fun solution (cost: int, st, sprev)= (cost,implode (reverse (path(st, sprev)))) (* Define *)
                         
                         
    fun dijkstraloop (ldqi, ldprev)=
            let
        val (A, nqi)= dequeue ldqi
        val (t, cost)= valOf A
        val MovesL= #"R":: #"D" :: #"L" :: #"U"  ::[]
            in
        if  (cost<= (#3 (Array.sub(ldprev,t)))) then
            if (Vector.sub(Vmap, t)= #"E")  then solution(cost,t, ldprev)
            else    dijkstraloop(MakeNext(t,cost, MovesL, nqi, ldprev))
        else  dijkstraloop(nqi, ldprev)         
            end
    in  
    dijkstraloop(qi, prev)
    end;
        

      