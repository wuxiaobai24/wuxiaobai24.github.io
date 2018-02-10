---
title: Word Break
date: 2017-10-27 20:27:53
categories: LeetCode
tags:
- LeetCode
- 动态规划
---

第33天。

做了超级久。。。还是没做出来，我真是菜啊，明明已经想到了要用动态规划来做了。

今天的题目是:[Word Break](https://leetcode.com/problems/word-break/description/):

> Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words. You may assume the dictionary does not contain duplicate words.
>
> For example, given
> s = "leetcode",
> dict = ["leet", "code"].
>
> Return true because "leetcode" can be segmented as "leet code".

因为没做出来，所以只能讲别人的思路了。。。

首先这里是要用动态规划去做的，我们需要一个`vector<bool> db`来记录`s.substr(0,i+1)`的子串是否能用`wordDict`进行`break`,如果我们要求`db[i]`我们是否能利用`db[0:i]`的值呢，比如，如果`0<= k < i`，且`db[k]==true`,那么我们是不是只需要在`wordDict`中查找是否有`s.substr(i,k-i)`就可了呢：

```c++
    bool wordBreak(string s,vector<string> &wordDict) {
        if(wordDict.size() == 0) return false;
        vector<bool> dp(s.size() + 1,false);
        dp[0] = true;
        for(int i = 1;i <= s.size();i++) {
            for(int j = i-1;j >= 0;j--) {
                if (dp[j]) {
                    string word = s.substr(j,i-j);
                    if (find(wordDict.begin(),wordDict.end(),word) != wordDict.end()) {
                        dp[i] = true;
                        break;
                    }
                }
            }
        }
        return dp[s.size()];
    }
```

因为是别人的思路，所以也没法复现思考的过程了，总结一下没做出来的原因吧。
虽然说算法课上刚讲了`DP`,当时他讲的时候我还觉得挺简单的，还以为自己已经会了，因为之前已经做过好几次`DP`的题目了，现在想想上课我就记得他吐槽了`DP`的恋爱观，什么总是找局部最优解巴拉巴拉的。
哎，这种东西还是要自己体会才行，恩，决定了，这几天刷会`DP`的题目先。