import java.util.*;
import java.lang.*;
public class PathFinder{
	private int startPoint,endPoint,arraysSize,pathPointer;
	private ArrayList<ArrayList<MapNode>> mapToCheck;
	public ArrayList<MapNode> refList;
	private boolean [] visitedNode;
	private double [] distanceFromStart;
	private DirectionNode [] prevNode ;
	private String RouteFound;
	private PriorityQueue<ObjectForComparison> newPrQ = new PriorityQueue<ObjectForComparison>();

	PathFinder(ArrayList<ArrayList<MapNode>> givenList,int S,int E,int givenCounter){
		double inf = Double.POSITIVE_INFINITY;
		mapToCheck = new ArrayList<ArrayList<MapNode>>(givenList);
		startPoint = S;
		endPoint = E;
		arraysSize = givenCounter;
		visitedNode = new boolean[arraysSize];
		distanceFromStart = new double[arraysSize];
		prevNode = new DirectionNode[arraysSize];
		for(int i=0;i<arraysSize;i++){ 
			distanceFromStart[i] = inf;
			visitedNode[i] = false;
			prevNode[i] = new DirectionNode(0,' ');
		}
		distanceFromStart[startPoint] = 0;
		prevNode[startPoint] = new DirectionNode(-1,'S');
	}

	public void applyDijsktra(){
		int cellNodeExam;
		long examDist;
		int nodeExamCost;
		ObjectForComparison resultObject;
		newPrQ.add(new ObjectForComparison(startPoint,0));
		do{
			resultObject = new ObjectForComparison(newPrQ.peek().giveNodeNum(),newPrQ.poll().giveNodeDist());
			cellNodeExam = resultObject.giveNodeNum();
			examDist = resultObject.giveNodeDist();
			if(!visitedNode[cellNodeExam]){
				visitedNode[cellNodeExam] = true;
				for(int i=0;i<mapToCheck.get(cellNodeExam).size();i++){
					if(distanceFromStart[mapToCheck.get(cellNodeExam).get(i).giveNum()]>mapToCheck.get(cellNodeExam).get(i).giveCost() + examDist){
						distanceFromStart[mapToCheck.get(cellNodeExam).get(i).giveNum()] = mapToCheck.get(cellNodeExam).get(i).giveCost() + examDist;
						prevNode[mapToCheck.get(cellNodeExam).get(i).giveNum()] = new DirectionNode(cellNodeExam,mapToCheck.get(cellNodeExam).get(i).giveDir());
						newPrQ.add(new ObjectForComparison( mapToCheck.get(cellNodeExam).get(i).giveNum(),mapToCheck.get(cellNodeExam).get(i).giveCost() + examDist));
					}
				}
			}
		}while(!newPrQ.isEmpty());
	}

	public void showPath(){
		System.out.print((int)distanceFromStart[endPoint] + " ");
		RouteFound = "";
		pathPointer = endPoint;
		while(prevNode[pathPointer].takeNum() != -1){
			RouteFound = prevNode[pathPointer].takeDir() + RouteFound;
			pathPointer = prevNode[pathPointer].takeNum();
		}
		System.out.println(RouteFound);
	}

}
