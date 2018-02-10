---
title: Generate Parentheses
date: 2017-10-08 11:16:45
categories: LeetCode
tags:
- LeetCode
---

打卡，第15天

今天做了一道比较好玩的题，之前有做个一个括号匹配的题目，今天的题目刚好反过来，不是验证括号是否正确，而是生成正确括号——[Generate Parentheses](https://leetcode.com/problems/generate-parentheses/description/).

题目描述：

> Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
> 
> For example, given n = 3, a solution set is:

```python
[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]
```


再看看`n = 2`时：

```python
[
    "(())",
    "()()",
]
```


我们观察上面的例子，可以发现n=3,其实是由n=2加上一个`()`组合起来的，可以分成三种情况：

* 在前面加上`()`,
* 在后面加上`()`,
* 在前面加上`(`后面加上`)`

我们大概可以写出这样的代码：

```c++
vector<string> generateParenthesis1(int n) {
    if (n == 1) return {"()"};
    set<string> ret;

    vector<string> r = generateParenthesis(n-1);
    for(auto s:r){
        ret.insert(s+"()");
        ret.insert("()" + s);
        ret.insert("(" + s + ")");
    }

    return {ret.begin(),ret.end()};
}
```

这样在`n <= 3`时是ok的，但是如果`n = 4`还有一种可能，就是`(())(())`,这时由两个`n=2`的括号组合而成的，以及`n = 5`时，可以由`n = 3`和`n = 2`组合而成，也可以由`n = 1`和`n = 4`组合而成。

故我们可以做以下改进，得到正确答案：

```c++
vector<string> generateParenthesis1(int n) {
    if (n == 1) return {"()"};
    set<string> ret;

    vector<string> r = generateParenthesis(n-1);
    for(auto s:r){
        ret.insert(s+"()");
        ret.insert("()" + s);
        ret.insert("(" + s + ")");
    }

    for(int i = n/2;i > 1;i--) {
        vector<string> r1 = generateParenthesis(n - i);
        vector<string> r2 = generateParenthesis(i);
        for(auto s1:r1)
            for(auto s2:r2) {
                ret.insert(s1+s2);
                ret.insert(s2+s1);
            }
    }

    return {ret.begin(),ret.end()};
}
```

可以发现，这里出现了很多次重复计算，可以用动态规划去做：

```c++
vector<string> generateParenthesis(int n) {
    vector<vector<string> > par{
        {""}
    };

    for(int i = 1;i <= n;i++) {
        set<string> now;
        for(auto s:par[i-1]) {
            now.insert(s + "()");
            now.insert("()" + s);
            now.insert("(" + s + ")");
        }
        int l = 1;
        int r = i - l;
        while(r >= l) {
            //cout << l << " " << r << endl;
            for(auto s1:par[l])
                for(auto s2:par[r]){
                    //cout << s1 << " " << s2 << endl;
                    now.insert(s1+s2);
                    now.insert(s2+s1);
                }
            l++;
            r--;
        }
        par.push_back({now.begin(),now.end()});
    }
    return par[n];
}
```

然后是在`discuss`中看到的另一种思路：

```c++
vector<string> result;
vector<string> generateParenthesis(int n) {
    helper("", n, 0);
    return result;
}

/*  this hepler function insert result strings to "vector<string> result"
    When number of '(' less than "n", can append '(';
    When number of '(' is more than number of ')', can append ')';

    string s : current string;
    int leftpare_need : number of '(' that have not put into "string s";
    int moreleft : number of '(' minus number of ')' in the "string s";
*/

void helper(string s, int leftpare_need, int moreleft)
{
    if(leftpare_need == 0 && moreleft == 0)
    {
        result.push_back(s);
        return;
    }
    if(leftpare_need > 0)
        helper(s + "(", leftpare_need - 1, moreleft+1);
    if(moreleft > 0)
        helper(s + ")", leftpare_need, moreleft - 1);
}
```

这个的想法是，不断的生成左括号，有左括号，后面就一定会生成一个右括号。