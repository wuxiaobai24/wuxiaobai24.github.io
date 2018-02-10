---
title: 4Sum_2
date: 2017-10-04 10:59:17
categories: LeetCode
tags:
- LeetCode
---

打卡,第11天。

今天刷的题是[4Sum II](https://leetcode.com/problems/4sum-ii/description/),

> Given four lists A, B, C, D of integer values, compute how many tuples (i, j, k, l) there are such that A[i] + B[j] + C[k] + D[l] is zero.
>
>To make problem a bit easier, all A, B, C, D have same length of N where 0 ≤ N ≤ 500. All integers are in the range of -2^28 to 2^28 - 1 and the result is guaranteed to be at most 2^31 - 1.
>
> Example:
>
> Input:A = [ 1, 2]
> B = [-2,-1]
> C = [-1, 2]
> D = [ 0, 2]
> Output:
> 2
> 
> Explanation:
>
> The two tuples are:
>
> (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
>
> (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0

这道题如果贼容易写出一个时间超限的题目，比如简单的四重循环。

一开始老是会出现时间超限的情况，想着要把时间复杂度将下来，就想着把他转换成2Sum去做，于是就用就先把`A`和`B`的和放在一个`vector`中，同理也把`C`和`D`的和放在一个`vector`中。天真的以为这样就可以把时间复杂度降下来了。。。然而这两个vector的大小分别是`A.size()*B.size()`和`C.size()*D.size()`,然后一直没想出来怎么搞，突然想起来昨天在《像程序员一样思考》中看到的**削减问题**的方法，就开始考虑两个数组的的情况。

显然如果不对数组进行排序的话，肯定是要用两个循环对所有元素遍历的，然后就考虑如果数组是排好序的话，要怎么才能减少一些不必要的遍历，如果一个较小的数一定需要一个较大的数才能使得和为0，所以一个数组从前向后遍历，一个数组从后向前进行遍历。因为数组已经有序了，所以第一个数组越前面的元素（越小）就需要第二个数组越后面的的元素（越大），可以找到一下规律：

- sum > 0 -> j--
- sum < 0 -> i++
- sum == 0 -> count++;j--,i++

当然如果直接这样写的话可能会漏掉一些重复元素，所以还需要一些修改,但是大体的思路已经出来了，所以直接上代码把：

```c++
int fourSumCount(vector<int>& A, vector<int>& B, vector<int>& C, vector<int>& D) {
    int count = 0;
    vector<int> v1 (A.size()*B.size() ), v2(C.size()*D.size());
    int k = 0;
    for(auto c:C)
        for(auto d:D)
            v2[k++] = c+d;
    k = 0;
    for(auto a:A)
        for(auto b:B)
            v1[k++] = a+b;
    sort(v1.begin(),v1.end());
    sort(v2.begin(),v2.end());
    int i = 0,j = v2.size() - 1;
    int sum;
    while(i < v1.size() && j >= 0){
        sum = v1[i] + v2[j];
        if (sum > 0)
            j--;
        else if (sum < 0)
            i++;
        else {
            int k1 = 1,k2 = 1;
            //处理重复元素的情况
            while(i + 1< v1.size() && v1[i + 1 ] == v1[i]){ k1++; i++; }
            while(j > 0 && v2[j-1] == v2[j]) { k2++; j--; }
            i++;
            j--;
            count += k1*k2;
        }
    }
    return count;
}
```

然后是看看`dicuss`中别人的解法：

```c++
 int fourSumCount(vector<int>& A, vector<int>& B, vector<int>& C, vector<int>& D) {
    unordered_map<int, int>  abSum;
    for(auto a : A) {
        for(auto b : B) {
            ++abSum[a+b];
        }
    }
    int count = 0;
    for(auto c : C) {
        for(auto d : D) {
            auto it = abSum.find(0 - c - d);
            if(it != abSum.end()) {
                count += it->second;
            }
        }
    }
    return count;
}
```

他使用`unordered_map`来完成的耶,在c++的STL中，`map`是用的红黑树，`find`的时间复杂度是`O(nlogn)`,而`unordered_map`是`hash table`,所以`find`的时间复杂度是`O(1)`，突然发现一个好用的东西。。。

---
貌似今天是中秋，恩，中秋快乐！！

可惜喉咙发炎没法吃月饼。。。