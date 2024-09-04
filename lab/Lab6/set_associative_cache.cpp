#include "set_associative_cache.h"
#include <string>
#include <fstream>
#include <sstream>
#include <bitset>
#include <cmath>
#include <vector>
#include <algorithm>
using namespace std;

vector<vector<string> > LRU;

string HexstringTOBinarystring(string s){
    stringstream ss;
    ss << hex << s;
    unsigned n;
    ss >> n;
    bitset<32> b(n);
    return b.to_string();
}

float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = -1;
    int hit_num = 0;

    /*write your code HERE*/
    total_num += 1; // 讓他變成零

    ifstream Fp;
    Fp.open(filename);

    vector<vector<string> > cache;
    cache.resize(cache_size/(block_size*way));
    for(int i = 0 ; i < cache_size/(block_size*way) ; i++){
        cache[i].resize(way);
    }

    LRU.resize(cache_size/(block_size*way));
    
    int sets = way * block_size;
    double index_bit = log2((double)cache_size/sets);
    double offset_bit = log2((double)block_size);
    double tag_bit = 32 - index_bit - offset_bit;

    string hex_num;

    while(Fp >> hex_num){
        int len = hex_num.length();
        if(len != 8){
            for(int i = 0 ; i < 8 - len ; i++){
              hex_num.insert(0, "0");
            }
        }

        string binary_num = HexstringTOBinarystring(hex_num);
        string index_pos_str = binary_num.substr(tag_bit, index_bit);

        string tag_string = binary_num.substr(0, tag_bit);
        int index_pos_int = stoi(index_pos_str, 0 , 2);

        bool whether_done = false;

        for(int i = 0 ; i < way ; i++){
            if(cache[index_pos_int][i].empty()){
                whether_done = true;
                cache[index_pos_int][i] = tag_string;
                LRU[index_pos_int].insert(LRU[index_pos_int].begin(), tag_string);
                break;
            }
            
            if(cache[index_pos_int][i] == tag_string){
                whether_done = true;
                hit_num++;

                ptrdiff_t pos = find(LRU[index_pos_int].begin(), LRU[index_pos_int].end(), tag_string) - LRU[index_pos_int].begin();
                LRU[index_pos_int].erase(LRU[index_pos_int].begin() + pos);
                LRU[index_pos_int].insert(LRU[index_pos_int].begin(), tag_string);
                break;
            }
        }

        // 代表滿ㄌ且沒有 hit
        if(whether_done == false){
            string tmp = LRU[index_pos_int][way-1];

            for(int i = 0 ; i < way ; i++){
                if(cache[index_pos_int][i] == tmp){
                    cache[index_pos_int][i] = tag_string;
                }
            }

            LRU[index_pos_int].pop_back();
            LRU[index_pos_int].insert(LRU[index_pos_int].begin(), tag_string);
        }

        total_num++;
    }

    Fp.close();

    return (float)hit_num/total_num;
}
