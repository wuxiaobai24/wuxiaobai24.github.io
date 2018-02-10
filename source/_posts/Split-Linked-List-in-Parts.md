---
title: Split-Linked-List-in-Parts
date: 2018-01-19 11:34:09
categories: LeetCode
tags:
- LeetCode
---

第88天。

今天的题目是[Split Linked List in Parts](https://leetcode.com/problems/split-linked-list-in-parts/description/):

> Given a (singly) linked list with head node root, write a function to split the linked list into k consecutive linked list "parts".
>
> The length of each part should be as equal as possible: no two parts should have a size differing by more than 1. This may lead to some parts being null.
>
> The parts should be in order of occurrence in the input list, and parts occurring earlier should always have a size greater than or equal parts occurring later.
>
> Return a List of ListNode's representing the linked list parts that are formed.
>
> Examples 1->2->3->4, k = 5 // 5 equal parts [ [1], [2], [3], [4], null ]
> Example 1:
> Input: 
> root = [1, 2, 3], k = 5
> Output: [[1],[2],[3],[],[]]
> Explanation:
> The input and each element of the output are ListNodes, not arrays.
> For example, the input root has root.val = 1, root.next.val = 2, \root.next.next.val = 3, and root.next.next.next = null.
> The first element output[0] has output[0].val = 1, output[0].next = null.
> The last element output[4] is null, but it's string representation as a ListNode is [].
> Example 2:
> Input: 
> root = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], k = 3
> Output: [[1, 2, 3, 4], [5, 6, 7], [8, 9, 10]]
> Explanation:
> The input has been split into consecutive parts with size difference at most 1, and earlier parts are a larger size than the later parts.
> Note:
>
> The length of root will be in the range [0, 1000].
> Each value of a node in the input will be an integer in the range [0, 999].
> k will be an integer in the range [1, 50].

虽然不难，但是自己还是做了一个早上，现在的效率真的是低的可以。

首先要知道每个块要有多少个节点就必须先知道总共有多少个节点，所以第一遍扫描算节点数肯定是少不了的，然后就可以开始算每个块的个数了。

* `k>=n`时，显然前n块只需要放一个就好了，后面的不用管。
* `k<n`时，可以分成两部分，前面的一部分比后面的一部分多放一个块，穷举几次可以知道，后面的部分每个快放`n/k`个节点，前面的部分有`n%k`个块。

其实到这里就可以发现其实并不需要分情况,第二种已经包括了第一种了。

```c++
vector<ListNode*> splitListToParts(ListNode* root, int k) {
    int size = 0;
    for(ListNode *p = root;p != nullptr;p=p->next) size++;
 
    vector<ListNode *> ret(k,nullptr);
    int a = size/k;
    int b = size%k;

    ListNode *pre = nullptr;
    ListNode *p = root;
    for(int i = 0;i < k && p;i++) {
        ret[i] = p;
        for(int j = 0;j < a + (b>0);j++) {
            pre = p;
            p = p->next;
        }
        b--;
        pre->next = nullptr;
    }

    return ret;
}
```