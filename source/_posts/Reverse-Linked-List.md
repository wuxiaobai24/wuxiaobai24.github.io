---
title: Reverse Linked List
date: 2017-11-04 19:01:34
categories: LeetCode
tags:
- LeetCode
- LinkedList
---

第40天。

今天的题目是[Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/discuss/):

> Reverse a singly linked list.
> Hint:
> A linked list can be reversed either iteratively or recursively. Could you implement both?

简单的想法就是直接用一个栈来完成这种后进先出的操作:

```c++
ListNode* reverseList1(ListNode* head) {
    ListNode ret(0);
    ListNode *p = &ret;
    stack<ListNode *> st;
    while(head!=nullptr) { st.push(head); head = head->next; }
    while(!st.empty()) {
        p->next = st.top();
        st.pop();
        p = p->next;
    }
    p->next = nullptr;
    return ret.next;
}
```

但是这种方法效率不高，下面是迭代的方法：

```c++
ListNode* reverseList(ListNode* head) {
    ListNode *pre = nullptr;
    ListNode *cur = head;
    while(cur != nullptr) {
        ListNode *t = cur->next;
        cur->next = pre;
        pre = cur;
        cur = t;
    }
    return pre;
}
```

以及递归的方法:

```c++
ListNode *reverseList(ListNode *head) {
    if (head==nullptr || head->next == nullptr) return head;
    ListNode *ret = reverseList(head->next);
    head->next->next = head;
    head->next = nullptr;
    return ret;
}
```