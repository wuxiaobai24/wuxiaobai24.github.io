---
title: Copy List with Random Pointer
date: 2018-02-28 10:12:58
tags:
- LeetCode
---

题目是[Copy List with Random Pointer](https://leetcode.com/problems/copy-list-with-random-pointer/description/):

题目描述：


A linked list is given such that each node contains an additional random pointer which could point to any node in the list or null.



Return a deep copy of the list.


求解思路：

很直观的方法，用来`O(n)`的空间来保存地址，没想到过了。



```cpp
/**
 * Definition for singly-linked list with a random pointer.
 * struct RandomListNode {
 *     int label;
 *     RandomListNode *next, *random;
 *     RandomListNode(int x) : label(x), next(NULL), random(NULL) {}
 * };
 */
class Solution {
public:
    RandomListNode *copyRandomList(RandomListNode *head) {
        if(head == nullptr) return head;
        
        unordered_map<RandomListNode *, RandomListNode *> m;
        
        RandomListNode *p = head;
        RandomListNode copy(0);
        RandomListNode *q = &copy;
        
        while(p) {
            
            q->next = new RandomListNode(p->label);
            
            //auto it = m.find(p);
            //if (it != m.end()) it->second = q->next;
            
            m[p] = q->next;
            
            p = p->next;
            q = q->next;
        }
        
        m[nullptr] = nullptr;
        p = head;
        q = copy.next;
        
        while(p) {
            
            q->random = m[p->random];
            
            p = p->next;
            q = q->next;
        }
        
        return copy.next;
    }
};
```


share一个`dicuss`中看到的方法：

![](https://raw.githubusercontent.com/hot13399/leetcode-graphic-answer/master/138.%20Copy%20List%20with%20Random%20Pointer.jpg)

图片失效的话，直接去[leetcode](https://leetcode.com/problems/copy-list-with-random-pointer/discuss/43491/A-solution-with-constant-space-complexity-O(1)-and-linear-time-complexity-O(N))中看原贴。