---
title: Binary Search Tree Iterator
date: 2020-03-31 10:55:25
tags:
- LeetCode
- Stack
- Tree
- Design
categories: LeetCode
---

> 貌似又是一道之前做了，但是没写题解的题目。

今天的题目是[Binary Search Tree Iterator](https://leetcode-cn.com/problems/binary-search-tree-iterator/)。

这道题要求我们按从小到大的顺序返回二叉搜索树的值，而我们知道二叉搜索树的中序遍历就是从小到大的，所以问题就变成了，对一个二叉树的中序遍历问题。

因为之前总结过[二叉树遍历](https://blog.codeand.fun/2020/03/24/Binary-Tree-Preorder-Inorder-Postorder-Traversal/)，所以这里我们可以套用当时提到的三种方法来解这道题：

## 递归

由于题目只要求了`next()`和`hasNext()`的时间复杂度，所以我们可以在构造器中对二叉树进行遍历，然后存储下来：

```cpp
class BSTIterator {
public:
    vector<int> vec;
    int index;
    BSTIterator(TreeNode* root) {
        index = 0;
        inorderTraversal(root);
    }

    void inorderTraversal(TreeNode *root) {
        if (root) {
            inorderTraversal(root->left);
            vec.push_back(root->val);
            inorderTraversal(root->right);
        }
    }
    
    /** @return the next smallest number */
    int next() {
        return vec[index++];
    }
    
    /** @return whether we have a next smallest number */
    bool hasNext() {
        return index != vec.size();
    }
};
```

这样`next()`和`hasNext()`的时间复杂度肯定是`O(1)`的，但是空间复杂度却是`O(n)`，而题目要求的是`O(h)`。

## 基于栈进行迭代。

基于栈对二叉树进行迭代的中序遍历大体可以分为两部：

1. 不断地把先左节点移动，并把节点压入栈中（以下简称 step 1)。
2. 弹出栈顶节点，并输出，然后先右节点方向移动（以下简称 step 2)。

一旦做完以上两步，我们就输出了一个值。

因为当时是在一个循环中实现的，所以和现在的情况是不一样的，`root`是在构造器中输入的，所以我们得在构造器中就把`root`压入栈中，为了不把过程弄的复杂，所以我们在构造器中就直接把 step 1 给做完，然后在`next()`中把两步的顺序倒过来，即先执行 step 2 然后执行 step 1，当然 step 2 中的输出操作显然要放到最后来做。因为在两个地方都进行了 step 1，所以我们可以把它抽象成一个单独的函数`pushleft`：

```c++
class BSTIterator {
public:
    stack<TreeNode *> st;
    BSTIterator(TreeNode* root) {
        pushleft(root);
    }
    
    void pushleft(TreeNode *root) {
        while(root) {
            st.push(root);
            root = root->left;
        }
    }

    /** @return the next smallest number */
    int next() {
        auto root = st.top(); st.pop();
        pushleft(root->right);
        return root->val;
    }
    
    /** @return whether we have a next smallest number */
    bool hasNext() {
        return !st.empty();
    }
};
```

因为基于栈的遍历算法的空间复杂度是`O(h)`，所以上面这个算法的空间复杂度也是`O(h)`（其实也很好理解，因为栈要临时存放节点个数最大就是 h），然后`hasNext()`的时间复杂度显然也是`O(1)`。下面的问题就是，`next()`的时间复杂度是否是`O(1)`。

如果我们仔细观察一下题目的话，我们会发现它要求的是平均时间复杂度，因为一颗有`n`个节点的树进行遍历，我们需要做`n`次`st.push`，同时`next()`我们也要调用`n`次才能遍历整棵树，所以`n / n = 1`，即平均时间复杂度为`O(1)`。

## 莫里斯遍历

我们先看下莫里斯遍历的代码：

```c++
TreeNode *GetRightLeaf(TreeNode *root, TreeNode *end) {
    while(root->right && root->right != end) root = root->right;
    return root;
}

void inorderTraversal(TreeNode* root) {
    while(root) {
        if (root->left) {
            TreeNode *p = GetRightLeaf(root->left, root);
            if (p->right == root) {
                p->right = nullptr;
                cout << root->val << endl;
                root = root->right;
            } else {
                p->right = root;
                root = root->left;
            }
        } else {
            cout << root->val << endl;
            root = root->right;
        }
    }
}
```

几乎可以什么都不用改的情况下，把代码移植过去：

```cpp
class BSTIterator {
public:
    TreeNode *root;
    TreeNode *GetRightLeaf(TreeNode *root, TreeNode *end) {
        while(root->right && root->right != end) root = root->right;
        return root;
    }

    BSTIterator(TreeNode* _root):root(_root) {

    }
    
    /** @return the next smallest number */
    int next() {
        int res = -1;
        while(root) {
            if (root->left) {
                TreeNode *p = GetRightLeaf(root->left, root);
                if (p->right == root) {
                    p->right = nullptr;
                    // cout << root->val << endl;
                    res = root->val;
                    root = root->right;
                    break;
                } else {
                    p->right = root;
                    root = root->left;
                }
            } else {
                // cout << root->val << endl;
                res = root->val;
                root = root->right;
                break;
            }
        }
        return res;
    }
    
    /** @return whether we have a next smallest number */
    bool hasNext() {
        return root != nullptr;
    }
};
```

这个的空间复杂度显然是`O(1)`，而时间复杂度，我们可以这样理解，每个节点都会被访问两遍，即`O(2n)`，而`next()`要调用 n 次，所以时间复杂度是`O(2n / 2) = O(2) = O(1)`。
