---
title: Remove Nth Node From End of List
date: 2017-10-07 13:57:00
categories: LeetCode
tags:
- 链表
- LeetCode
---

打卡，第14天

今天的题目是[Remove Nth Node From End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/),一开始以为是道很简单的题目，后来看`dicuss`时才发现是自己没看清题目。

> Given a linked list, remove the nth node from the end of list and return its head.
>
> For example,
> Given linked list: 1->2->3->4->5, and n = 2.
>
> After removing the second node from the end, the linked list becomes 1->2->3->5. 
> Note:
> Given n will always be valid.
> Try to do this in one pass.

一开始没看到`Try to do this in one pass.`,然后就用两遍遍历方法去做了:

```c++
int getRightN(ListNode *head,int n) {
    ListNode *p = head;
    int size = 0;
    while(p != nullptr) {
        p = p->next;
        size++;
    }
    return size - n;
}
ListNode* removeNthFromEnd(ListNode* head, int n) {
    ListNode h(0);
    h.next = head;
    ListNode *p = &h;

    int k = getRightN(p,n);
    while(--k)
        p=p->next;

    head = p->next;
    p->next = head->next;
    delete head;
    return h.next;
}
```

上面这个方法太简单了，还是看看在`dicuss`中的方法吧：

```c++
ListNode *removeNthFromEnd(ListNode *head, int n) 
{
    if (!head)
        return nullptr;

    ListNode new_head(-1);
    new_head.next = head;

    ListNode *slow = &new_head, *fast = &new_head;

    for (int i = 0; i < n; i++)
        fast = fast->next;

    while (fast->next)
    {
        fast = fast->next;
        slow = slow->next;
    }

    ListNode *to_de_deleted = slow->next;
    slow->next = slow->next->next;

    delete to_be_deleted;

    return new_head.next;
}
```

这个看起来会比较简单，想法就是利用快慢指针去做，先让`fast`指针先走`n`步，然后在`fast`指针和`slow`指针一起移动，这样`fast`和`slow`始终保持着n个节点的距离，当`fast`为最后一个节点时，`slow`就指向倒数第n+1个节点，这时就可以把倒数第n个节点删掉了。

有一个更简洁的版本，不过有点难懂就是了：

```c++
ListNode* removeNthFromEnd(ListNode* head, int n)
{
    ListNode** t1 = &head, *t2 = head;
    for(int i = 1; i < n; ++i)
    {
        t2 = t2->next;
    }
    while(t2->next != NULL)
    {
        t1 = &((*t1)->next);
        t2 = t2->next;
    }
    *t1 = (*t1)->next;
    return head;
}
```

这个和上一个的思路其实是完全一样的，只是实现方法思路不一样就是，这里的`t1`是指向某个节点(包括一开始时虚拟的头结点）的`next`指针的指针。