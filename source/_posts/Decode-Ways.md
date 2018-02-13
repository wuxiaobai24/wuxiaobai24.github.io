---
title: Decode-Ways
date: 2018-02-13 16:47:08
tags: 
- LeetCode
- 动态规划
---

第99天。

今天的题目是[Decode Ways](https://leetcode.com/problems/decode-ways/description/):

> A message containing letters from A-Z is being encoded to numbers using the following mapping:

```python
'A' -> 1
'B' -> 2
...
'Z' -> 26
```

> Given an encoded message containing digits, determine the total number of ways to decode it.
>
> For example,
> Given encoded message "12", it could be decoded as "AB" (1 2) or "L" (12).
>
> The number of ways decoding "12" is 2.

在店里面发呆的时候突然想到的解法，虽然当然当时没有想出完整解法，但是找到了思路（动态规划的题目就是这样，一旦意识到是动态规划后就简单多了）,这道题主要难在要意识到是动态规划比较难，毕竟是要倒着做动态规划的。

```c++
int numDecodings(string s) {
    if (s.size() == 0) return 0;
    int i = s.size() - 1;
    s.push_back('\0');
    vector<int> dp(s.size() + 1, 0);
    dp[i+1] = 1;
    for(; i >= 0;i--) {
        switch(s[i]) {
            case '0': dp[i] = 0; break;
            case '1': dp[i] = dp[i+1] + dp[i+2]; break;
            case '2':
                if (s[i+1] >= '0' && s[i+1] <= '6') {
                    dp[i] = dp[i+1] + dp[i+2]; break;
                }
            default:
                dp[i] = dp[i+1];
        }
    }
    return dp[0];
}
```