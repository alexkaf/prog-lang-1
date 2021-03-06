/*
NTUA ECE PL1 2016-2017 Set3 Skitrip Hopping 
Constantinos Karouzos ckarouzos@gmail.com 03114176
Alexandros Kafiris alexkafiris@gmail.com 03114044


*/

#include <iostream>
#include <fstream>
#include <list>

using namespace std;

int* fixway(int Goal, int Way[], list<int> Moves, int p){
        if (Moves.empty() ) {
            return Way;
        }
        else if (p+Moves.front()> Goal) return Way;
        else if (Way[p+ Moves.front()-1]==-1) {
            Moves.pop_front();
            return fixway(Goal, Way, Moves, p);
        }
        else {
            int temp = (Way[p+Moves.front()-1]+Way[p-1]) % 1000000009;
            Way[p+Moves.front()-1]=temp;
            Moves.pop_front();
            return fixway(Goal, Way, Moves, p);
        }
}

int count(int Goal, int Way[], list<int> Moves, int p){
    if (Goal==p) return Way[Goal-1];
    else if (Way[p-1]<1) return count(Goal, Way, Moves, p+1);
    else {
        int* NWay=fixway(Goal, Way, Moves, p);
        return count (Goal, NWay, Moves, p+1);
    }
}

int main (int argc,char** argv){

    string line;

    ifstream myfile (argv[1]);
    if (myfile.is_open()){
    	int N, K, B;
    	myfile>>N;
    	myfile>>K;
    	myfile>>B;
    	int i, t;
    	list<int> S;
        for (i=0; i<K; i++){
            myfile>>t;
            S.push_back(t);
    	}
    	S.sort();
    	int X[B];
        for	(i=0; i<B; i++){
            myfile>>X[i];
        }

        int Stairs[N];
        Stairs[0]=1;
        for (i=1; i<N; i++)	Stairs[i]=0;
        for (i=0; i<B; i++) Stairs[X[i]-1]=-1;
          if (Stairs[0]==-1 || Stairs[N-1]==-1) cout<<0;
          else{
              cout<< count(N,Stairs,S,1);
          }
    }
}
