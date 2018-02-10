---
title: House-Robber-III
date: 2017-11-26 09:08:22
categories: LeetCode
tags:
- LeetCode
- Tree
---

第60天。

今天的题目是[House Robber III](https://leetcode.com/problems/house-robber-iii/description/)：

> The thief has found himself a new place for his thievery again. There is only one entrance to this area, called the "root." Besides the root, each house has one and only one parent house. After a tour, the smart thief realized that "all houses in this place forms a binary tree". It will automatically contact the police if two directly-linked houses were broken into on the same night.
>
> Determine the maximum amount of money the thief can rob tonight without alerting the police.
>
> Example 1:

     3
    / \
   2   3
    \   \
     3   1

> Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
> Example 2:

     3
    / \
   4   5
  / \   \
 1   3   1

> Maximum amount of money the thief can rob = 4 + 5 = 9.

之前有刷过`House robber`,上次是一道`dp`的题目，这次看起来有点像是`dp`的题目，但是其实不是。

我们考虑当前节点`root`,我们有两种选择：

- 不偷`root`:这意味着我们对`root`的孩子没有限制（即可以偷也可以不偷）。
- 偷`root`：这意味着我们不能偷`root`的孩子。

从上面的分析可以看出，对于一个节点，我们可能需要返回两个值，一个是偷了`root`所得到的`money`,一个是不偷`root`所得到的`money`.我们可以用一个结构体来表示:

```c++
typedef struct {
    int rob;
    int norob;
}Ret;
```

假设我们现在得到了`root`左孩子和右孩子的`Ret`了，我们现在要构建`root`本身的`Ret`.显然`rob = left.norob + right.norob + root->val`.然后还有`norob`,这个很容易就写成`norob = left.rob + right.rob`,这样写就假定了`rob > norob`的，在上面的分析中，我们是说我们对`root`的孩子没有限制，既然没有限制，就可以偷也可以不偷，所以`norob = max(left.rob,left.norob) + max(right.rob,right.norob)`.

```c++
int rob(TreeNode* root) {
    Ret ret = robRec(root);
    return max(ret.rob,ret.norob);
}
Ret robRec(TreeNode *root) {
    Ret ret = {0,0};
    if (root == nullptr) return ret;
    Ret left = robRec(root->left);
    Ret right = robRec(root->right);
    ret.rob = left.norob + right.norob + root->val;
    ret.norob = max(left.rob,left.norob) + max(right.rob,right.norob);
    return ret;
}
```

`dicuss`中的解法大都是这个思路，只是写法不同而已，有一个写法比较有趣：

```java
public int rob(TreeNode root) {
    if (root == null) return 0;
    return Math.max(robInclude(root), robExclude(root));
}

public int robInclude(TreeNode node) {
    if(node == null) return 0;
    return robExclude(node.left) + robExclude(node.right) + node.val;
}

public int robExclude(TreeNode node) {
    if(node == null) return 0;
    return rob(node.left) + rob(node.right);
}
```