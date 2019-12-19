---
title: Flatten a Multilevel Doubly Linked List
date: 2019-12-19 10:11:29
tags:
- LeetCode
categories: LeetCode
---

> 第43天。

今天的题目是[Flatten a Multilevel Doubly Linked List](https://leetcode.com/problems/flatten-a-multilevel-doubly-linked-list/):

蛮好玩的一道题。

本来想用递归做的，但是发现好像需要一层一层的返回最后一个指针，觉得有点麻烦，就直接用栈做了。

这个栈是用来保存上一层的指针的，而且看起来每一层最多一个节点有`child`，所以我们可以这样做：

- 遍历当前层，如果有孩子，则把当前节点压入栈中，并跳到下一层去遍历
- 如果遍历完当前层，则从栈中取出`parent`，然后进行`flatten`,为了避免没有必要的重复遍历，当前层最后一个节点压入栈中,这样下一次遍历时，就从上一层中第一个未被遍历的节点开始了。

代码如下：

```c++
Node* flatten(Node* head) {
    if (head == nullptr) return nullptr;
    stack<Node*> st;
    st.push(head);
    // if (head->child) st.push(head->child);
    while(!st.empty()) {
        Node *p = st.top(); st.pop();
        while(!p->child && p->next) {
            p = p->next;
        }
        if (p->child) {
            st.push(p);
            st.push(p->child);
        } else if (!st.empty()) {
            Node *parent = st.top(); st.pop();
            p->next = parent->next;
            if (p->next) p->next->prev = p;
            parent->next = parent->child;
            parent->next->prev = parent;
            parent->child = nullptr;
            st.push(p);
        }
    }
    return head;
}
```