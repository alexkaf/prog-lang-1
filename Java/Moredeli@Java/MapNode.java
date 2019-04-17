public class MapNode {
	private int nodeNumber,transCost;
	private char nodeDir;
	MapNode(int nodeNumber,char nodeDir,int transCost){
		this.nodeNumber = nodeNumber;
		this.transCost = transCost;
		this.nodeDir = nodeDir;
	}

	public int giveCost(){
		return transCost;
	}

	public char giveDir(){
		return nodeDir;
	}

	public int giveNum(){
		return nodeNumber;
	}

}