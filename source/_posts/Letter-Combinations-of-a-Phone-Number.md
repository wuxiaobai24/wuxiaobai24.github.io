---
title: Letter Combinations of a Phone Number
date: 2017-10-06 16:33:22
categories: LeetCode
tags:
- LeetCode
- 串
---

打卡，第13天

昨晚贼晚睡，然后今天就快吃午饭才起来，然后我又躺尸了一个下午。。。

今天刷了一道`Medium`的题目——[ Letter Combinations of a Phone Number](https://leetcode.com/problems/letter-combinations-of-a-phone-number/description/)，不过感觉好水，就和学校oj一样水。。。

> Given a digit string, return all possible letter combinations that the number could represent.
>
> A mapping of digit to letters (just like on the telephone buttons) is given below.
> Input:Digit string "23"
> Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
> Note:
> Although the above answer is in lexicographical order, your answer could be in any order you want.

恩，大概思路就是要求`letterCombinations(digits)`,我们就需要求`letterCombinations(digits.substr(0,n-1)`.

然后把这个思路转换迭代的方式就成了：

```c++
vector<string> letterCombinations(string digits) {
    static vector<string> sMap {"","","abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"};
    vector<string> ret;
    if (digits.size() == 0) return ret;
    ret.push_back("");
    for(int i = 0;i < digits.size();i++) {
        vector<string> now;
        for(auto c:sMap[digits[i] - '0']) {
            for(auto s:ret)
                now.push_back(s+c);
        }
        ret.swap(now);
    }
    return ret;
}
```

思路很简单，实现起来也很简单，没什么好提的，而且`dicuss`中的思路也很这个差不多，不过还是总结一下吧：

* c++ 中 `char`转`string`真心麻烦:
  * 用`stringstream`很优雅，但是也很麻烦，而且只适用于要平凡从尾部插入的情况,不过这个方法结合io可以做很多漂亮的转换
  * 用`"" + c`,之前的时候用的时候好像是可以的，但是刚才在做题的时候是不行的会出现一些奇怪的字符串。
  * 最后是比较简单，可以常用的方法：`string(1,c)`,可以把`1`换成其他数字以获取有重复字符的字符串。

* 然后是在`dicuss`中看到的`vector`的`swap`方法，有些情况应该还是不错的，可以提高效率，它应该是直接交换底层指针。