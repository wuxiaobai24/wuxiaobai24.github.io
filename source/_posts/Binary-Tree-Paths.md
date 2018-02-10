---
title: Binary-Tree-Paths
date: 2018-01-20 10:24:03
categories: LeetCode
tags:
- LeetCode
---

第89天。

今天的题目是[Binary-Tree-Paths](https://leetcode.com/problems/binary-tree-paths/description/):

> Given a binary tree, return all root-to-leaf paths.
>
> For example, given the following binary tree:
>
   1
 /   \
2     3
 \
  5
> All root-to-leaf paths are:
>
> ["1->2->5", "1->3"]

比较的简单的题目，直接用递归做就好了，因为`python`写起来比较简单，所以这里用`python`实现：

```python
def binaryTreePaths(self, root):
    """
    :type root: TreeNode
    :rtype: List[str]
    """
    self.ret = []
    if root is None:
        return self.ret
    s = []
    self.binaryTreePathsRec(root,s)
    return self.ret


def binaryTreePathsRec(self,root,s):
    if root is None:
        return
    s.append(str(root.val))
    if root.left is None and root.right is None:
        self.ret.append('->'.join(s))
    else:
        self.binaryTreePathsRec(root.left,s)
        self.binaryTreePathsRec(root.right,s)
    s.pop()
```