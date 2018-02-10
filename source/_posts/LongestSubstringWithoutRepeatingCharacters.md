---
title:  Longest Substring Without Repeating Characters
date: 2017-10-01 13:20:00
categories: LeetCode
tags:
- LeetCode
- 串
---

#  Longest Substring Without Repeating Characters

打卡，第8天

今天国庆，然而不会家，找了一道之前不敢做的题目做了——[Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/description/),开始又是想着用分治法去完成（因为算法课在讲分治法），然而并没有做出来，又是同一个原因，在治的时候复杂度降不下来。

题目描述：

> Given a string, find the length of the longest substring without repeating characters.
>
> Examples:
>
> Given "abcabcbb", the answer is "abc", which the length is 3.
>
> Given "bbbbb", the answer is "b", with the length of 1.
>
> Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

先放code吧：

```c++
int lengthOfLongestSubstring(string s) {
    int i = 0,j = 0;
    int ret = 0;
    map<char,bool> cbmap;
    while( j < s.size() ){
        while(j < s.size() && cbmap[s[j]] == false)
            cbmap[ s[j++] ] = true;
        ret = max(j-i,ret);
        while(i < j && cbmap[s[j]] != false)
            cbmap[ s[i++] ] = false;
        cbmap[ s[j++] ] = true;
    }
    return ret;
}
```

大概的思路是：

- 用两个下标来标识`Substring`的位置，`s[i,j)`就是我们当前的`Substring`.
- 用j去遍历整个串，如果当前子串中没有`s[j]`，`j`就继续往下遍历，如果有，这时就可以计算一下当前子串的长度和之前的最长子串长度进行对比。
- 在`j`停止遍历后，我们就让`i`向前移动，直到，当前子串不包含`s[j]`,这样我们就可以把`s[j]`加入当前子串，并继续进行遍历。

写着写着突然发现，有个地方可以改：

```c++
int lengthOfLongestSubstring(string s) {
    int ret = 0;
    map<char,bool> cbmap;
    for(int i = 0,j = 0; j < s.size();j++ ){
        while(j < s.size() && cbmap[s[j]] == false)
            cbmap[ s[j++] ] = true;
        ret = max(j-i,ret);
        while(i < j && s[i++] != s[j])
            cbmap[ s[i - 1] ] = false;
    }
    return ret;
}
```

思路还是一样的，只不过写的更加精炼了罢了。

然后看看`dicuss`中别人写的：

```c++
int lengthOfLongestSubstring(string s) {
    // for ASCII char sequence, use this as a hashmap
    vector<int> charIndex(256, -1);
    int longest = 0, m = 0;

    for (int i = 0; i < s.length(); i++) {
        m = max(charIndex[s[i]] + 1, m);    // automatically takes care of -1 case
        charIndex[s[i]] = i;
        longest = max(longest, i - m + 1);
    }

    return longest;
}

```

他这里用的是`vector<int>`去记录最大的下标，而我是用的是`map`去记录当前子串中是否有这个字符，用他这种方法可以把`i`向前移的循环给去掉。