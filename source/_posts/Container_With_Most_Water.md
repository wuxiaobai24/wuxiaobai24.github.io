---
title: Container With Most Water
date: 2017-09-27 13:47:00
categories: LeetCode
tags:
- LeetCode
---

打卡，第四天

今天的题目是[Container With Most Water](https://leetcode.com/problems/container-with-most-water/description/)

> Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
> Note: You may not slant the container and n is at least 2.

很烦，今天老是时间超限，就是不能想出一个时间复杂度小的算法来。

先理解一下题目先，大概就是给你一个数组`height`，你要找出两个i，j使得`min(height[i],height[j])*(j - i)`最大。

很容易写出一个$ O(n^{2}) $ 的算法出来：

```c++
int maxArea(vector<int> &height) {
	int water = 0;
	for(int i = 0;i < height.size(); ++i)
		for (int j = 0;j < height.size(); ++j) {
			int h = min(height[i],height[j]);
			water = max(water,h*(j - i));
		}
	return water;
}
```

但是这个算法是不能过最后一个测例的。

想了一个小时都没想出一个好方法来减少他的复杂度,后来就去翻`dicuss`，看到这样一个算法：

```c++
int maxArea(vector<int> &height) {
	int water = 0;
	int i = 0,j = height.size() - 1;
	while(i < j) {
		int h = min(height[i],height[j]);
		water = max(water,h*(j - i));
		while(height[i] <= h && i < j) i++;
		while(height[j] <= h && i < j) j++;
	}
}
```

这里是先取最宽的容器，假设他就是我们要的结果。
因为`i`不断变大,`j`不断变小，这样wide就不断变小，因为wide在变小，要比当前最大的容器还大的话就只能比当前高度高，这就是那两个`while`的作用，去除掉一个不可能的情况。


啊，我真菜，为什么老是想不出来呢！

