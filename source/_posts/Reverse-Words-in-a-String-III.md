---
title: Reverse-Words-in-a-String-III
date: 2017-12-15 09:29:55
categories: LeetCode
tags:
- LeetCode
- String
---

第79天。

今天的题目是[Reverse Words in a String III](https://leetcode.com/problems/reverse-words-in-a-string-iii/description/):

> Given a string, you need to reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.
>
> Example 1:
> Input: "Let's take LeetCode contest"
> Output: "s'teL ekat edoCteeL tsetnoc"
> Note: In the string, each word is separated by single space and there will not be > any extra space in the string.

用`python`的话就很简单了：

```python
def reverseWords(self, s):
    """
    :type s: str
    :rtype: str
    """
    words = s.split()
    for i in range(len(words)):
        words[i] = words[i][::-1]
    return ' '.join(words)
```

然后是`dicuss`中的`c`解法：

```c
void reverse(int b, int e, char *s){
    while(b < e) {
        s[b] = s[b] ^ s[e];
        s[e] = s[b] ^ s[e];
        s[b] = s[b] ^ s[e];
        b++;
        e--;
    }
}

char* reverseWords(char* s) {
    int i, s_len = strlen(s), index = 0;

    for(i = 0; i <= s_len; i++) {
        if((s[i] == ' ') || (s[i] == '\0')){
            reverse(index, i - 1, s);
            index = i + 1;
        }
    }
    return s;
}
```
