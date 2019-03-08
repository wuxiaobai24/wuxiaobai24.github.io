---
title: Longest Repeating Character Replacement
date: 2019-03-05 10:20:25
tags:
- LeetCode
categories:
- LeetCode
---

> 第6天， 下雨了。。。。

今天的题目是[Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)。

emmmm，这道题一开始的解法虽然AC了，但是时间复杂度是`O(n^2)`，但是最佳解法却是`O(n)`，先看下我的解法：

思路比较简单，就是不断以某个字符为起始，以这个字符为目标，计算修改k次后能达到的长度，然而这样会有个问题，例如`ABBB`,如果`k`为1的话，我计算出来是`3`，但真实结果是`4`。

为了解决这个问题，我增加了一次判断，对前`k`个字符进行替换，替换成下一个字符，即以下一个字符为目标，计算修改`k`次后能达到的长度。

具体代码如下：

```c++
class Solution {
public:
    int characterReplacement(string s, int k) {
        int len = s.size();
        int res = 0;
        int j, a;
        for(int i = 0; i < len; i++) {
            char c = s[i];
            a = k;
            for(j = i+1;j < len; j++) {
                if (c != s[j]) {
                    if (a == 0) break;
                    else a--;
                }
            }
            res = max(j-i, res);
        }
        
        for(int i = 0;i < k && i+1 < len; i++) {
            char c = s[i+1];
            a = k-i-1;
            for(j = i + 2;j < len; j++) {
                if (c != s[j]) {
                    if (a == 0) break;
                    else a--;
                }
            }
            res = max(j-i, res);
        }
        
        return res;
    }
};
```


OK，现在可以忽略掉上面的解法了，看看`O(n)`的解法是怎样的：

```c++
class Solution {
public:
    int characterReplacement(string s, int k) {
        vector<int> ch(26);
        int start = 0, end = 0, max_count = 0;
        int len = s.size();
        while(end < len) {
            ch[s[end] - 'A']++;
            // update max_count
            max_count = max(max_count, ch[s[end]-'A']);
            end++;
            if ( end - start > max_count + k) {
                ch[s[start] - 'A']--;
                start++;
            }
        }
        return end - start;
    }
};
```

很精妙的用滑窗解决了这个问题：

首先，它用一个数组记录滑窗内的出现字符的个数，因此每次迭代或操作都向前移动一个字符而已，所以我们可以很容易维护出一个`max_count`，即所有字符出现次数最大的那一个。

然后如果是一个正确的解的话，要满足一个约束`end - start - k > max_count`,如果满足的话，可以增大滑窗去寻找更大的窗口，如果不行，那么我们就向前移动滑窗。

虽然在迭代结束后，我们不能保证当前滑窗就是满足约束的解，但是我们可以保证，最大的窗口大小一定和我们现在的滑窗大小是一样的，故可以得到解。