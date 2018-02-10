---
title: Longest Common Prefix
date: 2017-09-25 09:59:00
categories: LeetCode
tags:
- LeetCode
- 串
---


恩，今天早上1,2节没课，闲来无事就先把今天的题刷了（你的算法分析实验呢？）今天的题目是[Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix/description/),恩，比那个什么最长公共子串简单多了，很容易就可以找到思路（虽然写出来的代码很难看）

大概的解题思路是：

- 先找出最短的字符串，假定他就是我们要的答案
- 遍历所有字符串，看他们是否有这个字符串
	- 如果有就直接返回
	- 如果没有就把子串长度减小，再进行重复操作

思路很简单，但我写的很渣（直接过，我也是很懵，我还想再敲多一下的）

先上我的代码吧：


```c++
string longestCommonPrefix(vector<string>& strs) {
    if (strs.empty()) return "";
    else if (strs.size() == 1) return strs[0];
    string ret =  strs[0];
    for(auto &s:strs) {
        if (ret.size() > s.size())
            ret = s;
    }
    while(ret.size() > 0) {
        bool is = true;
        for(auto &s:strs){
            if (s.substr(0,ret.size()) != ret) {
                is = false;
                break;
            }
        }
        if (!is) ret = ret.substr(0,ret.size() - 1);
        else return ret;
    }
    return "";
    
}
``` 

恩，我是没想到它会直接过的，思路相当简单，当然思路简单一般效率就不会很高。

我的思路一开始是假定最短的串是我们要的结果，而在`dicuss`中别人的写法是另一种思路：

```c++
string longestCommonPrefix(vector<string>& strs) {
   string prefix = "";
    for(int idx=0; strs.size()>0; prefix+=strs[0][idx], idx++)
        for(int i=0; i<strs.size(); i++)
            if(idx >= strs[i].size() ||(i > 0 && strs[i][idx] != strs[i-1][idx]))
                return prefix;
    return prefix;
}
```

比我的代码简洁很多，他是先假定最长前缀是空，然后在用动态规划的思路去做的（恩，要好好研究一下动态规划），而且他这种写法就不需要判断传入的`vector`是不是空了。