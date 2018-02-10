---
title: Add Two Numbers
date: 2017-09-30
categories: LeetCode
tags: 
- 链表
- 算法
---

打卡，第7天

> You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
> 
> You may assume the two numbers do not contain any leading zero, except the number 0 itself.

> Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
> 
> Output: 7 -> 0 -> 8
 

从示例来看，这里的`digits`应该是倒过来的，即`2->4->3`表示的是`342`

如果它不是倒过来的话，我们可能还需要用栈去将元素取出来。

虽然这是一道`Medium`的题目，但是难度其实很小，思路大概是：

将当期指针所指向的值相加得到一个数`x`，那么`x%10`就是这个位应该为的数，`x/10`就是进位，所以算法思路很简单：

```C++

ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    
    int ans,add = 0;
    ListNode ret(0);                        //头结点让单链表操作变简单
    ListNode *p = &ret;
    while(l1 != nullptr && l2 != nullptr){
        ans = (l1->val + l2->val) + add;    //记得加上进位
        add = ans/10;                       //求出进位
        p->next = new ListNode(ans%10);
        p = p->next;
        l1 = l1->next;
        l2 = l2->next;
    }
    while(l1){
        ans = l1->val + add;
        add = ans/10;
        p->next = new ListNode(ans%10);
        p = p->next;
        l1 = l1->next;
    }
    while(l2){
        ans = l2->val + add;
        add = ans/10;
        p->next = new ListNode(ans%10);
        p = p->next;
        l2 = l2->next;            
    }
    if (add != 0) p->next = new ListNode(add);//记得出来进位不为0的情况
    return ret.next;
}

```

`dicuss`中还有一个更精炼的写法：


```C++
ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    ListNode ret(0);
    ListNode *p = &ret;
    int add = 0,sum;
    while(l1 || l2 || add){
        sum = (l1?l1->val:0) + (l2?l2->val:0) + add;
        add = sum/10;
        p->next = new ListNode(sum%10);
        p = p->next;
        l1 = (l1?l1->next:nullptr);
        l2 = (l2?l2->next:nullptr);
    }
    return ret.next;
}
```