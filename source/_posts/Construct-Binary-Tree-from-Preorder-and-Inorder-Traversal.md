---
title: Construct Binary Tree from Preorder and Inorder Traversal
date: 2017-10-25 11:07:13
categories: LeetCode
tags:
- LeetCode
- Tree
---

第32天。

其实早在很久之前了就想着坚持了一个月之后要发票圈纪念一下的，后来想想其实也没啥必要的，感觉每天早上起来开电脑看题目已经成了习惯了，习惯有啥好纪念的（其实到100天的时候应该还是挺有意义的）。

今天的题目是[Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/)：

> Given preorder and inorder traversal of a tree, construct the binary tree.
>
> Note:
> You may assume that duplicates do not exist in the tree.

一开始没看到`Note`，还觉得会有点麻烦，不过既然没有重复元素，写出一个递归解法就很简单了:

```c++
TreeNode* buildTree1(vector<int>& preorder, vector<int>& inorder) {
    return bulidTreeIter(preorder.begin(),preorder.end(),inorder.begin(),inorder.end());
}
TreeNode *bulidTreeIter(vector<int>::iterator pBeg,vector<int>::iterator pEnd,vector<int>::iterator iBeg,vector<int>::iterator iEnd) {
    if (pEnd == pBeg) return nullptr;
    TreeNode *root = new TreeNode(*pBeg);
    auto it = find(iBeg,iEnd,*pBeg);
    int size = it - iBeg;
    root->left = bulidTreeIter(pBeg+1,pBeg + size + 1,iBeg,it);
    root->right = bulidTreeIter(pBeg+size+1,pEnd,it+1,iEnd);
    return root;
}
```

恩，貌似是第一次一次`Submit`就直接过。

然后是在`dicuss`中看到的迭代算法，但是感觉很复杂的样子,而且效率也不一定比递归版的高。

```c++
    TreeNode *buildTree(vector<int> &preorder, vector<int> &inorder) {

        if(preorder.size()==0)
            return NULL;

        stack<int> s;
        stack<TreeNode *> st;
        TreeNode *t,*r,*root;
        int i,j,f;

        f=i=j=0;
        s.push(preorder[i]);

        root = new TreeNode(preorder[i]);
        st.push(root);
        t = root;
        i++;

        while(i<preorder.size())
        {
            if(!st.empty() && st.top()->val==inorder[j])
            {
                t = st.top();
                st.pop();
                s.pop();
                f = 1;
                j++;
            }
            else
            {
                if(f==0)
                {
                    s.push(preorder[i]);
                    t -> left = new TreeNode(preorder[i]);
                    t = t -> left;
                    st.push(t);
                    i++;
                }
                else 
                {
                    f = 0;
                    s.push(preorder[i]);
                    t -> right = new TreeNode(preorder[i]);
                    t = t -> right;
                    st.push(t);
                    i++;
                }
            }
        }
        
        return root;
    }
```