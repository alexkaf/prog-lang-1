public class NodeVillage{

	private int villageNumber;
	private NodeVillage villageParent;
	private int villageRank;

	//	Constructor for a new village setting its parent to itself and 
	//	keeping the number of the village.

	NodeVillage(int villageNumber){

		this.villageNumber = villageNumber;
		this.villageParent = this;
		this.villageRank = 0;

	}

	//	This function merges two villages of different sets.

	public void mergeVillageWith(NodeVillage villageToMerge){

		NodeVillage thisVillageHeadSet = this.findVillageSet();
		NodeVillage otherVillageHeadSet = villageToMerge.findVillageSet();

		if(thisVillageHeadSet.returnVillageNumber() == otherVillageHeadSet.returnVillageNumber()){

			return;

		}else{

			thisVillageHeadSet.villageParent = otherVillageHeadSet;

		}

	}


	//	This function finds the reference village of this set and returns
	// 	it. It can be called only by the object it is used in. The proccess 
	// 	is made with recursive methods and at the same time, every element's
	// 	parent is set to be the group's parent, so we achieve path compression.

	private NodeVillage findVillageSet(){

		if(this.villageParent.villageNumber == this.villageNumber){

			return this;

		}else{

			return this.villageParent.findVillageSet();

		}

	}


	//	Functions to return this village's parent, number and rank.

	public NodeVillage showHeadSet(){

		return this.findVillageSet();

	}

	public int returnVillageNumber(){
		
		return this.villageNumber;

	}

	public int returnVillageRank(){

		return this.villageRank;

	}

	public NodeVillage returnVillageParent(){

		return this.villageParent;

	}



}