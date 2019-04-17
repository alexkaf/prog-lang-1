import java.util.*;
import java.lang.*;
import java.io.*;

public class Solver{
	Solver(String fileName)throws IOException{
		FileReading  newFile = new FileReading(fileName);
		newFile.passToArrayList();
		ListMaker convList = new ListMaker(newFile.giveConvertedMap(),newFile.returnDimN(),newFile.returnDimM(),newFile.returnCounter());
		convList.listMakerOriginal();
		PathFinder findPath = new PathFinder(convList.returnModMap(),newFile.returnStart(),newFile.returnEnd(),newFile.returnCounter());
		findPath.applyDijsktra();
		findPath.showPath();
	}
}