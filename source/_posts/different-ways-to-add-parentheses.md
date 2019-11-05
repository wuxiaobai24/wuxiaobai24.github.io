---
title: Different Ways to Add Parentheses
date: 2017-09-20 12:00:00
categories: LeetCode
tags:
- LeetCode
---

#  Different Ways to Add Parentheses 

> 开始每天坚持刷OJ和Paper吧。

今天的题目是[ Different Ways to Add Parentheses ]( https://leetcode.com/problems/different-ways-to-add-parentheses/):

Given a string of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. The valid operators are `+`, `-` and `*`.

**Example 1:**

```
Input: "2-1-1"
Output: [0, 2]
Explanation: 
((2-1)-1) = 0 
(2-(1-1)) = 2
```

**Example 2:**

```
Input: "2*3-4*5"
Output: [-34, -14, -10, -10, 10]
Explanation: 
(2*(3-(4*5))) = -34 
((2*3)-(4*5)) = -14 
((2*(3-4))*5) = -10 
(2*((3-4)*5)) = -10 
(((2*3)-4)*5) = 10
```

太久没刷过题的后果就是之前掌握的一些解题思路好像有点生疏了，但还是勉强完成了这道题，首先从两个Example开始分析，第一个太简单好像看不出什么，我们分析一下第二个，我们可以看到，`(2*(3-(4*5))) = -34`是先算第二个`*`，然后再算`-`，最后算第一个`*`。大概可以猜出来我们需要穷举所有运算顺序，但应该不是全排列，因为当运算符个数为3时，他的运算顺序只有5个，而不是6个。仔细分析一下可以发现，这是因为已下两种算法是一样的：

1. 先算第一个，再算第三个，最后算第二个
2. 先算第三个，再算第一个，最后算第二个

这就有点像一个二叉树了，层数相同的情况。我们尝试把上面五种运行顺序用二叉树表示出来，首先，分别用`1`,`2`,`3`代替`*`,`-`,`*`:

```
1
 \
  2
    \
     3
```


```
    2
  /   \
 1     3
```

```
  1
   \
    3
   /
  2
```

```
   1
  /
 3
  \
   2
```

```
     3
    /     
   2
  /
 1
```

画出来后，我们很容易的发现，这个问题变成了对平衡二叉树的穷举问题，因此代码如下：

```c++
vector<int> nums;
vector<char> ops;
vector<int> diffWaysToCompute(string input) {
    vector<int> res;

    int num; char op;
    stringstream ss(input);

    ss >> num;
    nums.push_back(num);
    while(ss >> op >> num) {
        nums.push_back(num);
        ops.push_back(op);
    }

    helper(0, ops.size(), res);
    return res;
}

int calc(char op, int i1, int i2) {
    int res = 0;
    switch(op) {
        case '+': res = i1 + i2; break;
        case '-': res = i1 - i2; break;
        case '*': res = i1 * i2; break;
    }
    return res;
}

void helper(int first, int last, vector<int> &outputs) {
    if (first == last) {
        outputs.push_back(nums[first]);
        return ;
    }

    vector<int> lefts;
    vector<int> rights;

    for(int i = first; i < last;i++) {
        // select ops[i] in this layer
        lefts.clear();
        rights.clear();

        helper(first, i, lefts);
        helper(i+1, last, rights);

        for(auto l: lefts) {
            for(auto r: rights) {
                outputs.push_back(calc(ops[i], l, r));
            }
        }
    }

}
```

由于`stringstream`的效率的确不行，所以我们可以尝试将解析字符串的那段代码改成：

```c++
int beg = 0, end = 0;
for(;end < input.size(); end++) {
    if (input[end] == '+' || input[end] == '-' || input[end] == '*') {
        nums.push_back(stoi(input.substr(beg, end - beg)));
        ops.push_back(input[end]);
        beg = end + 1;
    }
}
nums.push_back(stoi(input.substr(beg, end - beg)));
```

