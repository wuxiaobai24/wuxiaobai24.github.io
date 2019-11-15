---
title: Keys and Rooms
date: 2019-11-15 20:42:32
tags:
- LeetCode
categories:
- LeetCode
---

> 第11天。

今天的题目是[Keys and Rooms](https://leetcode.com/problems/keys-and-rooms/)：

---

There are `N` rooms and you start in room `0`. Each room has a distinct number in `0, 1, 2, ..., N-1`, and each room may have some keys to access the next room. 

Formally, each room `i` has a list of keys `rooms[i]`, and each key `rooms[i][j]` is an integer in `[0, 1, ..., N-1]` where `N = rooms.length`. A key `rooms[i][j] = v` opens the room with number `v`.

Initially, all the rooms start locked (except for room `0`). 

You can walk back and forth between rooms freely.

Return `true` if and only if you can enter every room.



**Example 1:**

```
Input: [[1],[2],[3],[]]
Output: true
Explanation:  
We start in room 0, and pick up key 1.
We then go to room 1, and pick up key 2.
We then go to room 2, and pick up key 3.
We then go to room 3.  Since we were able to go to every room, we return true.
```

**Example 2:**

```
Input: [[1,3],[3,0,1],[2],[0]]
Output: false
Explanation: We can't enter the room with number 2.
```

**Note:**

1. `1 <= rooms.length <= 1000`
2. `0 <= rooms[i].length <= 1000`
3. The number of keys in all rooms combined is at most `3000`.

---

很简单的一道题，仔细分析一下题目的话，就会发现这个输入其实构成一张图，`rooms[i]`表示从第`i`个节点出发走向的节点列表。然后这个问题就转变成，从`0`号节点出发，能不能遍历完所有节点的问题了，这个问题直接无脑`dfs`就好了，实现代码如下：

```c++
bool canVisitAllRooms(vector<vector<int>>& rooms) {
    vector<bool> visited(rooms.size(), false);
    dfs(rooms, visited, 0);
    
    for(int i = 0;i < visited.size(); ++i) { 
        if (visited[i] == false) {
            return false;
        } 
    }
    return true;
}
void dfs(vector<vector<int>>& rooms, vector<bool> &visited, int index = 0) {
    visited[index] = true;
    for(int i = 0;i < rooms[index].size(); ++i) {
        if (visited[rooms[index][i]] == false) {
            dfs(rooms, visited, rooms[index][i]);
        }
    }
}
```
