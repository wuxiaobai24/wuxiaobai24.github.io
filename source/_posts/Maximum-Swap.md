---
title: Maximum-Swap
date: 2017-12-11 10:00:36
categories: LeetCode
tags:
- LeetCode
---

第75天。

今天的题目是[Maximum Swap](https://leetcode.com/problems/maximum-swap/description/):

> Given a non-negative integer, you could swap two digits at most once to get the maximum valued number. Return the maximum valued number you could get.
>
> Example 1:
> Input: 2736
> Output: 7236
> Explanation: Swap the number 2 and the number 7.
> Example 2:
> Input: 9973
> Output: 9973
> Explanation: No swap.
> Note:
> The given number is in the range [0, 10^8]

怎么说呢，写一个不优雅的解法还是挺简单的。

先把`num`分解成多个`digit`，然后尝试在找出最大的，如果最大的值和最高位不同，我们就交换，如果相同，我们就找出除去最高位的最大值，直到找不到能交换的，或者交换一次，我们就退出。

然后把`digit`按照对应的次序还原即可：

```c++
int maximumSwap(int num) {
    vector<int> t;
    while(num != 0) {
        t.push_back(num % 10);
        num /= 10;
    }

    int k = t.size() - 1;
    while(k >= 0) {
        auto max = max_element(t.begin(),t.begin() + k + 1);
        if (*max != t[k]) {
            int a = *max;
            *max = t[k];
            t[k] = a;
            break;
        }
        k--;
    }

    for(auto it = t.rbegin();it != t.rend();it++) {
        num = 10 * num + *it;
    }
    return num;
}
```

然后是`dicuss`中的解法,好像想法差不多。

```c++
int maximumSwap(int num) {
    string numString = to_string(num);
    int n = numString.length();
    vector<int> dpPosition(n, -1);

    int curMaxPos = n - 1;
    for (int i = n - 1; i >= 0; i--) {
        if (numString[i] > numString[curMaxPos]) {
            curMaxPos = i;
        }
        dpPosition[i] = curMaxPos;
    }

    for (int i = 0; i < n; i++) {
        if(numString[dpPosition[i]] != numString[i]) {
            swap(numString[i], numString[dpPosition[i]]);
            break;
        }
    }

    return stoi(numString);
}
```