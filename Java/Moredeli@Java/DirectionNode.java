public class DirectionNode{
	private int nodeNum;
	private char nodeDir;
	DirectionNode(int nodeNum,char nodeDir){
		this.nodeNum = nodeNum;
		this.nodeDir = nodeDir;
	}

	public int takeNum(){
		return nodeNum;
	}

	public char takeDir(){
		return nodeDir;
	}

}