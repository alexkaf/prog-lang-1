import java.lang.Integer;
import java.util.*;
public class ListMaker{
	private ArrayList<ArrayList<Integer>> mapToEdit;
	private int dimN,dimM,mapCounter;
	private ArrayList<MapNode> nodeList = new ArrayList<MapNode>();
	private ArrayList<ArrayList<MapNode>> mapList = new ArrayList<ArrayList<MapNode>>(); 
	ListMaker(ArrayList<ArrayList<Integer>> givenMap,int N,int M,int counter){
		dimN = N;
		dimM = M;
		mapCounter = counter;
		mapToEdit = new ArrayList<ArrayList<Integer>>(givenMap);
	}

	public void listMakerOriginal(){
		for(int i=1;i<dimN+1;i++){
			for(int j=1;j<dimM+1;j++){
				if(mapToEdit.get(i).get(j)!=-1){
					if(mapToEdit.get(i).get(j+1)!=-1){
						nodeList.add(new MapNode(mapToEdit.get(i).get(j+1),'R',1));
					}
					if(mapToEdit.get(i-1).get(j)!=-1){
						nodeList.add(new MapNode(mapToEdit.get(i-1).get(j),'U',3));
						}
					if(mapToEdit.get(i).get(j-1)!=-1){
						nodeList.add(new MapNode(mapToEdit.get(i).get(j-1),'L',2));
					}
					if(mapToEdit.get(i+1).get(j)!=-1){
						nodeList.add(new MapNode(mapToEdit.get(i+1).get(j),'D',1));
					}
				mapList.add(new ArrayList<MapNode>(nodeList));
				nodeList.clear();
				}
			}
		}
	}

	public ArrayList<ArrayList<MapNode>> returnModMap(){
		return mapList;
	}

	public ArrayList<MapNode> returnNodeList(){
		return nodeList;
	}
	public void showList(){
		for(int i=0;i<mapCounter;i++){
			for(int j=0;j<mapList.get(i).size();j++){
				System.out.print("("+mapList.get(i).get(j).giveNum()+",");
				System.out.print(mapList.get(i).get(j).giveDir()+",");
				System.out.print(mapList.get(i).get(j).giveCost()+")");
			}
			System.out.println();
		}
	}
}