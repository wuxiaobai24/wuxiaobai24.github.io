---
title: K Closest Points to Origin
date: 2019-11-6 13:24:29
categories: LeetCode
tags:
- LeetCode
---

> 第2天了。

今天的题目是[https://leetcode.com/problems/k-closest-points-to-origin/](K Closest Points to Origin):

---

We have a list of `points` on the plane. Find the `K` closest points to the origin `(0, 0)`.

(Here, the distance between two points on a plane is the Euclidean distance.)

You may return the answer in any order. The answer is guaranteed to be unique (except for the order that it is in.)

 

**Example 1:**

```
Input: points = [[1,3],[-2,2]], K = 1
Output: [[-2,2]]
Explanation: 
The distance between (1, 3) and the origin is sqrt(10).
The distance between (-2, 2) and the origin is sqrt(8).
Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
We only want the closest K = 1 points from the origin, so the answer is just [[-2,2]].
```

**Example 2:**

```
Input: points = [[3,3],[5,-1],[-2,4]], K = 2
Output: [[3,3],[-2,4]]
(The answer [[-2,4],[3,3]] would also be accepted.)
```

 

**Note:**

1. `1 <= K <= points.length <= 10000`
2. `-10000 < points[i][0] < 10000`
3. `-10000 < points[i][1] < 10000`

---

今天的题目比较简单，虽然是一道`Mediem`的题目，但是不知道为什么好像常规做法就AC了。解法就是算每个点到原点的距离先，然后排序，最后取出前K个就好了：

```c++
vector<vector<int>> kClosest(vector<vector<int>>& points, int K) {
    vector<vector<int>> res;
    vector<pair<int, int>> index;
    for(int i = 0, size = points.size(); i < size; i++) {
        pair<int,int> p = {i, points[i][0]*points[i][0] + points[i][1]*points[i][1]};
        index.push_back(p);
    }

    sort(index.begin(), index.end(), [](const pair<int, int> &pi, const pair<int, int> &pj) {
        return pi.second < pj.second;
    });

    for(int i = 0;i < K;i++) {
        res.push_back(points[index[i].first]);
    }

    return res;
}
```

