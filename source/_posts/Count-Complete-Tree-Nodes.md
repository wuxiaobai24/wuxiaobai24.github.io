---
title: Count Complete Tree Nodes
date: 2018-03-03 13:38:01
tags:
- LeetCode
---

题目是[Count Complete Tree Nodes](https://leetcode.com/problems/count-complete-tree-nodes/description/):

题目描述：

Given a complete binary tree, count the number of nodes.

Definition of a complete binary tree from Wikipedia:
In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

求解思路：

一开始想的是想法是，我们把最后一层的个数计算出来就简单很多了，所以我们可以先计算树的高度，然后用二分查找算出层数，虽然能过，但是很慢很慢（为什么我算出来的时间复杂度是`O(lgn*lgn)`啊。


```cpp
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */

class Solution {
public:
    int countNodes(TreeNode *root) {
        if (root == nullptr) return 0;

        int height = 0;
        TreeNode *p = root;
        while(p) {
            p = p->left; height++;
        }
        cout << height << endl;

        int low = 0;
        int high = pow(2, height - 1);
        int count = high;
        int h, mid, t, m;

        int mask = 1 << (height - 2);

        while(low < high) {
            mid = (low + high)/2;
            /* cout << low <<" "
                << mid << " "
                << high << endl; */

            p = root; h = height; t = mid;
            m = mask;
            while(p) {
                //cout << "#" << p->val << endl;
                if (t & m) p = p->right;
                else p = p->left;
                h--;
                m = m>>1;
            }
            // cout << h << endl;
            if (h == 0) low = mid + 1;
            else high = mid;
        }
        cout << count << endl;
        cout << low << endl;

        return count + low - 1;
    }
};
```

然后就想着不要那么复杂，我们先看左子树是不是满二叉树，如果不是，我们就可以通过左子树的高度来求右子树的节点个数了，但是这样方法在`c++`上是跑不过去的，但是在`python`中很快，很奇怪的是同样的测例，`c++`的版本要`400ms`左右，但是`python`的版本只要`40ms`左右，而且这个做法在`python`中还是比较快的：

```python3
class Solution:
    def countNodes(self, root):
        """
        :type root: TreeNode
        :rtype: int
        """
        if root is None:
            return 0
        h, count, iffull = self.countNodesHelper(root)
        return count

    def countNodesHelper(self, root):
        if root is None:
            return 0, 0, True
        left_h, left_count, left_full = self.countNodesHelper(root.left)
        if not left_full:
            # print('not full')
            return left_h + 1, left_count + 2**(left_h - 1), False

        right_h, right_count, right_full = self.countNodesHelper(root.right)
        # print(left_count + right_count + 1)
        return left_h+1, left_count + right_count + 1, left_full and right_full and left_h == right_h
```

最后看一下`dicuss`中的解法，想法和我第二个解法有点类似，但是更简洁，应该也更快：

```c++
int countNodes(TreeNode* root) {

    if(!root) return 0;

    int hl=0, hr=0;

    TreeNode *l=root, *r=root;

    while(l) {hl++;l=l->left;}

    while(r) {hr++;r=r->right;}

    if(hl==hr) return pow(2,hl)-1;

    return 1+countNodes(root->left)+countNodes(root->right);

}
```