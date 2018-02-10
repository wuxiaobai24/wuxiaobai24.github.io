---
title: Merge Two Sorted List
date: 2017-09-28 11:06:00
categories: LeetCode
tags: 
- LeetCode
- 链表
---

打卡，第五天

今天偷个懒，找下自信先，做个`Easy`的题目——[Merge Two Sorted List](https://leetcode.com/problems/merge-two-sorted-lists/description/) （我也没想到是这么简单的题目）

之前在 `LintCode`做个一个链表排序，也写过一篇[blog](https://wuxiaobai24.github.io/2017/09/19/%E9%93%BE%E8%A1%A8%E6%8E%92%E5%BA%8F/)
解这道题时用的是`MergeSort`去做.所以已经写过一次`Merge Two Sorted List`了，之前的写法是这样的：

```c++
ListNode *mergeList(ListNode *l1,ListNode *l2){
  if (!l1) return l2;
  else if (!l2) return l1;
  ListNode* ret = new ListNode(0);
  ListNode*p = ret;
  while(l1 && l2) {
    if (l1->val > l2->val) {
      ret->next = l2;
      ret = ret->next;
      l2 = l2->next;
    } else {
      ret->next = l1;
      ret = ret->next;
      l1 = l1->next;
    }
  }
  ret->next = (l1)?l1:l2;
  ret = p->next;
  delete p;
  return ret;
}
```


这次做一个小改进（可能时间复杂度上没有改进）：

```c++
ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        ListNode* head = new ListNode(0);
        ListNode* ret = head;
        while(l1 || l2) {
            if ((l1 && l2 && l1->val > l2->val )|| !l1) {
                head->next = l2;
                head = head->next;
                l2 = l2->next;
            }else {
                head->next = l1;
                head = head->next;
                l1 = l1->next;
            }
        }
        head = ret->next;
        delete ret;
        return head;
    }
```

恩，细细想想，这个思路效率可能跟慢，不过用在对数组的`Merge`的情况还是可以的（起码比较简洁）。
