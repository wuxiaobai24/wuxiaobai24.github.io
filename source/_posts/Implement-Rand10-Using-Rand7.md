---
title: Implement Rand10() Using Rand7()
date: 2020-01-02 14:52:19
tags:
- LeetCode
categories: LeetCode
---

> 第53天。

今天的题目是[Implement Rand10() Using Rand7()](https://leetcode.com/problems/implement-rand10-using-rand7/)

如果我们是用`Rand10()`去实现`Rand7()`的话就简单，因为 10 比 7 大，所以：

```c++
int rand7() {
    int r;
    while((r = rand10) > 7);
    return r;
}
```

但是题目是用`Rand7()`去实现`Rand10`，所以我们需要转换一下。

由于`1/10 = 1/2 * 1/5`，所以我们可以用`rand5()`和`rand2()`来实现`rand10()`，而`rand5()`和`rand2()`又可以用`rand7()`来实现，所以：

```c++
int rand10() {
    return rand5() + 5 * (rand2() - 1);
}
int rand2() {
    int r;
    while((r = rand7()) > 2) {
    }
    return r;
}
int rand5() {
    int r;
    while((r = rand7()) > 5) {
    }
    return r;
}
```

其期望为`7/2 + 7/5`，所以调用`rand7()`的次数会比较大，我们可以用`rand7()`去实现`rand49()`，由于`49 = 7 * 7`，所以我们只需要调用两次`rand7()`即可实现出`rand49()`
然后用`rand49()`去实现一个`rand40()`，而`rand40() % 10 + 1`即实现了`rand10()`:

```c++
int rand10() {
    int r;
    while((r = rand49()) > 40);
    return r % 10 + 1;
}
int rand49() {
    return (rand7()-1)*7 + rand7();
}
```