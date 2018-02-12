---
title: Reverse-Linked-List-II
date: 2018-02-12 22:20:08
tags: 
- LeetCode
- 链表
---

第98天。

今天的题目是[Reverse Linked List II
](https://leetcode.com/problems/reverse-linked-list-ii/description/):

> Reverse a linked list from position m to n. Do it in-place and in one-pass.
>
> For example:
> Given 1->2->3->4->5->NULL, m = 2 and n = 4,
>
> return 1->4->3->2->5->NULL.
>
> Note:
> Given m, n satisfy the following condition:
> 1 ≤ m ≤ n ≤ length of list.

之前做个一道翻转的题目了，所以这道题就比较简单了,想法和之前的一样，先从翻转整个链表开始考虑（也就是之前那道题目）

我们只需要把相邻节点间的箭头换个方向，比如说：

`1->2`就调整为`1<-2`,有了这个想法后就简单多了：

```c++
ListNode *reverse(ListNode *head) {
    if (head == nullptr || head->next == nullptr) return head;
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

这个也是同理，只不过有些细节不一样罢了：

```c++
ListNode* reverseBetween(ListNode* head, int m, int n) {
    if (head == nullptr || head->next == nullptr) return head;
    if (m == n) return head;
    
    ListNode ret(0);
    ret.next = head;
    
    ListNode *pre = &ret;
    int i = 1;
    
    for(;i < m;i++) pre = pre->next;
    
    ListNode *cur = pre->next;
    ListNode *next = cur->next;
    
    for(;i < n;i++) {
        ListNode *t = next->next;
        next->next = cur;
        cur = next;
        next = t;
    }
    
    pre->next->next = next;
    pre->next = cur;
    
    return ret.next;
}
```