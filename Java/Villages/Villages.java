import java.io.IOException;

public class Villages{
	public static void main(String [] args){

		try{

			FileOperator findGroups = new FileOperator(args[0]);
			findGroups.filePrepare();
			findGroups.villageMapFill();
			System.out.println(findGroups.returnNewGroupsCount());

		}catch(IOException e){

			System.out.println("File not found.");

		}

	}
}