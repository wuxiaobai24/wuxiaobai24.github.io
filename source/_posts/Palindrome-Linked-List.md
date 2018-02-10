---
title: Palindrome Linked List
date: 2017-11-06 09:30:54
categories: LeetCode
tags:
- LeetCode
- LinkedList
---

第42天。

今天的题目是[Palindrome Linked List](https://leetcode.com/problems/palindrome-linked-list/description/):

> Given a singly linked list, determine if it is a palindrome.
>
> Follow up:
> Could you do it in O(n) time and O(1) space?

如果不考虑`O(1)`的空间复杂度的话，可以直接用一个栈保存，然后在对比，不过我没有实现这个方法。我的解法是先用快慢指针求链表中点，然后在翻转后面的链表（只需要`O(n)`的时间复杂度和`O(1)`的空间复杂度），然后在对比。

```c++
bool isPalindrome(ListNode* head) {
    if (!head || !head->next) return true;

    ListNode *fast = head;
    ListNode *slow = head;
    ListNode *pre = slow;
    while(fast && fast->next) {
        fast = fast->next->next;
        pre = slow;
        slow = slow->next;
    }
    fast = pre->next;
    pre->next = nullptr;

    fast = revertList(fast);

    while(fast && head) {
        if (fast->val != head->val)
            return false;
        fast = fast->next;
        head = head->next;
    }
    return true;
}
ListNode *revertList(ListNode *head) {
    if(!head || !head->next) return head;
    ListNode *pre = head;
    ListNode *cur = head;
    while(cur) {
        ListNode *t = cur->next;
        cur->next = pre;
        pre = cur;
        cur = t;
    }
    head = head->next;
    return pre;
}
```

然后是在`dicuss`中看到的解法，相当有趣的技巧：

```c++
ListNode* temp;
bool isPalindrome(ListNode* head) {
    temp = head;
    return check(head);
}

bool check(ListNode* p) {
    if (NULL == p) return true;
    bool isPal = check(p->next) & (temp->val == p->val);
    temp = temp->next;
    return isPal;
}
```

刚开始看的时候感觉好像是错的，但是仔细想想，这个方法相当美妙，利用函数调用来做栈，首先是递归调用`check(p->next)`,这样的话会一直到最后一个节点才开始比较`temp->val == p->val`，又因为`temp = temp->next`始终没有执行到，所以现在`temp`指向第一个元素，而`p`指向最后一个元素，判断完后，会执行到`temp = temp->next`，然后`check`会返回，返回后`p`就指向了倒数第二个元素，就这样一直迭代下去。

不过这个方法的空间复杂度是`O(n)`.