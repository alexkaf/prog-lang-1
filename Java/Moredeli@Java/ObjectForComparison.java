import java.lang.*;

public class ObjectForComparison implements Comparable<ObjectForComparison>{
	private int nodeNum,nodeCost;
	private long nodeDist;
	ObjectForComparison(int nodeNum,long nodeDist){
		this.nodeNum = nodeNum;
		this.nodeDist = nodeDist;
		this.nodeCost = nodeCost;
	} 

	public int giveNodeNum(){
		return nodeNum;
	}

	public long giveNodeDist(){
		return nodeDist;
	}

	public int compareTo(ObjectForComparison otherObject){
		if(nodeDist>otherObject.giveNodeDist()){
			return 1;
		}else{
			return -1;
		}
	}
}