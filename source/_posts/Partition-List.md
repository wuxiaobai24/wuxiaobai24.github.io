---
title: Partition-List
date: 2018-02-20 10:27:31
tags:
- LeetCode
---

第105天。

今天的题目是[Patrition List](https://leetcode.com/problems/partition-list/description/):

> Given a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.

> You should preserve the original relative order of the nodes in each of the two partitions.

> For example,
> Given 1->4->3->2->5->2 and x = 3,
> return 1->2->2->4->3->5.

一开始想复杂了，所以写的有点丑陋，主要的思想是，把一个链表划分成两个链表，一个大于，一个小于，然后在将他们拼接成一个链表即可：

```c++
ListNode *less, *less_tail;
ListNode *greater, *greater_tail;
ListNode* partition1(ListNode* head, int x) {
    less = new ListNode(-1);
    greater = new ListNode(-1);
    
    less_tail = less; greater_tail = greater;
    
    helper(head, x);
    
    //show(less);
    //show(greater);
    
    less_tail->next = greater->next;
    greater_tail->next = nullptr;
    
    less_tail = less->next;
    //less->next = greater->next = nullptr;
    
    delete less;
    delete greater;
    
    return less_tail;
}
void helper(ListNode *head, int x) {
    if (head == nullptr) return ;
    if (head->val < x) {
        less_tail->next = head; less_tail = less_tail->next;
    } else {
        greater_tail->next = head; greater_tail = greater_tail->next;
    }
    helper(head->next, x);
}    
```

然后简洁的解法：

```c++
ListNode *partition(ListNode *head, int x) {
    ListNode left(-1), right(-1);
    
    ListNode *l = &left, *r = &right;
    
    while(head) {
        if (head->val < x) {
            l->next = head; l = l->next;
        } else {
            r->next = head; r = r->next;
        }
        head = head->next;
    }
    
    l->next = right.next;
    r->next = nullptr;
    return left.next;
}
```