---
title: Linked List Cycle
date: 2017-10-30 09:18:19
categories: LeetCode
tags:
- LeetCode
- Linked-List
---

第35天。

今天的题目是[Linked List Cycle II](https://leetcode.com/problems/linked-list-cycle-ii/description/):

> Given a linked list, return the node where the cycle begins. If there is no cycle, return null.
>
> Note: Do not modify the linked list.
>
> Follow up:
> Can you solve it without using extra space?

这道题是判断链表是否有环的升级版。

首先肯定需要`fast`和`slow`指针来先判断是否有环，如果没有，就直接返回`nullptr`即可。

然后就是怎么计算出环的入口了。

先来个暴力的方法:

```c++
ListNode *detectCycle(ListNode *head) {
    vector<ListNode *> lvec;
    ListNode *fast = head;
    ListNode *slow = head;
    while(fast && fast->next) {
        fast = fast->next->next;
        slow = slow->next;
        //lvec.push_back(slow);
        if (slow == fast) {
            lvec.push_back(slow);
            slow = slow->next;
            while(slow != fast) {
                lvec.push_back(slow);
                slow=slow->next;
            }
            for(auto t:lvec) cout << t->val << endl;
            while(find(lvec.begin(),lvec.end(),head) == lvec.end())
                head = head->next;
            return head;
        }
    }

    return nullptr;
}
```

当然实际的方法不用那么麻烦：

```c++
ListNode *detectCycle(ListNode *head) {
    vector<ListNode *> lvec;
    ListNode *fast = head;
    ListNode *slow = head;
    while(fast && fast->next) {
        fast = fast->next->next;
        slow = slow->next;
        if (fast == slow) {
            slow = head;
            while(slow != fast) {
                slow = slow->next;
                fast = fast->next;
            }
            return fast;
        }
    }

    return nullptr;
}
```

emmmm,一直很好奇为什么可以这样判断，就去搜了一下，发现了这个[判断单向链表是否有环及求环入口的算法数学证明](http://windsmoon.com/2017/10/09/%E5%88%A4%E6%96%AD%E5%8D%95%E5%90%91%E9%93%BE%E8%A1%A8%E6%98%AF%E5%90%A6%E6%9C%89%E7%8E%AF%E5%8F%8A%E6%B1%82%E7%8E%AF%E5%85%A5%E5%8F%A3%E7%9A%84%E7%AE%97%E6%B3%95%E6%95%B0%E5%AD%A6%E8%AF%81%E6%98%8E/#more).