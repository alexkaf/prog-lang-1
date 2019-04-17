/*
NTUA ECE PL1 2016-2017 Set2 Moredeli Java 
Constantinos Karouzos ckarouzos@gmail.com 03114176
Alexandros Kafiris alexkafiris@gmail.com 03114044

*/

import java.io.*;

public class Moredeli{
	public static void main(String [] args){
		try{
			Solver findPath = new Solver(args[0]);
		}catch(FileNotFoundException e){
			System.out.println("File not Found.");
		}catch(IOException e){
			System.out.println("Cannot Read");
		}
	}
}
