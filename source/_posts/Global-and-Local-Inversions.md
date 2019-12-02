---
title: Global and Local Inversions
date: 2019-12-02 10:11:09
tags:
- LeetCode
categories: LeetCode
---

> 第26天

今天的题目是[Global and Local Inversions](https://leetcode.com/problems/global-and-local-inversions/)：

看上去挺复杂的题目，但是我们可以从题目中知道，输入的数组是一个 `[0,1,...,N-1]` 的一个排列，所以A中的元素是有限定的，

多举几个例子就可以发现如果一个排列要满足 `local inversion` 和 `global inversion` 个数相同的话，必须满足：

- `A[i] == i`
- `A[i] == i+1 && A[i+1] == i`

所以我们就可以写出这段代码：

```c++
bool isIdealPermutation(vector<int>& A) {
    int minLimit = INT_MIN;
    for(int i = 0, size = A.size() - 1; i < size; i++) {
        if (A[i] == i) ;
        else if (A[i] == i + 1 && A[i+1] == i) {
            i++;
        } else return false;
    }
    return true;
}
```
