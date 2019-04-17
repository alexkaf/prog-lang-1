(*
NTUA ECE PL1 2016-2017 Set1 Skitrip SML NJ 
Constantinos Karouzos ckarouzos@gmail.com 03114176
Alexandros Kafiris alexkafiris@gmail.com 03114044
*)

fun skitrip file = 
    let 
        fun parse file =
        let
        fun next_int input =
            Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input) 
        val stream = TextIO.openIn file
        val n = next_int stream
        fun scanner 0 acc = acc
           |scanner i acc =
            let
            val d=next_int stream 
            in
            scanner (i-1) ((n-i,d)::acc)
            end
            
        in
        rev (scanner n [])
        end 

        fun reverse nil = nil
            |reverse (x::xs) = 
                let
                    val acc=nil
                    fun this (nil,acc) = acc
                        |this ((x::xs),acc) = this (xs,(x::acc))
                in
                    this ((x::xs),acc)
                end

        fun makeL nil = nil
            |makeL ((a,b)::xs) =
                let
                    val acc = nil
                    fun aux ((z,((a,b)::xs)),acc) = 
                        if z>=b then aux ((b,xs),((a,b)::acc))
                        else aux((z,xs),acc)
                    |aux ((z,nil),acc) = acc
                in
                    reverse (aux((b,((a,b)::xs)),acc))
                end

        fun makeR nil = nil
            |makeR ((a,b)::xs) =
                let
                    val acc = nil
                    val newList=reverse ((a,b)::xs)
                    val pivot = #2 (hd (newList))
                    fun aux ((z,((a,b)::xs)),acc) = 
                        if z<=b then aux ((b,xs),((a,b)::acc))
                        else aux((z,xs),acc)
                    |aux ((z,nil),acc) = acc
                in
                    aux((pivot,newList),acc)
                end

        fun check (max,(((a,b)::l1),((c,d)::(e,f)::l2))) = 
            if ((d>=b)andalso(f>=b)) then check(max,(((a,b)::l1),((e,f)::l2)))
            else if ((d>=b)andalso(f<=b)andalso(max < c-a)) then check (c-a,(l1,((e,f)::l2)))
            else check (max,(l1,((c,d)::(e,f)::l2)))
            |check (max,(nil,_)) = max
            |check (max,(_,nil)) = max
            |check (max,(((a,b)::rest1),((c,d)::nil))) = 
                if ((d>=b)andalso(max < (c-a))) then c-a else max
    in
        check (0,(makeL(parse file),makeR(parse file)))
end;