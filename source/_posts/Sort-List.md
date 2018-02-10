---
title: Sort List
date: 2017-10-31 10:35:28
categories: LeetCode
tags:
- LeetCode
- List
---

第36天。

今天的题目好像是之前就做过的了，[Sort List](https://leetcode.com/problems/sort-list/description/):

> Sort a linked list in O(n log n) time using constant space complexity.

要`O(nlogn)`的算法，显然就是要用归并或快排啦，但是因为他是链表，所以只能是归并排序。

归并排序首先要解决的问题就是，如何分成两半，这里用的方法是快慢指针：

```c++
    ListNode* sortList(ListNode* head) {
        if (head == nullptr || head->next == nullptr ) return head;

        ListNode *slow = head;
        ListNode *fast = head;
        ListNode *pre = head;

        while(fast && fast->next) {
            pre = slow;
            slow = slow->next;
            fast = fast->next->next;
        }

        pre->next = nullptr;
        head = sortList(head);
        slow = sortList(slow);

        return mergeList(head,slow);
    }
    ListNode *mergeList(ListNode *p1,ListNode *p2) {
        ListNode ret(0);
        ListNode *p = &ret;
        while(p1&&p2) {
            if (p1->val > p2->val) { p->next = p2; p2 = p2->next; }
            else {p->next = p1; p1 = p1->next; }
            p = p->next;
        }
        if (p1) p->next = p1;
        if (p2) p->next = p2;
        return ret.next;
    }
```

因为是之前做过的，而且好像还写过`Blog`,所以就不详细写了。