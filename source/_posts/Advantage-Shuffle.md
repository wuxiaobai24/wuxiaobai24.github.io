---
title: Advantage Shuffle
date: 2019-11-19 12:22:52
tags:
- LeetCode
categories: LeetCode
---

> 第15天。emmm，这就半个月了？？

今天的题目是[ Advantage Shuffle ]( https://leetcode.com/problems/advantage-shuffle/ ):

---

Given two arrays `A` and `B` of equal size, the *advantage of `A` with respect to `B`* is the number of indices `i` for which `A[i] > B[i]`.

Return **any** permutation of `A` that maximizes its advantage with respect to `B`.

 

**Example 1:**

```
Input: A = [2,7,11,15], B = [1,10,4,11]
Output: [2,11,7,15]
```

**Example 2:**

```
Input: A = [12,24,8,32], B = [13,25,32,11]
Output: [24,32,8,12]
```

 

**Note:**

1. `1 <= A.length = B.length <= 10000`
2. `0 <= A[i] <= 10^9`
3. `0 <= B[i] <= 10^9`

---

这道题就是个贪心的思路，确保每个位置上，`A[i]`的值要么是`A`中第一个比`B[i]`大，要么是最小能用的值，这就涉及到了怎么找到第一个比`B[i]`大的值的问题了，我们可以二叉查找树来实现，这里用STL中的`multiset`即可：

```c++
vector<int> advantageCount1(vector<int>& A, vector<int>& B) {
    multiset<int> S(A.begin(), A.end());
    for(int i = 0;i < B.size(); i++) {
        auto it = S.upper_bound(B[i]);
        if (it == S.end()) {
            it = S.begin();
        }
        A[i] = *it;
        S.erase(it);
    }
    return A;
}
```

这个方法虽然可以AC，但是时间效率不高，所以我们可以用排序的方法来代替二叉查找树，我们按B从大到小的顺序来填A的值，这样如果A中当前能用的最大值比`B[i]`要大，那么`A[i]`为A中当前能用的最大值，否则为A中当前能用的最小值。

```c++
vector<int> advantageCount(vector<int>& A, vector<int>& B) {
    vector<int> res(A.size());
    vector<pair<int, int>> val2index(A.size());

    for(int i = 0;i < val2index.size(); i++) val2index[i] = make_pair(B[i], i);
    sort(A.begin(), A.end());
    sort(val2index.begin(), val2index.end());

    int first = 0, last = A.size() - 1;
    for(int i = A.size() - 1;i >= 0;i--) {
        if (val2index[i].first >= A[last]) {
            res[val2index[i].second] = A[first++];
        } else {
            res[val2index[i].second] = A[last--];
        }
    }

    return res;
}
```

