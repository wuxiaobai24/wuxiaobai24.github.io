---
title: Binary-Tree-Right-Side-View
date: 2017-12-02 09:32:23
categories: LeetCode
tags:
- LeetCode
- Tree
---

第66天。

今天的题目是[Binary Tree Right Side View](https://leetcode.com/problems/binary-tree-right-side-view/discuss/):

> Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
>
> For example:
> Given the following binary tree,

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---

> You should return [1, 3, 4].

挺有趣的题目。

简单的来讲，首先，我们肯定是要让右子树优先，然后还要保证在左子树比右子树高的情况下，它的节点也能被放到要返回的数组中。

要比较高度，我们就需要在遍历的时候带上一个`height`,然后我们从按右子树优先进行先序遍历，这样就可以保证上面两个条件满足了，那，现在就是要计算什么时候将节点加入数组了。

我们可以发现返回的数组的大小和树的高度是相同的，这样我们就可以通过当前节点的高度来决定是否要将值加入数组，又因为我们遍历的时候已经是右子树优先了，所以第一次遇到这个高度的节点的时候，我们就可以直接将其放入数组中。

```c++
vector<int> rightSideView1(TreeNode* root) {
    vector<int> ret;
    helper(root,0,ret);
    return ret;
}
void helper(TreeNode *root,int height,vector<int> &ret) {
    if (root == nullptr) return ;
    if (height == ret.size()) ret.push_back(root->val);
    helper(root->right,height + 1,ret);
    helper(root->left,height+1,ret);
}
```

然后是`dicuss`中用层次遍历做的:

```java
public List<Integer> rightSideView(TreeNode root) {
    // reverse level traversal
    List<Integer> result = new ArrayList();
    Queue<TreeNode> queue = new LinkedList();
    if (root == null) return result;

    queue.offer(root);
    while (queue.size() != 0) {
        int size = queue.size();
        for (int i=0; i<size; i++) {
            TreeNode cur = queue.poll();
            if (i == 0) result.add(cur.val);
            if (cur.right != null) queue.offer(cur.right);
            if (cur.left != null) queue.offer(cur.left);
        }

    }
    return result;
}
```