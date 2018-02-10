---
title: Lexicographical-Number
date: 2017-12-09 10:39:01
categories: LeetCode
tags:
- LeetCode
---

第73天。

今天的题目是[Lexicographical Numbers](https://leetcode.com/problems/lexicographical-numbers/discuss/):

> Given an integer n, return 1 - n in lexicographical order.
>
> For example, given 13, return: [1,10,11,12,13,2,3,4,5,6,7,8,9].
>
> Please optimize your algorithm to use less time and space. The input size may be as large as 5,000,000.

emmm，`lexicographical`是字典序的意思。

首先，这种有规律的题目一般用递归来写会比较简单（但是可能会超时），我们先找出它的规律，在不到`n`的时候，没加入一个数字i,我们就要看`i*10 ~ i*10 + 9`是否小于`n`,如果小于我们就把它加入，然后在递归的进行判断。

有一点需要注意的就是，它是从`1`开始的，所以我们一开始就要尝试的把`1 ~ 9`加入，而不是`0 ~ 9`：

```c++
vector<int> lexicalOrder(int n) {
    vector<int> ret;
    //lexicalOrder(ret,n,1);
    for(int i = 1;i < 10 && i <= n;i++) {
        ret.push_back(i);
        lexicalOrder(ret,n,i*10);
    }
    return ret;
}
void lexicalOrder(vector<int> &vec,int n,int base) {
    for(int i = 0;i < 10;i++,base++) {
        if (base > n){ return; }
        vec.push_back(base);
        lexicalOrder(vec,n,10*base);
    }
}
```

然后是在`dicuss`中看到的迭代解法：

```c++
vector<int> lexicalOrder(int n) {
    vector<int> res(n);
    int cur = 1;
    for (int i = 0; i < n; i++) {
        res[i] = cur;
        if (cur * 10 <= n) {
            cur *= 10;
        } else {
            if (cur >= n) 
                cur /= 10;
            cur += 1;
            while (cur % 10 == 0)
                cur /= 10;
        }
    }
    return res;
}
```