---
title: Top K Frequent Elements
date: 2020-01-27 21:58:53
tags:
- LeetCode
categories: LeetCode
---

> 第60天。hhh，一回家就没做了。在家无聊到开始找活干了。

今天的题目是[347. Top K Frequent Elements
](https://leetcode.com/problems/top-k-frequent-elements/):

挺简单的题目，先统计元素出现的次数，然后根据元素出现的次数来进行排序，然后取出现次数最多的前K个即可。

```c++
vector<int> topKFrequent1(vector<int>& nums, int k) {
	vector<int> res(k);
	unordered_map<int, int> imap;
	for(int i = 0, n = nums.size(); i < n; i++) {
		imap[nums[i]]++;
	}
	
	vector<pair<int, int>> temp(imap.begin(), imap.end());
	auto f = [](const pair<int, int> &p1, const pair<int, int> &p2) {
		return p1.second > p2.second;  
	};
	sort(temp.begin(), temp.end(), f);
	for(int i = 0;i < k; i++) {
		res[i] = temp[i].first;
	}
	return res;    
}
```