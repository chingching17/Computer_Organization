#include "direct_mapped_cache.h"
#include "string"
#include <fstream>
#include <sstream>
#include <bitset>
#include <cmath>

using namespace std;


struct Table
{
    bool valid;
    string tag;
};

string Hexstring2Binarystring(string s){
    stringstream ss;
    ss << hex << s;
    unsigned n;
    ss >> n;
    bitset<32> b(n);
    return b.to_string();
}

float direct_mapped(std::string filename, int block_size, int cache_size)
{
    int total_num = -1;
    int hit_num = 0;
    
    /*write your code HERE*/
    ifstream fp;
    fp.open(filename);

    total_num += 1; // 讓他變成零

    Table cache[16385];
    for(int i = 0 ; i < 16385 ; i++){
        cache[i].valid = false;
        cache[i].tag = "0";
    }

    
    double index_bit = log2((double)cache_size/block_size);
    double offset_bit = log2((double)block_size);
    double tag_bit = 32 - index_bit - offset_bit;
   
    string hex_num;
    while(fp >> hex_num){
        int len = hex_num.length();
        if(len != 8){
            for(int i = 0 ; i < 8 - len ; i++){
              hex_num.insert(0, "0");
            }
        }

        string binary_num = Hexstring2Binarystring(hex_num);
        string index_pos_str = binary_num.substr(tag_bit, index_bit);

        string tag_string = binary_num.substr(0, tag_bit);
        int index_pos_int = stoi(index_pos_str, 0 , 2);

        if(cache[index_pos_int].valid == false){
            cache[index_pos_int].tag = tag_string;
            cache[index_pos_int].valid = true;
        }
        else if(cache[index_pos_int].valid == true && cache[index_pos_int].tag != tag_string){
            cache[index_pos_int].tag = tag_string;
        }
        else if(cache[index_pos_int].valid == true && cache[index_pos_int].tag == tag_string){
            hit_num++;
        }
        
        total_num++;
    }
    fp.close();
    return (float)hit_num/total_num;
}
