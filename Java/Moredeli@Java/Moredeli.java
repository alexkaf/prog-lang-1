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