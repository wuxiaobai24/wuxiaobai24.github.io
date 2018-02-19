---
title: Verify-Preorder-Serialization-of-a-Binary-Tree
date: 2018-02-19 11:54:41
tags:
- LeetCode
---

第104天。

今天的题目是[331. Verify Preorder Serialization of a Binary Tree](https://leetcode.com/problems/verify-preorder-serialization-of-a-binary-tree/description/):

> One way to serialize a binary tree is to use pre-order traversal. When we encounter a non-null node, we record the node's value. If it is a null node, we record using a sentinel value such as #.


     _9_
    /   \
   3     2
  / \   / \
 4   1  #  6
/ \ / \   / \
# # # #   # #

> For example, the above binary tree can be serialized to the string "9,3,4,#,#,1,#,#,2,#,6,#,#", where # represents a null node.
>
> Given a string of comma separated values, verify whether it is a correct preorder traversal serialization of a binary tree. Find an algorithm without reconstructing the tree.
>
> Each comma separated value in the string must be either an integer or a character '#' representing null pointer.
>
> You may assume that the input format is always valid, for example it could never contain two consecutive commas such as "1,,3".
>
> Example 1:
> "9,3,4,#,#,1,#,#,2,#,6,#,#"
> Return true
>
> Example 2:
> "1,#"
> Return false
>
> Example 3:
> "9,#,#,1"
> Return false

虽然题目很长，但是理解起来并不难，就是给你一串字符串表示一棵二叉树，用`,`分隔节点的值，用`#`表示空指针，然后问你这个字符串能不能还原出来一棵二叉树（在不建树的情况下）,其实和建树很像，都是递归的去做：

```c++
bool isValidSerialization(string preorder) {
    int beg = 0;
    return isValidSerialization(preorder,beg) && !next(preorder, beg);
}
bool isValidSerialization(string preorder, int &beg) {
    if (beg >= preorder.size()) return false;
    if (preorder[beg] == '#') return true;
    return next(preorder, beg) && isValidSerialization(preorder, beg) &&
        next(preorder, beg) && isValidSerialization(preorder, beg);
}
bool next(string &preorder, int &beg) {
    while(beg < preorder.size() && preorder[beg] != ',') beg++;
    beg++;
    return beg < preorder.size();
}
```

然后是`dicuss`中的迭代版本：

```c++
bool isValidSerialization(string preorder) {
    if (preorder.empty()) return false;
    preorder+=',';
    int sz=preorder.size(),idx=0;
    int capacity=1;
    for (idx=0;idx<sz;idx++){
        if (preorder[idx]!=',') continue;
        capacity--;
        if (capacity<0) return false;
        if (preorder[idx-1]!='#') capacity+=2;
    }
    return capacity==0;
}
```