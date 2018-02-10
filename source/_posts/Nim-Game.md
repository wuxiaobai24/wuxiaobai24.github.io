---
title: Nim-Game
date: 2018-01-25 10:52:41
categories: LeetCode
tags:
- LeetCode
---

第94天。

今天的题目有点智障。。。

今天的题目是[Nim Game](https://leetcode.com/problems/nim-game/description/):

> You are playing the following Nim Game with your friend: There is a heap of stones on the table, each time one of you take turns to remove 1 to 3 stones. The one who removes the last stone will be the winner. You will take the first turn to remove the stones.
>
> Both of you are very clever and have optimal strategies for the game. Write a function to determine whether you can win the game given the number of stones in the heap.
>
> For example, if there are 4 stones in the heap, then you will never win the game: no matter 1, 2, or 3 stones you remove, the last stone will always be removed by your friend.

很自然的想到用`dp`去做，然而时间超限了：

```c++
bool canWinNim1(int n) {
    if (n <= 3) return true;
    vector<bool> dp(n+1,false);
    dp[1] = dp[2] = dp[3] = true;
    for(int i = 4;i <= n;i++) {
        dp[i] = !(dp[i-1] && dp[i-2] && dp[i-3]);
   //     if (dp[i] == false) cout << i << " ";
    }
    // cout << endl;
    return dp[n];
}
```

把`false`的值输出来之后，发现，只要不是4的倍数就会赢。

```c++
bool canWinNim(int n) {
    return n % 4;
}
```