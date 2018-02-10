---
title: Intersection of Two Linked Lists
date: 2017-11-02 20:29:24
categories: LeetCode
tags:
- LeetCode
- Linked-List
---

第38天。

今天课贼多，突然发现贼多作业没写完。。。

今天的题目是[Intersection of Two Linked Lists](https://leetcode.com/problems/intersection-of-two-linked-lists/description/):
> Write a program to find the node at which the intersection of two singly linked lists begins.
>
>
> For example, the following two linked lists:

```python
A:          a1 → a2
                   ↘
                     c1 → c2 → c3
                   ↗
B:     b1 → b2 → b3
```

> begin to intersect at node c1.
>
>
> Notes:
>
> If the two linked lists have no intersection at all, return null.
> The linked lists must retain their original structure after the function returns.
> You may assume there are no cycles anywhere in the entire linked structure.
> Your code should preferably run in O(n) time and use only O(1) memory.

最简单的方法就是先遍历一遍第一个链表所有的节点，然后记录下来，然后在遍历第二个链表节点的使用进行 查找即可，虽然很简单，但是时间复杂度很高和空间复杂度都挺高的：

```c++
ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
    vector<ListNode *> vec;
    while(headA) {
        vec.push_back(headA);
        headA = headA->next;
    }
    while(headB) {
        if (find(vec.begin(),vec.end(),headB) != vec.end()) return headB;
        headB = headB->next;
    }
    return nullptr;
}
```

然后是另一种方法，观察下图：

```python
A:          a1 → a2
                   ↘
                     c1 → c2 → c3
                   ↗
B:     b1 → b2 → b3
```

如果我们可以不断的把c3,c2,c1去掉，到最后，我们就会找到交点,这个方法只需要`O(1)`的空间复杂度以及`O(n*k)`的时间复杂度，k是两个链表共同拥有的节点。

```c++
ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
    //if (headA == nullptr || headB == nullptr) return nullptr;
    ListNode *end = nullptr;
    while(1) {
        if (headA == end || headB == end) return end;
        ListNode *pa = headA;
        ListNode *pb = headB;
        while(pa->next != end) pa = pa->next;
        while(pb->next != end) pb = pb->next;
        if (pa != pb) return end;
        else end = pa;
    }
}
```

然后是在`dicuss`中看到的：

```c++
ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
    ListNode *cur1 = headA, *cur2 = headB;
    while(cur1 != cur2){
        cur1 = cur1?cur1->next:headB;
        cur2 = cur2?cur2->next:headA;
    }
    return cur1;
}
```

第一眼看，没看懂，后来仔细看看才发现，`cur1`原本是`headA`开始的，但是在循环里面却被换成了`headB`,`cur2`同理。

所以他们其实会走同样多的距离并到达交点,如果没有交点，就同时到达`nullptr`。
