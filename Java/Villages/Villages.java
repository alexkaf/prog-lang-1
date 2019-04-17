/*
NTUA ECE PL1 2016-2017 Set2 Villages Java 
Constantinos Karouzos ckarouzos@gmail.com 03114176
Alexandros Kafiris alexkafiris@gmail.com 03114044

*/

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
