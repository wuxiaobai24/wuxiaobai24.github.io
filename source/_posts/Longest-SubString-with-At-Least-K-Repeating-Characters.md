---
title: Longest SubString with At Least K Repeating Characters
date: 2017-10-05 13:22:54
categories: LeetCode
tags:
- LeetCode
- 串
---

打卡，第12天

今天刷的题目是[Longest Substring with At Least K Repeating Characters](https://leetcode.com/problems/longest-substring-with-at-least-k-repeating-characters/description/):

> Find the length of the longest substring T of a given string (consists of lowercase letters only) such that every character in T appears no less than k times.
>
>Input:
> s = "aaabb", k = 3
>
> Output:
> 3
>
> The longest substring is "aaa", as 'a' is repeated 3 times.
>
>Input:
> s = "ababbc", k = 2
>
> Output:
> 5
>
> The longest substring is "ababb", as 'a' is repeated 2 times and 'b' is repeated 3 times.

本来是以为像[Longest Substring Without Repeating Characters](https://wuxiaobai24.github.io/2017/10/01/LongestSubstringWithoutRepeatingCharacters/)一样用两个下标去遍历，然后动态规划的去做（问题来了？动态规划是什么。。。我竟然还没有去翻，拖延症又犯了），一开始发现我可能需要在遍历前先知道当前字符是否会出现k次啊，恩，那就先用一个`unordered_map`去遍历一遍字符串来记录出现的次数吧：

```c++
unordered_map<char,int> count;
for(auto c:s)
    ++count[c];
```

然后就开始思考什么时候`i`应该向前移动了，当`s[j]`出现的次数小于k时,`i`就应该变成`j+1`了，恩，这个时候我就应该计算`s[i,j]`的长度,显然不能直接是`j-i`来算长度啦，因为在以下情况时，它就失灵了：

> Input: s = "ababacb" k = 3

如果直接`j-i`的话，就会得出5，但是显然在这个子串中，`b`只出现了两次，所以我们还要回去检查一遍，然后就开始想要怎么计算长度，大概需要一个下标`t`从`i`一直往`j`移动，遍移动遍计算，那么问题来了，我怎么知道什么时候`t`应该往前走，什么时候应该计算，恩，干脆先遍历一遍计算一下出现次数，然后我才能知道什么计算。。。突然发现有点不对，我好像写的代码是重复的，恩，按照这个逻辑一直走下去，好像我会一直递归这个过程，想了想就写成递归的形式吧，看起来好像就莫名其妙的写出了一个用分治法的解法了：

- 先遍历一遍计算整个串中出现的次数
- 然后开始从头遍历，找出一个`t`使得`count[ s[t] ] < k`
- 找到了，我们就分别计算`s[i:t]`和s[`t+1:j]`的最大长度即可
- 没找到，那么说明整个串是符合的，我们直接返回串长度即可
- 递归结束的条件就是当串长度比k小的时候啦。

```c++
string s;   //为了减少递归传递而设置的全局变量
int t;

int longestSubstring(string ss, int tt) {
    if (tt <= 1) return ss.size();
    s = ss;
    t = tt;
    unordered_map<char,int> count;
    for(auto c:s)
        ++count[c];
    return longestSubString(0,s.size(),count);
}

int longestSubString(int beg,int end,unordered_map<char,int> &imap ){
    if (end - beg < t) return 0;
    int j;
    for(j = beg;j < end && imap[s[j]] >= t;j++)
        /*do nothing*/;
    if (j == end) return end - beg;
    unordered_map<char,int> right;
    for(int k = beg;k < j;k++){
        --imap[ s[k] ];//重复利用imap，减少空间复杂度
        ++right[ s[k] ];
    }
    return max(longestSubString(beg,j,right),
                longestSubString(j+1,end,imap));
}
```

有一点要注意的就是：如果是使用`map`而不是`unordered_map`的话，时间是会超限的。

然后是在`dicuss`中看到的解法：

下面这个的解法和我的类似，他的会比较简洁，不过应该没我的快，因为他每次都需要递归都是直接传递string的，而且调用`s.substr`其实挺耗费时间的，应该每次都是深拷贝。

```c++
int longestSubstring(string s, int k) {
        if(s.size() == 0 || k > s.size())   return 0;
        if(k == 0)  return s.size();
        unordered_map<char,int> Map;
        for(int i = 0; i < s.size(); i++){
            Map[s[i]]++;
        }
        int idx =0;
        while(idx <s.size() && Map[s[idx]] >= k)    idx++;
        if(idx == s.size()) return s.size();
        int left = longestSubstring(s.substr(0 , idx) , k);
        int right = longestSubstring(s.substr(idx+1) , k);
        return max(left, right);
    }
```

第二个是用迭代的方法做的，比较快点，但是好像最坏情况是会出现`O(n^2)`的时间复杂度：

```c++
int longestSubstring(string s, int k) {
   int max_len = 0;
   for (int first = 0; first+k <= s.size();) {
       int count[26] = {0};
       int mask = 0;
       int max_last = first;
       for (int last = first; last < s.size(); ++last) {
           int i = s[last] - 'a';
           count[i]++;
           if (count[i]<k) mask |= (1 << i);
           else   mask &= (~(1 << i));
           
           if (mask == 0) {
               max_len = max(max_len, last-first+1);
               max_last = last;
           }
       }
       first = max_last + 1;
   }
   return max_len;
}
```