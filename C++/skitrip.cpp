/*
NTUA ECE PL1 2016-2017 Set1 Skitrip C++
Constantinos Karouzos ckarouzos@gmail.com 03114176
Alexandros Kafiris alexkafiris@gmail.com 03114044


*/
#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>
#include <vector>

using namespace std;

int main (int argc,char** argv){

    string line;
    long N;
    ifstream myfile (argv[1]);
    if (myfile.is_open()){
        getline (myfile,line);
        N=atoi (line.c_str());
        ios::sync_with_stdio(false);

        long B;
        typedef pair <long, long> LongPair;
        vector<LongPair> vY;
        long i;
        for (i=0; i<N; i++){
            myfile>>B;
            vY.push_back(make_pair(B,i));
        }
        vector<LongPair> a,b;
        a.push_back(vY[0]);
    	long j=0;
    	for (i=0; i< N; i++){
  			if (a[j].first>=vY[i].first){
  				a.push_back(vY[i]);
  				j++;
  			}
    	}
    	b.push_back(vY[N-1]);
    	j=0;
    	for (i=N-1; i>=0; i--){
    		if (b[j].first<=vY[i].first){
    			b.push_back(vY[i]);
    			j++;
    		}
    	}
    	long k=0,l=b.size()-1, max=0;
    	do{
    		while (a[k].first<=b[l].first && l>=0){
    			if (b[l].second-a[k].second>max){
    				max=b[l].second-a[k].second;
    			}
    			l--;
    		}
    		k++;
    	}while((unsigned) k<a.size() && l>=0);
        cout<<max;
    }
    return 0;
}
