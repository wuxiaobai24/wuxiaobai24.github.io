---
title: Jump Game III
date: 2020-01-28 12:35:04
tags:
- LeetCode
categories: LeetCode
---

> 第61天。

今天的题目是[Jump Game III](https://leetcode.com/problems/jump-game-iii/):

用广度优先遍历出来即可，为了防止死循环，所以我们需要一个`visited`数组来记录某个位置的元素是否已经访问过来（即是否压入了队列中）：

```c++
bool canReach(vector<int>& arr, int start) {
	queue<int> q;
	vector<int> visited(arr.size(), false);
	q.push(start);
	visited[start] = true;
	while(!q.empty()) {
		for(int i = 0, size = q.size(); i < size; i++) {
			start = q.front(); q.pop();
			if (arr[start] == 0) return true;
			if (start - arr[start] >= 0 && visited[start - arr[start]] == false) {
				q.push(start - arr[start]);
				visited[start - arr[start]] = true;
			}    
			if (start + arr[start] < arr.size() && visited[start + arr[start]] == false) { 
				q.push(start + arr[start]);
				visited[start + arr[start]] = true;
			}
		}
	}
	return false;
}
```