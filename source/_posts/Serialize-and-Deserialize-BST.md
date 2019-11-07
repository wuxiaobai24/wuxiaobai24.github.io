---
title: Serialize and Deserialize BST
tags:
  - LeetCode
  - 二叉树
categories:
  - LeetCode
originContent: ''
toc: false
date: 2019-11-07 11:48:04
---

# Serialize and Deserialize BST

> 第三天。

今天的题是[https://leetcode.com/problems/serialize-and-deserialize-bst/](Serialize and Deserialize BST):

---
Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a **binary search tree**. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary search tree can be serialized to a string and this string can be deserialized to the original tree structure.

**The encoded string should be as compact as possible.**

**Note:** Do not use class member/global/static variables to store states. Your serialize and deserialize algorithms should be stateless.

---

这个题目需要我们实现两个函数，一个对BST进行序列化，一个对BST进行反序列化。总的来说对算法要求不高（时间上），但是要求序列化出来的字符串尽量小。

首先要解决两个问题：

- 如何序列化一个正常节点
- 如何序列化一个NULL节点

这里面我们采取这样一个方法，一个正常的节点由以下结构组成：

```c++
struct {
	char flag = 'Y';
	union INT {
		int iv;
		char cv[4];
	};
};
```

其中flag来标识，这是一个正常的节点，而INT则是存放节点的值，通过`union`,我们可以方便的将int转换为char数组。

一个NULL的节点当然也可以通过上面的结构组成，但是对于NULL节点来说，后面的INT其实没有必要，所以我们直接通过字符`N`来标识NULL节点。

因此，我们的实现如下：


```c++
class Codec {
public:
    
    union INT {
        int iv;
        unsigned char cv[4];
    };
    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        string str;
        serialize(root, str);
        return str;
    }
    
    void serialize(TreeNode *root, string &str) {
        if (root == NULL) {
            
            str.push_back('N');
            return;
        }
        
        INT val;
        val.iv = root->val;
        
        str.push_back('Y');
        for(int i = 0;i < 4;i++) { 
            str.push_back(val.cv[i]);
        }
        
        
        serialize(root->left, str);
        serialize(root->right, str);
    }
    

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        int index = 0;
        return deserialize(data, index);
    }
    
    TreeNode *deserialize(string &data, int &index) {
        if (index >= data.size() || data[index] == 'N') {
            index += 1;
            return nullptr;  
        } 
        index += 1;
        INT val;
        for(int i = 0;i < 4;i++) val.cv[i] = (unsigned char)data[index + i];
        
        
        index += 4;
        TreeNode *root = new TreeNode(val.iv);
        root->left = deserialize(data, index);
        root->right = deserialize(data, index);
         
        return root;
    }
};
```
