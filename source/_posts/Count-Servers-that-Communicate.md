---
title: Count Servers that Communicate
date: 2019-12-29 21:24:31
tags:
- LeetCode
categories: LeetCode
---

> 第52天，有点浪的一天。survey一点没动的我。

今天的题目是[Count Servers that Communicate](https://leetcode.com/problems/count-servers-that-communicate/)。


水题，只要遍历一次计算每一行和每一列之和，然后再遍历判断是否为1，且所在行或列不止一个节点即可。

```c++
int countServers(vector<vector<int>>& grid) {
    int m = grid.size();
    if (m == 0) return 0;
    int n = grid[0].size(); 
    if (n == 0) return 0;
    vector<int> a(m, 0);
    vector<int> b(n, 0);
    
    for(int i = 0;i < m; i++) {
        for(int j = 0;j < n; j++) {
            if (grid[i][j]) {
                a[i]++;
                b[j]++;
            }
        }
    }
    int res = 0;
    for(int i = 0;i < m; i++) {
        for(int j = 0;j < n; j++) {
            if (grid[i][j] && (a[i] > 1 || b[j] > 1))
                res++;
        }
    }
    return res;
    
}
```

还看到一种做法，先遍历一遍，每一行都记录下值为1的grid的个数，如果个数大于一，则表示这些点都是能通信的点，如果等于一，则将该点位置记录下来。

然后将对所有记录下来的点判断一次是否其所在列的点的个数大于2。

```c++
int countServers(vector<vector<int>>& grid) {
    int m = grid.size();
    if (m == 0) return 0;
    int n = grid[0].size(); 
    if (n == 0) return 0;
    vector<int> vec;
    int res = 0;
    for(int i = 0;i < m; i++) {
        vector<int> temp;
        for(int j = 0;j < n; j++) {
            if (grid[i][j]) temp.push_back(j);
        }
        
        if (temp.size() > 1) res += temp.size();
        else if (temp.size() == 1) {
            vec.push_back(temp[0]);
        }
    }
    
    for(auto &j: vec) {
        int count = 0;
        for(int i = 0;i < m; i++) {
            if (grid[i][j]) count++;
            if (count > 1) {
                res += 1;
                break;
            }
        }
    }
    
    return res;
}
```