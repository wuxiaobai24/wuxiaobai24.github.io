---
title: Unique Binary Search Tree
date: 2017-10-22 08:48:53
categories: LeetCode
tags:
- LeetCode
- 动态规划
---

第29天。

今天的题目是[Unique Binary Search Trees](https://leetcode.com/problems/unique-binary-search-trees/description/):

> Given n, how many structurally unique BST's (binary search trees) that store values 1...n?
>
> For example,
> Given n = 3, there are a total of 5 unique BST's.
>
>     1         3     3      2      1
>     \       /     /      / \      \
>     3     2     1      1   3      2
>     /     /       \                 \
>     2     1         2                 3

对于这种问题一般都可以用递归去做的，我们尝试的找一下递归式。

`n=1` -> `1`
`n=2` -> `2`
`n=3` -> `5`

我们考虑`n=3`时的情况,这时这棵树种包含三个值`1,2,3`,这说明树根的可能是`1,2,3`中的一个值：

* 当`root=1`时，`2,3`只能放在右子树。现在只考虑`2,3`两个值，由于`BST`的性质,右子树也必须是`BST`，则此时问题转换成求`numsTrees(2)`.
* 当`root=2`时，左边必定是`1`,右边必定是`3`.
* 当`root=3`时，左边必定是`1,2`，同样转换成`numsTrees(2)`.

我们再考虑一下`n=5`时的情况：

* `root=3`，左子树必定是是包含`1,2`的BST，右子树必定是包含`4,5`的BST，此时种类为`numsTree(5-3)*numsTrees(3-1)`。

所以我们可以找到递推式：

* `n < 2` -> `numsTrees(n) = 1`
* `n >= 2` -> `numsTrees(n) = numsTrees(1)*numsTrees(n-1) + numsTrees(2)*numTree(n-2) + ... + numsTree(n-1)*numsTrees(1)`;

所以我们写出一个递归的解决方案:

```c++
int numTrees(int n) {
    if (n <= 1) return 1;

    int ret = 0;
    for(int i = 1;i <= n;i++) {
        int left = i-1;
        int right = n-i;
        ret += numTrees(left)*numTrees(right);
    }
    return ret;
}
```

但是这里会超时，很明显这里可以用动态规划来优化:

```c++
int numTrees(int n) {
    vector<int> ret(n+1);
    ret[0] = 1;
    ret[1] = 1;
    for(int i = 2;i <= n;i++) {
        for(int j = 1;j <= i;j++)
            ret[i] += ret[j-1]*ret[i-j];
    }
    return ret[n];
}
```

`dicuss`中基本都是和上面类似的解法，除了一个:

```c++
int numTrees(int n) {
    //cantalan树
    //C(2n,n)/(n+1)
    long long ans =1;
    for(int i=n+1;i<=2*n;i++){
        ans = ans*i/(i-n);
    }
    return ans/(n+1);
}
```

emmm,说实话，我没看懂，但是这个方法的确是最快的，只需要`O(n)`的时间，`O(1)`的空间。