/*
 NTUA ECE PL1 2016-2017 Set1 Spacedeli C++
 Constantinos Karouzos ckarouzos@gmail.com 03114176
 Alexandros Kafiris alexkafiris@gmail.com 03114044
 
 */

#include <stdio.h>
#include <iostream>
#include <vector>
#include <limits>
#include <fstream>
#include <queue>

using namespace std;

typedef vector <long int> horizontal;
typedef vector <horizontal> map;
typedef struct tree *node;
typedef vector <node> guide;

class comp{
public:
    bool operator() (const vector<long int> &a,const vector<long int> &b){
        return (a[0]>b[0]);
    }
};

struct tree{
    long int position;
    short int weight;
    char step;
    struct tree *next;
};

class file{
public:
    
    file(string str){
        V=-1;
        name.open(str,ios::in);
        getline(name,str);
        M=(int) str.length();
        for(int i=0;i<M+2;i++){
            line.push_back(-1);
        }
        space.push_back(line);
        line.clear();
        N=0;
        while(!name.eof()){
            line.push_back(-1);
            for(int i=0;i<M;i++){
                if(str[i]!='X'){
                    V++;
                    if(str[i]=='S')S=V;
                    if(str[i]=='E')E=V;
                    if(str[i]=='W'){
                        worm.push_back(V);
                    }
                    line.push_back(V);
                }else{
                    line.push_back(-1);
                }
            }
            line.push_back(-1);
            space.push_back(line);
            line.clear();
            N++;
            getline(name,str);
        }
        for(int i=0;i<M+2;i++){
            line.push_back(-1);
        }
        space.push_back(line);
    }
    
    void listing(){
        int counter=0;
        for(int i=1;i<=N;i++){
            for(int j=1;j<=M;j++){
                if(space[i][j]!=-1) {
                    list.push_back(nullptr);
                    if(space[i+1][j]!=-1){
                        node tmp=new struct tree;
                        tmp->position=space[i+1][j];
                        tmp->step='D';
                        tmp->weight=2;
                        tmp->next=list.back();
                        list.back()=tmp;
                    }
                    if(space[i-1][j]!=-1){
                        node tmp=new struct tree;
                        tmp->position=space[i-1][j];
                        tmp->step='U';
                        tmp->weight=2;
                        tmp->next=list.back();
                        list.back()=tmp;
                    }
                    if(space[i][j-1]!=-1){
                        node tmp=new struct tree;
                        tmp->position=space[i][j-1];
                        tmp->step='L';
                        tmp->weight=2;
                        tmp->next=list.back();
                        list.back()=tmp;
                    }if(space[i][j+1]!=-1){
                        node tmp=new struct tree;
                        tmp->position=space[i][j+1];
                        tmp->step='R';
                        tmp->weight=2;
                        tmp->next=list.back();
                        list.back()=tmp;
                    }
                    counter++;
                }
            }
        }
        node point=nullptr;
        for(long int i=0;i<=V;i++){
            list.push_back(nullptr);
            point=list[i];
            while(point!=nullptr){
                node tmp=new struct tree;
                tmp->position=point->position+V+1;
                tmp->weight=1;
                tmp->step=point->step;
                tmp->next=list.back();
                list.back()=tmp;
                point=point->next;
            }
        }
        for(long int i=0;i<(long int)worm.size();i++){
            node tmp1=new struct tree, tmp2=new struct tree;
            tmp1->position=worm[i]+V+1;
            tmp1->weight=tmp2->weight=1;
            tmp1->step=tmp2->step='W';
            tmp2->position=worm[i];
            tmp1->next=list[worm[i]];
            list[worm[i]]=tmp1;
            tmp2->next=list[worm[i]+V+1];
            list[worm[i]+V+1]=tmp2;
        }
    }
    
    void dijkstra(){
        double temp=std::numeric_limits<int>::max();
        vector <double> distance;
        horizontal candidate;
        vector <bool> visit;
        for(long int i=0;i<2*V+2;i++){
            distance.push_back(temp);
            link.push_back(0);
            visit.push_back(false);
        }
        node point;
        distance[S]=0;
        link[S]=-1;
        candidate.push_back(0);
        candidate.push_back(S);
        pq.push(candidate);
        long int place;
        for(long int i=0;i<(unsigned)list.size();i++){
            if(pq.empty())break;
            place=pq.top()[1];
            pq.pop();
            point=list[place];
            visit[place]=true;
            candidate.clear();
            while(point!=nullptr){
                if(distance[point->position]>distance[place]+point->weight){
                    distance[point->position]=distance[place]+point->weight;
                    link[point->position]=place;
                    candidate.push_back(distance[point->position]);
                    candidate.push_back(point->position);
                    pq.push(candidate);
                    candidate.clear();
                }
                point=point->next;
            }
        }
        cost=distance[E];
    }
    
    void route(){
        long int i=link[E];
        long int bef=E;
        node point;
        do{
            point=list[i];
            while(point!=nullptr){
                if(point->position==bef){
                    path.push_back(point->step);
                    bef=i;
                    break;
                }else{
                    point=point->next;
                }
            }
            i=link[i];
        }while(i!=-1);
    }
    
    void costing(){
        cout << "Cost of the shortest path is: " << cost << endl;
    }
    
    void preview(){
        cout << cost << " " ;
        for(long int i=path.size()-1;i>-1;i--){
            cout << path[i];
        }
        cout << endl;
    }
private:
    priority_queue <long int,vector<horizontal>,comp> pq;
    ifstream name;
    guide list;
    int M,N;
    long int V,E,cost,S;
    vector <char> path;
    horizontal line,worm,link;
    map space;
};

int main(int argc,char** argv){
    file original(argv[1]);
    original.listing();
    original.dijkstra();
    original.route();
    original.preview();
    return 0;
}