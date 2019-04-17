import java.io.*;
import java.util.*;
import java.lang.Integer;

public class FileReading{
	private String fileName,tempLine;
	private FileReader fileRead;
	private BufferedReader fileBuffer;
	private int N,M,counter,startPoint,endPoint;
	private ArrayList<Integer> tempWord = new ArrayList<Integer>();
	private ArrayList<ArrayList<Integer>> convMap = new ArrayList<ArrayList<Integer>>();

	FileReading(String inputName)throws IOException{
		fileRead = new FileReader((fileName = inputName));
		fileBuffer = new BufferedReader(fileRead);
	}

	public void passToArrayList() throws IOException{
		N=counter=0;
		tempLine = fileBuffer.readLine();
		M = tempLine.length();
		for(int i=0;i<M+2;i++){
			tempWord.add(new Integer(-1));
		}
		convMap.add(new ArrayList<Integer>(tempWord));
		tempWord.clear();
		while(tempLine!=null){
			N++;
			tempWord.add(new Integer(-1));
			for(int i=0;i<M;i++){
				if(tempLine.charAt(i)!='X'){
					tempWord.add(counter++);
					if(tempLine.charAt(i)=='S'){
						startPoint = counter-1;
						continue;
					}else if(tempLine.charAt(i)=='E'){
						endPoint = counter -1;
						continue;
					}
				}else{
					tempWord.add(new Integer(-1));
				}
			}
			tempWord.add(new Integer(-1));
			convMap.add(new ArrayList<Integer>(tempWord));
			tempWord.clear();
			tempLine = fileBuffer.readLine();
		}
		for(int i=0;i<M+2;i++){
			tempWord.add(new Integer(-1));
		}
		convMap.add(new ArrayList<Integer>(tempWord));
		tempWord.clear();
	}

	public ArrayList<ArrayList<Integer>> giveConvertedMap(){
		return convMap;
	}

	public int returnStart(){
		return startPoint;
	}

	public int returnEnd(){
		return endPoint;
	}

	public int returnDimN(){
		return N;
	}

	public int returnDimM(){
		return M;
	}

	public int returnCounter(){
		return counter;
	}
	public void showFile(){
		System.out.println("N = " + N + " M = " + M);
		for(int i=1;i<convMap.size()-1;i++){
			for(int j=1;j<convMap.get(i).size()-1;j++){
				System.out.print(convMap.get(i).get(j)+" ");
			}
			System.out.println();
		}
	}


}