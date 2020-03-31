---
title: Binary Tree (Preorder|Inorder|Postorder) Traversal
date: 2020-03-24 12:10:21
tags:
- LeetCode
- Tree
- Stack
categories: LeetCode
---

今天将二叉树的先、中、后遍历的做了一些总结。三种遍历都有三种写法：

- 递归
  - 时间复杂度：`O(n)`
  - 空间复杂度：`O(h)`，`h`为树高
- 基于栈进行迭代：
  - 时间复杂度:`O(n)`
  - 空间复杂度：`O(n)`
- 莫里斯算法：
  - 时间复杂度：`O(n)`
  - 空间复杂度：`O(1)`

接下来内容有一下几个部分组成：
1. 首先介绍二叉树先、中、后序遍历的含义
2. 递归算法
3. 基于栈的迭代算法
4. 莫里斯算法

## 二叉树 & 先、中、后序遍历

![](https://g.gravizo.com/svg?digraph%20G%20{%20node[shape=circle]%20edge[arrowhead=vee]%201-%3E2;%201-%3E5;%202-%3E3;%202-%3E4;%20})

- 先序遍历：

  > 1. 访问当前节点
  > 2. 遍历左子树
  > 3. 遍历右子树

- 中序遍历：

  > 1. 遍历左子树
  > 2. 访问当前节点
  > 3. 遍历右子树

- 后序遍历：

  > 1. 遍历左子树
  > 2. 遍历右子树
  > 3. 访问当前节点

如上图中显示的二叉树中，先、中、后序遍历分别为：

- 先序：`1 2 3 4 5`
- 中序：`3 2 4 1 5`
- 后序：`3 4 2 5 1`

## 递归算法

已知三种遍历的含义之后，我们可以很容易的写出三种遍历的递归算法:

```c++
void prevorderTraversal(TreeNode *root) {
    if (root) {
        cout << root->val << endl;
        prevorderTraversal(root->left);
        prevorderTraversal(root->right);
    }
}

void inorderTraversal(TreeNode *root) {
    if (root) {
        inorderTraversal(root->left);
        cout << root->val << endl;
        inorderTraversal(root->right);
    }
}

void postorderTraversal(TreeNode *root) {
    if (root) {
        postorderTraversal(root->left);
        postorderTraversal(root->right);
        cout << root->val << endl;
    }
}
```

> 由于递归算法比较简单，所以这里不做过多的说明。
>
> 为了方便，访问节点时，只是输出节点的值。

## 基于栈的迭代算法

### 基于栈的迭代算法——先序遍历

基于栈的遍历算法中，先序遍历是最简单的。因为先序遍历本身可以进行尾递归优化，所以很容易用`stack`对递归调用进行模拟：

```c++
void preorderTraversal(TreeNode *root) {
    stack<TreeNode *> st;
    if (root) st.push(root);
    while(!st.empty()) {
        root = st.top(); st.pop();
        cout << root->val << endl;
        if (root->right) st.push(root->right);
        if (root->left) st.push(root->left);
    }
}
```

需要注意的是，因为栈用后进先出的特性，所以要先将右子树压入栈中，然后再将左子树压入栈中。

### 基于栈的迭代算法——中序遍历

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328094051-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328094051-2020-03-28)

我们以上图为例子，其中圆圈表示树中的节点，而三角形表示子树。其中的序号为访问顺序，我们可以发现，进行中序遍历的二叉树都符合这样的移动规律：

1. 先一直往左孩子的方向移动，直到没有左孩子。
2. 然后访问该节点，并遍历其右子树（这时相当于对其右子树进行 1、2、3步）。
3. 最后返回到其父节点并从第 2 步开始。

为了方便实现和代码的简洁，我们可以把观察到规律转换一下：

1. 先一直往左孩子的方向移动，直到当前节点为空，同时把所有经过的节点压入栈中。
2. 如果栈不空，则将栈顶弹出并访问，向右孩子移动并返回第一步。

因此我们可以写出如下代码：

