---
title: Print FooBar Alternately
date: 2019-12-12 10:40:17
tags:
- LeetCode
categories: LeetCode
---

> 第36天。

今天的题目是[Print FooBar Alternately](https://leetcode.com/problems/print-foobar-alternately/):

一道简单的并发的题目，交替输出`Foo`和`Bar`，就是要并发的两个线程，按顺序交替执行，我们可以用两个`mutxe`去实现：

```c++
class FooBar {
private:
    int n;
    mutex m1, m2;
public:
    FooBar(int n) {
        this->n = n;
        m2.lock();
    }

    void foo(function<void()> printFoo) {
        
        for (int i = 0; i < n; i++) {
            m1.lock();
        	// printFoo() outputs "foo". Do not change or remove this line.
        	printFoo();
            m2.unlock();
        }
    }

    void bar(function<void()> printBar) {
        
        for (int i = 0; i < n; i++) {
            m2.lock();
        	// printBar() outputs "bar". Do not change or remove this line.
        	printBar();
            m1.unlock();
        }
    }
};
```
