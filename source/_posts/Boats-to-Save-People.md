---
title: Boats to Save People
date: 2019-11-17 10:24:21
tags:
- LeetCode
categories:
- LeetCode
---

> 第13天。

今天的题目是[ Boats to Save People ]( https://leetcode.com/problems/boats-to-save-people/ ):

---

The `i`-th person has weight `people[i]`, and each boat can carry a maximum weight of `limit`.

Each boat carries at most 2 people at the same time, provided the sum of the weight of those people is at most `limit`.

Return the minimum number of boats to carry every given person. (It is guaranteed each person can be carried by a boat.)

 

**Example 1:**

```
Input: people = [1,2], limit = 3
Output: 1
Explanation: 1 boat (1, 2)
```

**Example 2:**

```
Input: people = [3,2,2,1], limit = 3
Output: 3
Explanation: 3 boats (1, 2), (2) and (3)
```

**Example 3:**

```
Input: people = [3,5,3,4], limit = 5
Output: 4
Explanation: 4 boats (3), (3), (4), (5)
```

**Note**:

- `1 <= people.length <= 50000`
- `1 <= people[i] <= limit <= 30000`

---

一道贪心的题目，仔细分析下题目就会发现，如果一个`weight`比较大的人要坐船，一定是和`weight`小的人坐船，才能保证做的船数最少。因此，只要先排序，然后在双指针判断是否能做两个人即可：

```c++
int numRescueBoats1(vector<int>& people, int limit) {
    sort(people.begin(), people.end());
    int res = 0;

    int i = 0, j = people.size() -1;
    while(i <= j) {
        res += 1;
        if (limit >= people[i] + people[j]) {
            i++;
        }
        j--;
    }

    return res;
}
```