```c++
void inorderTraversal(TreeNode *root) {
    stack<TreeNode *> st;
    while(root || !st.empty()) {
        while(root) {
            st.push(root);
            root = root->left;
        }
        // 栈一定不为空
        root = st.top(); st.pop();
        cout << root->val << endl;
        root = root->right;
    }
}
```

### 基于栈的迭代算法——后序遍历

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328094135-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328094135-2020-03-28)

后序遍历与中序遍历有些类似，同样需要先一直往左孩子方向移动直到没有左孩子，但是后序遍历要先访问完右子树才能访问当前节点，因此对于栈顶节点是否要访问并弹出，我们需要判断其右子树是否被访问了。同时，因为后序遍历中，一颗树的根节点是最后访问的，所以我们可以根据右孩子是否被访问了来判断右子树是否被访问了。而我们知道，当访问完右孩子，就可以马上访问该节点了，所以我们可以维护一个指针，该指针指向上一次被访问的节点。通过判断上一次被访问的节点是否为右子树或者`nullpter`，我们就可以知道是否要访问该节点并弹栈了。

```c++
void postorderTraversal(TreeNode* root) {
    TreeNode *prev = nullptr;
    stack<TreeNode *> st;
    while(root || !st.empty()) {
        while(root) {
            st.push(root);
            root = root->left;
        }
        root = st.top();
        if (root->right == nullptr || root->right == prev) {
            cout << root << right << endl;
            prev = root;
            root = nullptr;
            st.pop();
        } else root = root->right;
    }
    return res; 
}
```

## 莫里斯算法

莫里斯算法是一种用时间来换空间的二叉树遍历算法。他只需要`O(1)`的空间复杂度。

个人觉得它非常像中序线索树，所以我们先介绍中序线索树，然后再来理解莫里斯遍历。

### 中序线索树

假设一颗二叉树有`N`个节点，因为每个节点有 2 个指向孩子的指针，所以我们就有了 `2*N` 个指向节点的指针。同时，因为根节点不需要指针指向它，所以我们就使用了`2*N - (N-1) = N + 1`个空指针。线索树的想法就是将这些空指针利用上，来加快遍历速度的。

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328104922-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328104922-2020-03-28)

对于上面的二叉树来说，其中序遍历的结果为`[6 4 7 2 5 8 9 1 3]`。

如果节点 A 被访问后，马上访问 B，我们就认为 A 是 B 的前驱，B 是 A 的后继。从中序遍历的结果可以看出 6 是 4 的前驱，4 是 6 的后继。

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328105557-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328105557-2020-03-28)

上图中，红色虚线表示后继，绿色虚线表示前驱，一般我们将前驱放在左孩子，后继放在右孩子中。为了区分一个节点的两个孩子指针到底是真的孩子，还是线索，一般需要在每个节点中增加两个flag 位来区分。

### 莫里斯算法——中序遍历

因为中序线索树需要给每个节点都增加两个`flag`，但是因为很多时候我们不能修改二叉树节点的数据结构，所以它在很多情况是不适合的。通过观察我们可以发现，**在建立完中序线索树后，一个节点的左子树中最右边的节点的后继线索是总指向该节点的**。我们可以根据这个规律来判断当前节点是否需要访问，是向左孩子移动还是向右孩子移动。同时，因为遍历时不需要用到前驱，所以我们不用建立前驱的节点，只需要建立后继即可。

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328112150-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328112150-2020-03-28)

当我们访问节点`root`的时候：

- 如果它有左孩子，则找出左子树中最右边节点，并将该节点的右孩子设置为`root`（建立线索），并向左孩子移动。
- 如果它有左孩子，同时在找出左子树最右边节点的时候，如果发现某个节点的右孩子为`root`，则表示为该节点为左子树的最右边的节点，且已经建立了线索。这表示我们已经访问过左子树了。我们可以清除线索，访问`root`节点，并向右子树移动。
- 如果它没有左孩子，则直接访问`root`，并向右子树移动。

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

### 莫里斯算法——先序遍历

