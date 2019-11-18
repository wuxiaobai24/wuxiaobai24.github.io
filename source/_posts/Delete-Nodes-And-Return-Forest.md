---
title: Delete Nodes And Return Forest
date: 2019-11-18 10:07:28
tags:
- LeetCode
categories:
- LeetCode
---

> 第14天。

今天的题目是[Delete Nodes And Return Forest](https://leetcode.com/problems/delete-nodes-and-return-forest/)：

---

Given the `root` of a binary tree, each node in the tree has a distinct value.

After deleting all nodes with a value in `to_delete`, we are left with a forest (a disjoint union of trees).

Return the roots of the trees in the remaining forest. You may return the result in any order.

 

**Example 1:**

**![img](https://assets.leetcode.com/uploads/2019/07/01/screen-shot-2019-07-01-at-53836-pm.png)**

```
Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
Output: [[1,2,null,4],[6],[7]]
```

 

**Constraints:**

- The number of nodes in the given tree is at most `1000`.
- Each node has a distinct value between `1` and `1000`.
- `to_delete.length <= 1000`
- `to_delete` contains distinct values between `1` and `1000`.

---

这道题的题意很简单，就是要通过删节点来把分割树，关键的问题是，删除一个节点既需要对子节点进行处理，还要在父节点中删除对应的指针，为了方便，我们这里采用后续遍历的方法来实现：

先递归调用函数，使得子树中的节点已经完成遍历和删除，然后通过返回值来判断该子节点是否需要删除，如果需要删除，则将对于的指针置空。然后在判断当前节点是否需要删除，就将非空的子节点插入到返回数组中（全局变量）。

还有一点就是，因为节点的值在`1-1000`间，所以我们可以用一个长度为1000的数组来加快对要删除节点的判断。

代码如下：

```c++
vector<TreeNode *> res;
vector<TreeNode*> delNodes(TreeNode* root, vector<int>& to_delete) {
    if (root == nullptr) return res;

    vector<bool> delmap(1001, false);
    for(int i = 0;i < to_delete.size(); i++) {
        delmap[to_delete[i]] = true;
    }

    if (!toDelNodes(root, delmap)) {
        res.push_back(root);
    }

    return res;
}

bool toDelNodes(TreeNode *root, vector<bool>& delmap) {
    if (root == nullptr) return false;

    if (toDelNodes(root->left, delmap)) {
        root->left = nullptr;
    }
    if (toDelNodes(root->right, delmap)) {
        root->right = nullptr;
    }

    if (delmap[root->val]) {
        if (root->left) res.push_back(root->left);
        if (root->right) res.push_back(root->right);
        return true;
    }
    return false;        
}
```

