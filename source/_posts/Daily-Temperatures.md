---
title: Daily Temperatures
date: 2019-03-20 11:17:39
tags:
- LeetCode
categories:
- LeetCode
---

> 第14天。

今天的题目是[Daily Temperatures](https://leetcode.com/problems/daily-temperatures/).

这道题会给我一个数组代表温度，如：`T = [73, 74, 75, 71, 69, 72, 76, 73]`

我们返回一个数组来表示，多少天会回暖（即比当天温度要高），如`[1, 1, 4, 2, 1, 1, 0, 0]`

如 74 比 73 高，则返回的数组中第一个数值应该为1，而对于 75 ，因为他后面只有76比他高，那么就得4天后才回暖，那么对应的位置应该放置4.

简单的想法当然是对每一个数字，从前向后找啦，但是这样复杂度就是`O(N^2)`了，所以我们换钟思路，从后向前去获取答案，看看能不能通过这种方式来减少复杂度。

之所以这样做，是想着能否利用之前已经求过的结果来推断当前的结果，比如求解 75 时，我们先猜答案是1，然后发现向前一天的温度是71，那么显然猜错了，这时我们要继续向前猜 69 吗？显然没必要啊，因为 69 都还没 71 大，我们应该利用之前求出的答案，发现比 71 大的数再他后面 2 天，所以我们直接猜答案是 1 + 2 即可，用这种方式就可以把前面的结果利用上了：

```c++
vector<int> dailyTemperatures(vector<int>& T) {
	int len = T.size();
	
	vector<int> res(len, 0);
	for(int i = len-2; i>= 0; --i) {
		int t = 1;
		while(T[i + t] <= T[i] && res[i+t] != 0)
			t += res[i+t];
		res[i] = (T[i+t] <= T[i])?0:t;
	}
	
	return res;
}
```