在莫里斯算法中，先序遍历与中序遍历非常想，只是访问`root`的节点的位置变了。在中序遍历中，我们总是在向右子树移动的时候访问`root`节点。而在先序遍历的中，我们总是在向左子树移动的时候访问`root`。当然，在没有左孩子的情况时，一样也是先访问`root`节点，再想右孩子移动。

当我们访问节点`root`的时候：

- 如果它有左孩子，则找出左子树中最右边节点，并将该节点的右孩子设置为`root`（建立线索），访问`root`节点，并向左孩子移动。
- 如果它有左孩子，同时在找出左子树最右边节点的时候，如果发现某个节点的右孩子为`root`，则表示为该节点为左子树的最右边的节点，且已经建立了线索。这表示我们已经访问过左子树了。我们可以清除线索，并向右子树移动。
- 如果它没有左孩子，则直接访问`root`，并向右子树移动。

因此代码如下：

```c++
TreeNode *GetRightLeaf(TreeNode *root, TreeNode *end) {
    while(root->right && root->right != end) root = root->right;
    return root;
}
void preorderTraversal(TreeNode* root) {
    while(root) {    
        if (root->left) {
            // if (root->right == nullptr) cout << "NULL" << endl;
            TreeNode *p = GetRightLeaf(root->left, root);
            if (p->right == root) {
                p->right = nullptr;
                root = root->right;
            } else {
                p->right = root;
                cout << root->val << endl;
                root = root->left;
            }
        } else {
            cout << root->val << endl; 
            root = root->right;
        }
    }
}
```

### 莫里斯遍历——后序遍历

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328115304-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328115304-2020-03-28)

通过观察，我们可以发现先、中、后序遍历有上面这种规律，因此我们可以发现，当所有左子树被访问完了（这时只剩下一条由右孩子组成的边，这里为了简便，将其称为，右边），按逆序访问由右边即可。

当我们访问节点`root`的时候：

- 如果它有左孩子，则找出左子树中最右边节点，并将该节点的右孩子设置为`root`（建立线索），并向左孩子移动。
- 如果它有左孩子，同时在找出左子树最右边节点的时候，如果发现某个节点的右孩子为`root`，则表示为该节点为左子树的最右边的节点，且已经建立了线索。这表示我们已经访问过左子树了。我们可以清除线索，**逆序访问左子树的右边。**
- 如果它没有左孩子，并向右子树移动。

按上面的算法进行的话，会导致有一条右边没办法访问到，所以增加一个虚节点，该虚节点的左孩子为`root`,右孩子为空，即：

![Binary-Tree-Preorder-Inorder-Postorder-Traversal-20200328120751-2020-03-28](http://imagehosting.wuxiaobai24.fun/blogBinary-Tree-Preorder-Inorder-Postorder-Traversal-20200328120751-2020-03-28)

```c++
TreeNode *GetRightLeaf(TreeNode *root, TreeNode *end) {
    while(root->right && root->right != end) root = root->right;
    return root;
}
TreeNode *reverse(TreeNode *p, const function<void(int)> &func) {
    TreeNode *prev, *next;
    prev = nullptr;
    while(p) {
        func(p->val);
        next = p->right;
        p->right = prev;
        prev = p;
        p = next;
    }
    return prev;
}
vector<int> postorderTraversal2(TreeNode* root) {
    TreeNode node(0);
    node.left = root;
    root = &node;

    auto func1 = [&](int val) {
        res.push_back(val);
    };
    auto func2 = [](int val) {};

    while(root) {
        if (root->left) {
            TreeNode *p = GetRightLeaf(root->left, root);
            if (p->right == root) {
                p->right = nullptr;
                p = reverse(root->left, func2);
                reverse(p, func1);
                root = root->right;
            } else {
                p->right = root;
                root = root->left;
            }
        } else root = root->right;
    }
    return res;
}
```

为了使得空间复杂度为`O(1)`，在逆序访问时，我们通过“翻转链表”的方式进行逆序访问，而不是用栈来实现。
