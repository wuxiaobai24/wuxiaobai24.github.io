---
title: LongestPalindromicSubString
date: 2017-10-03 11:14:39
categories: LeetCode
tags:
- LeetCode
- 串
- 分治法
---

打卡，第10天

今天刷的题是[Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/description/),开始想着用动态规划做，但是我好像连动态规划是什么我都不知道。。。

题目:

> Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.
>
> Example:
>
> Input: "babad"
>
> Output: "bab"
>
> Note: "aba" is also a valid answer.
> Example:
>
> Input: "cbbd"
>
> Output: "bb"

所以一如既往的想到了分治法:

```c++
bool isPalindrome(string &s,int first,int last){
    while(first < last && s[first] == s[last]){
        first++;
        last--;
    }
    if (first >= last) return true;
    else return false;
}
string longestPalindrome(string s) {
    int retF,retL;
    int l = longestPalindrome(s,0,s.size() -1 ,retF);
    return s.substr(retF,l);
}

int longestPalindrome(string &s,int first,int last,int &retF){
    if (first < last){
        int lF,rF,mF;
        int mid = (first + last)/2;   //分
        //治
        int l = longestPalindrome(s,first,mid,lF);
        int r = longestPalindrome(s,mid + 1,last,rF);
        int ret = max(l,r);
        //合，已知
        int midMax = ret;
        for(int i = first;i <=mid ;i++)
            for(int j = mid + 1;j <= last;j++){
                if (j-i +1 > midMax && isPalindrome(s,i,j)){
                    midMax = j-i+1;
                    mF = i;
                }
            }
        if (midMax > ret){
            retF = mF;
            return midMax;
        } else if (ret == l){
            retF = lF;
        } else{
            retF = rF;
        }
        return ret;
    } else if (first == last ) {
        retF = first;
        return 1;
    } else {
        retF = first;
        return 0;
    }
}
```

大概的思路是：

- 先用分治法将问题规模不断减半，那么现在只需要考虑如何“合”了
- 这里"合"的时间复杂度是O(n^2)，没能找出更快的，嗯，不对，好像是O(n^3)....
- whatever，这里的合就是用穷举法去做的，不过不知道为什么还是过了测试

然后是`dicuss`中的解法：

```c++
string longestPalindrome(string s) {
    if (s.empty()) return "";
    if (s.size() == 1) return s;
    int min_start = 0, max_len = 1;
    for (int i = 0; i < s.size();) {
      if (s.size() - i <= max_len / 2) break;
      int j = i, k = i;
      while (k < s.size()-1 && s[k+1] == s[k]) ++k; // Skip duplicate characters.
      i = k+1;
      while (k < s.size()-1 && j > 0 && s[k + 1] == s[j - 1]) { ++k; --j; } // Expand.
      int new_len = k - j + 1;
      if (new_len > max_len) { min_start = j; max_len = new_len; }
    }
    return s.substr(min_start, max_len);
}
```

emmm,这里好像也是用点穷举的感觉。
