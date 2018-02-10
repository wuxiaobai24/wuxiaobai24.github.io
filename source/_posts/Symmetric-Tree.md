---
title: Symmetric Tree
date: 2017-11-14 10:49:31
categories: LeetCode
tags:
- LeetCode
- Tree
---

第48天。

今天的题目是[Symmetric Tree](https://leetcode.com/problems/symmetric-tree/description/):

> Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).
>
> For example, this binary tree [1,2,2,3,4,4,3] is symmetric:

```python
    1
   / \
  2   2
 / \ / \
3  4 4  3
```

> But the following [1,2,2,null,3,null,3] is not:

```python
    1
   / \
  2   2
   \   \
   3    3
```

刚看的时候还有点懵，要怎么递归的去求解这种问题呢，要比较的两个节点隔得有点远啊。后来是上课时突然想到对称其实和根节点的左子树和右子树有关，我们把他当成两个树来求解就好了，递归时需要两个`TreeNode`:

```python
def isSymmetric1(self, root):
    """
    :type root: TreeNode
    :rtype: bool
    """
    if root is None:
        return True
    else:
        return self.isSymmetricRec(root.left,root.right)

def isSymmetricRec(self,left,right):
    """
    :type left: TreeNode
    :type right: TreeNode
    :rtype: bool
    """
    if left is None and right is None:
        return True
    elif left is not None and right is not None:
        return left.val == right.val \
                and self.isSymmetricRec(left.left,right.right) \
                and self.isSymmetricRec(left.right,right.left)
    else:
        return False
```

然后是迭代解，这里是用层次遍历去做的：

```python
def isSymmetricBFS(self,root):
    """
    :type root:TreeNode
    :rtype: bool
    """
    if root is None:
        return True

    leftqueue = Queue()
    rightqueue = Queue()

    leftqueue.put(root.left)
    rightqueue.put(root.right)

    while not leftqueue.empty():
        left = leftqueue.get()
        right = rightqueue.get()
        if left is None and right is None:
            continue
        elif left is not None and right is not None:
            if left.val != right.val:
                return False
            leftqueue.put(left.left)
            leftqueue.put(left.right)
            rightqueue.put(right.right)
            rightqueue.put(right.left)
        else:
            return False
    return True
```

然后是在`dicuss`中看到的`c++`解法，思路其实是一样的：

```c++
bool isSymmetric(TreeNode *root) {
    if (!root) return true;
    return helper(root->left, root->right);
}

bool helper(TreeNode* p, TreeNode* q) {
    if (!p && !q) {
        return true;
    } else if (!p || !q) {
        return false;
    }

    if (p->val != q->val) {
        return false;
    }

    return helper(p->left,q->right) && helper(p->right, q->left); 
}
```

```c++
bool isSymmetric(TreeNode *root) {
    TreeNode *left, *right;
    if (!root)
        return true;

    queue<TreeNode*> q1, q2;
    q1.push(root->left);
    q2.push(root->right);
    while (!q1.empty() && !q2.empty()){
        left = q1.front();
        q1.pop();
        right = q2.front();
        q2.pop();
        if (NULL == left && NULL == right)
            continue;
        if (NULL == left || NULL == right)
            return false;
        if (left->val != right->val)
            return false;
        q1.push(left->left);
        q1.push(left->right);
        q2.push(right->right);
        q2.push(right->left);
    }
    return true;
}
```