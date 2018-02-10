---
title: Product of Array Except Self
date: 2017-11-08 22:55:58
categories: LeetCode
tags:
- LeetCode
---

第43天。

今天的题目是[Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/description/):

> Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
>
> Solve it without division and in O(n).
>
> For example, given [1,2,3,4], return [24,12,8,6].
>
> Follow up:
> Could you solve it with constant space complexity? (Note: The output array does not count as extra space for the purpose of space complexity analysis.)


这里说不能使用除法，我的想法就是自己实现一个除法:

```c++
int Div(unsigned  a,unsigned b) {
    int x,y;
    int ans = 0;
    while(a >= b) {
        x = b;
        y = 1;
        while( a >= (x<<1)) {
            x <<= 1;
            y <<= 1;
        }
        a -= x;
        ans += y;
    }
    return ans;
}
int div(int a,int b) {
    if (a > 0 && b > 0) return Div(a,b);
    else if (a < 0 && b < 0) return Div(-a,-b);
    else if (a < 0) return -Div(-a,b);
    else return -Div(a,-b);
}
```

然后剩下的东西就是将`0`这个特例排除掉了：

```c++
vector<int> productExceptSelf(vector<int>& nums) {
    vector<int> ret(nums.size(),0);
    long long product = 1;
    int zero_count = 0;
    for(auto i:nums)
        if (i != 0) product*=i;
        else zero_count++;
    cout << zero_count << endl;

    if (zero_count > 1) return ret;

    if (zero_count == 1) {
        for(int i = 0;i < nums.size();i++) {
            if (nums[i] != 0) ret[i] = 0;
            else ret[i] = product;
        }
        return ret;
    }

    for(int i = 0;i < ret.size();i++) {
    //    if (nums[i] == 0) ret[i] = product[i];
        ret[i] = div((int)product,nums[i]);
    }
    return ret;
}
```

但是看了`dicuss`的做法，我感觉的理解是错的：

```python
def productExceptSelf(self, nums):
        p = 1
        n = len(nums)
        output = []
        for i in range(0,n):
            output.append(p)
            p = p * nums[i]
        p = 1
        for i in range(n-1,-1,-1):
            output[i] = output[i] * p
            p = p * nums[i]
        return output
```

恩，今天写的有点急，因为我周五安全导论还要考试，然而我还一堆东西不会。。。