---
title: Linked-List-Random-Node
date: 2018-01-21 10:45:53
categories: LeetCode
tags:
- LeetCode
---

第90天。

今天的题目是[Linked List Random Node](https://leetcode.com/problems/linked-list-random-node/description/):

> Given a singly linked list, return a random node's value from the linked list. Each node must have the same probability of being chosen.
>
> Follow up:
> What if the linked list is extremely large and its length is unknown to you? Could you solve this efficiently without using extra space?
>
> Example:
>
> // Init a singly linked list [1,2,3].
> ListNode head = new ListNode(1);
> head.next = new ListNode(2);
> head.next.next = new ListNode(3);
> Solution solution = new Solution(head);
>
> // getRandom() should return either 1, 2, or 3 randomly. Each element should have equal probability of returning.
> solution.getRandom();

写出了一个朴素的解法，两次扫描：

```c++
Solution(ListNode* p) {
    len = 0;
    head = p;
    while(p) {
        len++;
        p = p->next;
    }
    cout << len << endl;
}

/** Returns a random node's value. */
int getRandom() {
    int r = rand() % len;
    cout << r << endl;
    ListNode *p = head;
    while(r-- && p) {
        p = p->next;
    }
    return p->val;
}
int len;
ListNode *head;
```

然后是利用栈来做的一个解法，即一直递归调用直到链表结尾，这时我们已经遍历了一遍链表就可以知道其长度了，在这时生成随机数，然后在递归调用返回的时候通过这个随机数来选取节点：

```c++
int getRandom() {
    temp_len = 0;
    getRandom(head);
    return res;
}
bool getRandom(ListNode *p) {
    if (p == nullptr) {
        rand_n = rand() % temp_len;
        return false;
    }
    temp_len++;
    if(getRandom(p->next)) return true;
    if (rand_n == 0) {
        res = p->val;
        return true;
    }
    rand_n--;
    return false;
}
int temp_len;
int rand_n;
ListNode *head;
int res;
```

最后是`dicuss`中的水库抽样法：

```c++
int getRandom() {
    int res = head->val;
    ListNode* node = head->next;
    int i = 2;
    while(node){
        int j = rand()%i;
        if(j==0)
            res = node->val;
        i++;
        node = node->next;
    }
    return res;
}
```

证明可参考：[http://blog.csdn.net/so_geili/article/details/52937212](http://blog.csdn.net/so_geili/article/details/52937212)

