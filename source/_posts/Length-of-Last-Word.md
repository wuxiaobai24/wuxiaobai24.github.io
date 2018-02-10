---
title: Length-of-Last-Word
date: 2017-12-12 10:49:45
categories: LeetCode
tags:
- LeetCode
---

第76天。

快考试，可能要水一个月的`easy`题了。

今天的题目是[Length of Last Word](https://leetcode.com/problems/length-of-last-word/description/):

> Given a string s consists of upper/lower-case alphabets and empty space characters ' ', return the length of last word in the string.
>
> If the last word does not exist, return 0.
>
> Note: A word is defined as a character sequence consists of non-space characters only.
>
> Example:
>
> Input: "Hello World"
> Output: 5


一看完题目，我就想到了`python`的`split`:

```python
def lengthOfLastWord(self, s):
    """
    :type s: str
    :rtype: int
    """
    words = s.split();
    if len(words) == 0: return 0;
    return len(words[-1])
```

然后是用`c++`用`find`去解的：

```c++
int lengthOfLastWord(string s) {
    auto beg = s.begin();
    auto it = beg;
    auto end = s.end();
    // fix the bug like that "hello world "
    for(int i = s.size() - 1;i >= 0 && s[i] == ' ';i--)
        end--;

    while((it = find(beg,end,' ')) != end) {
        beg = it + 1;
    }
    return end - beg;
}
```

然后是从后面向前扫描的方法：

```c++
int lengthOfLastWord(string s) {
    auto end = s.rbegin();
    while(end != s.rend() && *end == ' ') end++;
    auto beg = end;
    while(beg != s.rend() && *beg != ' ') beg++;
    return beg - end;
}
```

然后是`dicuss`中的解法，和上面的从后向前扫描的方法类似，只不过它第二个循环里面顺带计算了`length`:

```c++
int lengthOfLastWord(string s) { 
    int len = 0, tail = s.length() - 1;
    while (tail >= 0 && s[tail] == ' ') tail--;
    while (tail >= 0 && s[tail] != ' ') {
        len++;
        tail--;
    }
    return len;
}
```