---
title: Next Greater Element III
date: 2019-11-13 22:47:20
tags:
- LeetCode
categories: LeetCode
---

> 第9天了。

今天的题目是[ Next Greater Element III ]( https://leetcode.com/problems/next-greater-element-iii/ ):

---

Given a positive **32-bit** integer **n**, you need to find the smallest **32-bit** integer which has exactly the same digits existing in the integer **n** and is greater in value than n. If no such positive **32-bit** integer exists, you need to return -1.

**Example 1:**

```
Input: 12
Output: 21
```

 

**Example 2:**

```
Input: 21
Output: -1
```

---

这道题我的解法是：

1. 先将数字转换成数组，由于是除法和取余解析出来的数组，所以整个数组是倒过来的，即`123`得到`[3,2,1]`
2. 从前向后遍历找到第一个逆序（即`vec[i-1] > vec[i`)的情况。
3. 从`vec[0: i]`找到第一个小于等于`vec[i]`的元素`vec[j]`。
4. 交换`vec[i]`和`vec[j]`，然后将`vec[0: i]`逆序。
5. 将`vec`转换回数字，最后判断一下是否溢出即可。

```c++
int nextGreaterElement(int n) {
    long res = 0;
    vector<int> vec;
    while(n) {
        vec.push_back(n % 10);
        n /= 10;
    }
    int i, j;
    for(i = 1;i < vec.size() && vec[i-1] <= vec[i] ;++i) {   

    }
    if (i == vec.size()) return -1;

    for(j = 0;vec[i] >= vec[j];++j) {

    }
    swap(vec[i], vec[j]);
    for(j = 0, i = i - 1; j < i; j++, i--) {
        swap(vec[i], vec[j]);
    }

    for(i = vec.size() -1;i >= 0; i--) {

        res = res * 10 + vec[i];
    }
    if (res > INT_MAX) return -1;
    return res;
}
```

其实写到这里基本上发现，这道题就是找全排列中的下一个元素，而这个功能，在C++中提供了一个好用的函数：` next_permutation `，所以我们可以先用`to_string`转换成字符数组，然后用`next_permutation`来解这道题：

```c++
int nextGreaterElement(int n) {
    string s = to_string(n);
    if (next_permutation(s.begin(), s.end())) {
        long temp = atol(s.c_str());
        if (temp <= INT_MAX)  return temp;
        else return -1;
    }
    return -1;
}
```

