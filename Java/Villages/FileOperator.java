import java.util.Scanner;
import java.io.FileReader;
import java.io.IOException;

public class FileOperator{

	private FileReader fileName;
	private Scanner inputBuffer;

	private int villageNumber,roadsToBeMade,roadsExist;
	private int numberOfGroups = 0;
	private NodeVillage [] villageMap;

	//	Constructor: Reads the name of the file and prepares
	//	the buffer for input. Then, it calls filePrepare().

	FileOperator(String fileName)throws IOException{

			this.fileName = new FileReader(fileName);
			this.inputBuffer = new Scanner(this.fileName);
			
	}

	//	filePrepare(): This function reads the first 3 integers
	//	and sets the values for villageNumber,roadsExist and
	// 	roadsToBeMade. It also creates the appropriate array to 
	//	depict each village.

	public void filePrepare(){

		villageMap = new NodeVillage[(villageNumber = inputBuffer.nextInt())];
		this.roadsExist = inputBuffer.nextInt();
		this.roadsToBeMade = inputBuffer.nextInt();

	}

	//	villageMapFill(): This function creates an array of a size same as
	//	the number of the existed vilages. It later reads th file line by
	//	line and for every coupleof connected villages, it either merges
	//	their sets or does nothing if thet already exist in the same set.
	//	The latter proccess is executed by the villages themselves which
	//	are the objects themselves.

	public void villageMapFill(){

		for(int i=0;i<villageNumber;i++){

			villageMap[i] = new NodeVillage(i);

		}

		for(int i=0;i<roadsExist;i++){

			int tempA = inputBuffer.nextInt();
			int tempB = inputBuffer.nextInt();	

			(villageMap[tempA-1]).mergeVillageWith(villageMap[tempB-1]);

		}

	}

	// 	Finally, this function return the final result. It starts counting the 
	//	number of different sets of villages by checking if the village in a shell
	//	points to itself. If yes, then it represents a whole group of villages and
	//	is perceived as one village. The it subtructs the number of roads to be made 
	//	and the result is given as an int. If there is only one set, then it returns
	//	one no matter the number of roads to be made.

	public int returnNewGroupsCount(){

		for(int i=0;i<villageNumber;i++){

			if(villageMap[i].returnVillageParent() == villageMap[i]){

				numberOfGroups++;

			}

		}

		if((numberOfGroups - roadsToBeMade) < 2){

			return 1;

		}else{

			return (numberOfGroups - roadsToBeMade);

		}

	}

}