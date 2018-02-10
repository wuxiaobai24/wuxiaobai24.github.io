---
title: Swaps-Nodes-in-Pairs
date: 2017-12-01 13:24:36
categories: LeetCode
tags:
- LeetCode
- ListNode
---

第65天。

今天的题目是[Swap Nodes in Pairs](https://leetcode.com/problems/swap-nodes-in-pairs/description/):

> Given a linked list, swap every two adjacent nodes and return its head.
>
> For example,
> Given 1->2->3->4, you should return the list as 2->1->4->3.
>
> Your algorithm should use only constant space. You may not modify the values in the list, only nodes itself can be changed.

和之前做的链表翻转有点像，可以用指针的指针来做：

```c++
bool swap(ListNode **head) {
    if (*head == nullptr || ( *head)->next == nullptr) return false;
    ListNode *p = *head;
    ListNode *next = p->next;
    p->next = next->next;
    next->next = p;
    *head = next;
    return true;
}
ListNode* swapPairs(ListNode* head) {
    ListNode **p = &head;
    while(swap(p))
        p=&((*p)->next->next);
    return head;
}
```