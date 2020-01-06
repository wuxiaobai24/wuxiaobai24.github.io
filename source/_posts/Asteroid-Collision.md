---
title: Asteroid Collision
date: 2020-01-06 10:46:09
tags:
- LeetCode
categories: LeetCode
---

> 第57天。

今天的题目是[Asteroid Collision](https://leetcode.com/problems/asteroid-collision/submissions/):

用栈去模拟整个过程，因为`STL`中的栈没法直接顺序迭代出来，所以我们用`vector`模拟一个栈出来使用。

不难发现，最终的结果一定是小于 0 的值在前面，而大于 0 的值在后面，所以我们只用栈维护大于 0 的值。而小于 0 的值如果前面没有 大于 0 的值的话（即已经确定没有碰撞后），直接将其放入答案中。又因为我们是用`vector`进行的模拟，所以可以在维护栈顶指针的时候也维护一个栈底指针来实现：

```c++
vector<int> asteroidCollision(vector<int>& asteroids) {
    int size = asteroids.size();
    if (size == 0) return vector<int>();
    vector<int> st(size);
    int top, beg;
    for(beg = 0;beg < size && asteroids[beg] < 0; beg++) st[beg] = asteroids[beg];
    top = beg;
    for(int i = beg; i < size;i++) {
        int a = asteroids[i];
        if (top == beg) { 
            st[top++] = a;
            if (a < 0) beg++;
        }
        else if (a > 0) st[top++] = a;
        else if (st[top-1] == -a) top--;
        else if (st[top-1] > -a) /* do nothing */;
        else {
            while(top != beg && st[top-1] < -a)
                top--;
            if (top != beg && st[top-1] == -a) top--;
            else if (top == beg) {
                st[top] = a;
                top = beg = beg + 1;
            }
        }
    }
    return vector<int>(st.begin(), st.begin() + top);
}
```

