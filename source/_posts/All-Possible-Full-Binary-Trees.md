---
title: All Possible Full Binary Trees
date: 2019-11-22 13:54:54
tags:
- LeetCode
categories: LeetCode
---

> 第18天。

今天的题目是[ All Possible Full Binary Trees ]( https://leetcode.com/problems/all-possible-full-binary-trees/ ):

---

A *full binary tree* is a binary tree where each node has exactly 0 or 2 children.

Return a list of all possible full binary trees with `N` nodes. Each element of the answer is the root node of one possible tree.

Each `node` of each tree in the answer **must** have `node.val = 0`.

You may return the final list of trees in any order.

 

**Example 1:**

```
Input: 7
Output: [[0,0,0,null,null,0,0,null,null,0,0],[0,0,0,null,null,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,null,null,null,null,0,0],[0,0,0,0,0,null,null,0,0]]
Explanation:
```

 ![](https://s3-lc-upload.s3.amazonaws.com/uploads/2018/08/22/fivetrees.png)

**Note:**

- `1 <= N <= 20`

---

这道题就是一个穷举的问题，我们知道完全二叉树的节点个数一定是奇数，所以可以先把`N`为偶数的输入先处理掉，然后就是怎么穷举的问题了。显然，一个完全二叉树的子树一定也是完全二叉树，所以我们可以以`1,3,5...,N-2`的方式穷举出出左子树中节点的个数`i`，已知左子树节点个数，那么右子树节点的个数就为`N-i-1`,我们先把左子树和右子树的可能都算出来，然后就再计算它们两两组合的所有可能即可得到所有节点个数为`N`的完全二叉树的情况。总的来说，就是一个大问题化简成小问题的思路。所以我们可以写出如下代码：

```c++
TreeNode *copyTree(TreeNode *root) {
    if (root == nullptr) return nullptr;
    TreeNode *res = new TreeNode(0);
    res->left = copyTree(root->left);
    res->right = copyTree(root->right);
    return res;
}

vector<TreeNode*> allPossibleFBT(int N) {
    vector<TreeNode*> res;   
    if (N % 2 == 0) return res;

    vector<vector<TreeNode*>> dp(N+1);
    dp[1].push_back(new TreeNode(0));

    for(int i = 1;i < dp.size();i+=2) {
        // dp[i];
        for(int j = 1;j < i;j+=2) {
            vector<TreeNode*> &left = dp[j];
            vector<TreeNode*> &right = dp[(i-j-1)];
            for(auto &l: left) {
                for(auto &r: right) {
                    TreeNode *node = new TreeNode(0);
                    node->left = copyTree(l);
                    node->right = copyTree(r);
                    dp[i].push_back(node);        
                }
            }
        }
    }
    return dp[N];
}
```

然后你会发现好像可以用一个数组来存在已经求解出来的结果，如果再一次求，我们可以直接返回了：

```c++
vector<TreeNode*> &allPossibleFBT(int N, vector<vector<TreeNode*>> &cache) {
    if (cache[N].size() != 0) return cache[N];

    for(int i = 1;i < N;i++) {
        vector<TreeNode*> &left = allPossibleFBT(i, cache);
        vector<TreeNode*> &right = allPossibleFBT(N - i - 1, cache);
        for(auto l: left) {
            for(auto r: right) {
                TreeNode *node = new TreeNode(0);
                node->left = l;
                node->right = r;
                cache[N].push_back(node);
            }
        }
    }
    return cache[N];
}

vector<TreeNode*> allPossibleFBT(int N) {
    vector<TreeNode*> res;   
    if (N % 2 == 0) return {};
    vector<vector<TreeNode*>> cache(21);

    cache[1].push_back(new TreeNode(0));
    return allPossibleFBT(N, cache);
}
```

如果熟悉动态规划的话，就会发现可以自顶向下的求解方式转成自底向上的求解方式，这里我们就不需要用递归去求解：

```c++
vector<TreeNode*> allPossibleFBT(int N) {
    vector<TreeNode*> res;   
    if (N % 2 == 0) return res;

    vector<vector<TreeNode*>> dp(N+1);
    dp[1].push_back(new TreeNode(0));

    for(int i = 1;i < dp.size();i+=2) {
        // dp[i];
        for(int j = 1;j < i;j+=2) {
            for(auto l: dp[j]) {
                for(auto r: dp[i-j-1]) {
                    TreeNode *node = new TreeNode(0);
                    node->left = copyTree(l);
                    node->right = copyTree(r);
                    dp[i].push_back(node);        
                }
            }
        }
    }
    return dp[N];
}
```

最后，这份代码在`LeetCode`大概只能超过50%，如果要进一步，只有把`copyTree`去掉，直接赋值。这种方式是可行的，但是感觉只是在刷题时的一种技巧而已：

```c++
vector<TreeNode*> allPossibleFBT(int N) {
    vector<TreeNode*> res;   
    if (N % 2 == 0) return res;

    vector<vector<TreeNode*>> dp(N+1);
    dp[1].push_back(new TreeNode(0));

    for(int i = 1;i < dp.size();i+=2) {
        // dp[i];
        for(int j = 1;j < i;j+=2) {
            for(auto l: dp[j]) {
                for(auto r: dp[i-j-1]) {
                    TreeNode *node = new TreeNode(0);
                    node->left = l;//copyTree(l);
                    node->right = r;//copyTree(r);
                    dp[i].push_back(node);        
                }
            }
        }
    }
    return dp[N];
}
```

