---
title: Add Two Numbers II
date: 2018-03-02 11:02:52
tags:
- LeetCode
---

题目是[Add Two Numbers II](https://leetcode.com/problems/add-two-numbers-ii/description/):

题目描述：

You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Follow up:
What if you cannot modify the input lists? In other words, reversing the lists is not allowed.



Example:

Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 8 -> 0 -> 7



求解思路：

这道题最简练的方法就是用栈了做了，然后还可以先计算出两个链表的长度，再生成链表。

思路都比较简单，emmm，一开始以为做成递归的会比较简单，后来发现不仅时间复杂度还是代码的复杂度都挺高的，做成迭代的会好很多。

```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        
        stack<int> s1, s2;
        int carry = 0, v1, v2, v;
        ListNode *cur;
        ListNode *pre = nullptr;
        
        while(l1 || l2) {
            if (l1) { s1.push(l1->val); l1 = l1->next; }
            if (l2) { s2.push(l2->val); l2 = l2->next; }
        }
        
       
        while(!s1.empty() || !s2.empty() || carry) {
            v1 = v2 = 0;
            if (!s1.empty()) { v1 = s1.top(); s1.pop(); }
            if (!s2.empty()) { v2 = s2.top(); s2.pop(); }
            
            v = v1 + v2 + carry;
            cur  = new ListNode(v % 10);
            cur->next = pre;
            pre = cur;
            carry = v /10;
        }      
        return pre;
    }
};
```

给出一个`dicuss`中的方法，很巧妙，用的是翻转链表（题目说不能修改原来的链表，所以这里是翻转output):

```c++
ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    int n1 = 0, n2 = 0, carry = 0;
    ListNode *curr1 = l1, *curr2 = l2, *res = NULL;
    while( curr1 ){ curr1=curr1->next; n1++; }
    while( curr2 ){ curr2=curr2->next; n2++; } 
    curr1 = l1; curr2 = l2;
    while( n1 > 0 && n2 > 0){
        int sum = 0;
        if( n1 >= n2 ){ sum += curr1->val; curr1=curr1->next; n1--;}
        if( n2 > n1 ){ sum += curr2->val; curr2=curr2->next; n2--;}
        res = addToFront( sum, res );
    }
    curr1 = res; res = NULL;
    while( curr1 ){
        curr1->val += carry; carry = curr1->val/10;
        res = addToFront( curr1->val%10, res );
        curr2 = curr1; 
        curr1 = curr1->next;
        delete curr2;
    }
    if( carry ) res = addToFront( 1, res );
    return res;
}

ListNode* addToFront( int val, ListNode* head ){
    ListNode* temp = new ListNode(val);
    temp->next = head;
    return temp;
}
```