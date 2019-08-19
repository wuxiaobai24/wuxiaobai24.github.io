---
title: Odd Even Linked List
date: 2019-03-09 12:12:09
tags:
- LeetCode
- Linked List
categories:
- LeetCode
---

> 第10天，今天的题目总感觉做过，但是翻记录又没有，难道是在学校的OJ上做的？？？

今天的题目是 [Odd Even Linked List](https://leetcode.com/problems/odd-even-linked-list/)。

好久没碰到链表的题了，这题比较简单。我们用一个新的链表来存奇数位的元素即可，而且这里没必要重新建立一个链表，只需要把原来链表里面的连接过来就好了，完成后，自然就把一个链表分成两个链表了。

区分奇偶数位，可以用一个 flag 来标识当前元素是奇数还是偶数，然后每移动一次就翻转该 flag ，当然更简单的是，我们循环一次移动两个元素，这样看起来会简洁一点，而且在循环内部不需要任何的条件判断，只需要在循环结束后做一些后处理即可。


```c++
class Solution {
public:
    ListNode* oddEvenList(ListNode* head) {
        if (head == nullptr || head->next == nullptr) return head;
        
        ListNode even(0);
        ListNode *p = head;
        ListNode *q = &even;
        
        while(p->next && p->next->next) {
            q->next = p->next;
            p->next = p->next->next;
            p = p->next;
            q = q->next;
        }
        if (p->next != nullptr) {
            q->next = p->next;
            q = q->next;
        }
        p->next = even.next;
        q->next = nullptr;
        return head;
    }
};
```
