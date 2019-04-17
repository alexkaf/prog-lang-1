fun villages filename = 
    let
        val inputStream = TextIO.openIn filename
        fun next_int input =
            Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        val (villageNumber,roadsExist,roadsToMake) = (next_int inputStream , next_int inputStream , next_int inputStream)
        val villageMap = Array.array(villageNumber, (0,0,0))
        fun makeMap(0,arrayToMake,()) = arrayToMake
            |makeMap(i,arrayToMake,()) = makeMap((i-1),arrayToMake,Array.update(arrayToMake,i-1,(i,i,0)))
        val villageMap = makeMap(villageNumber,villageMap,())
        fun findParent (arrayToSearch,villageNumber) = 
            let
                val (villageNumber1,parentVillage,rank) = Array.sub(arrayToSearch,villageNumber-1) 
            in
                if (villageNumber1 = parentVillage) then Array.sub(arrayToSearch,villageNumber1-1) else findParent(arrayToSearch,parentVillage)
            end
        fun connectVillages (arrayToUse,villageNumber1,villageNumber2) = 
            let
                val (number1,parent1,rank1) = findParent(arrayToUse,villageNumber1)
                val (number2,parent2,rank2) = findParent(arrayToUse,villageNumber2)
            in
                if(number1=number2)then() 
                else if (rank1<rank2) then Array.update(arrayToUse,number1-1,(number1,parent2,rank1+1))
                else Array.update(arrayToUse,number2-1,(number2,parent1,rank2+1))
            end
        val existRoads = Array.array(roadsExist,(0,0))
        fun readInputs(0,arrayToUse) = Array.update(arrayToUse,0,((next_int inputStream),(next_int inputStream)))
            |readInputs (i,arrayToUse) = 
            let
                val z = Array.update(arrayToUse,i,((next_int inputStream),(next_int inputStream)))
            in
                readInputs(i-1,arrayToUse)
            end
        val thisTake = readInputs(roadsExist-1,existRoads)
        fun autoConnect(arrayToTake,arrayToEdit,0) = ()
            |autoConnect(arrayToTake,arrayToEdit,counter) = 
            let
                val (village1,village2) = Array.sub(arrayToTake,counter-1)
                val newConnection = connectVillages(arrayToEdit,village1,village2)
            in
                autoConnect(arrayToTake,arrayToEdit,(counter-1))
            end
        val makeAllConnections = autoConnect(existRoads,villageMap,roadsExist)
        fun findGroups(arrayToCheck,0,acc) = 
            let
                val (villageNumber,villageParent,villageRank) = Array.sub(arrayToCheck,0)
            in
                if (villageNumber=villageParent) then acc+1 else acc
            end
            |findGroups(arrayToCheck,counter,acc) = 
            let
                val (villageNumber,villageParent,villageRank) = Array.sub(arrayToCheck,counter)
            in
                if(villageNumber = villageParent) then findGroups(arrayToCheck,(counter-1),(acc+1))
                else findGroups(arrayToCheck,(counter-1),acc)
            end
        val sepGroups = findGroups(villageMap,(villageNumber-1),0)
        fun findFinalResult (seperateGroups,roadsToBeMade) = 
            if((seperateGroups-roadsToBeMade)<0) then 1
            else seperateGroups-roadsToBeMade
    in
        findFinalResult(sepGroups,roadsToMake)
    end        

      