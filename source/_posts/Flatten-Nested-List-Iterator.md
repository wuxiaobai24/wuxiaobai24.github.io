---
title: Flatten-Nested-List-Iterator
date: 2018-02-14 15:27:39
tags:
- LeetCode
---

第100天。

今天的题目是[flatten-Nested-List-Iterator](https://leetcode.com/problems/flatten-nested-list-iterator/description/):

> Given a nested list of integers, implement an iterator to flatten it.
>
> Each element is either an integer, or a list -- whose elements may also be integers or other lists.
>
> Example 1:
> Given the list [[1,1],2,[1,1]],
>
> By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,1,2,1,1].
>
> Example 2:
> Given the list [1,[4,[6]]],
>
> By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,4,6].

挺有趣的题目，主要是要实现一个嵌套列表的迭代器，大概是三个函数：

```c++
class NestedIterator {
public:
    NestedIterator(vector<NestedInteger> &nestedList) {
        
    }

    int next() {
        
    }

    bool hasNext() {
        
    }
};
```

然后他也提供了`NestedInteger`的接口和一些说明，算是对题目的补充：
```c++
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *   public:
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     bool isInteger() const;
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     int getInteger() const;
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     const vector<NestedInteger> &getList() const;
 * };
 */


/**
 * Your NestedIterator object will be instantiated and called as such:
 * NestedIterator i(nestedList);
 * while (i.hasNext()) cout << i.next();
 */
```

从补充中我们可以看到，在调用`next`前一定会先调用`hasNext`,有了这个前提我们写起来会方便一点。

我的解法是，`NestedIterator`只保存构造函数中传入的`nestedList`的两个迭代器，之所以是两个，是因为要保存`end`迭代器，然后要实现嵌套，我们还要一个`NestedIterator`的指针，利用这个指针来对下一级列表的元素进行迭代：

```c++
class NestedIterator {
public:
    NestedIterator(vector<NestedInteger> &nestedList) {
        _it = nestedList.begin(); _end_it = nestedList.end();
        _tmp_it = nullptr;
    }

    int next() {
        if (_it->isInteger()) { int ret = _it->getInteger(); ++_it; return ret; }
        return _tmp_it->next();
    }

    bool hasNext() {
        if (_it == _end_it) return false;
        if (_it->isInteger()) return true;
        
        if (_tmp_it == nullptr) {
            _tmp_it = new NestedIterator(_it->getList());
        }
        if (_tmp_it->hasNext()) return true;
        delete _tmp_it; _tmp_it = nullptr; ++_it;
        return hasNext();
    }
private:
    vector<NestedInteger>::iterator _it, _end_it;
    NestedIterator *_tmp_it;
};
```


然后这里的实现虽然比较简单，简洁，但是在遇到一些特殊情况的时候会对性能造成极大的影响,比如说`[[[[[1,2,3]]]]]`,虽然只有三个元素，但是因为有5层的嵌套，我们要有5个迭代器，每次调用`next`和`hasNext`都需要递归调用5次才能返回，这样效率就有点低了.

`dicuss`中的解法会比较好一点，类别`DFS`来做，先用`stack`保存所有的元素，在调用`hasNext`的时候，如果栈顶是列表就将其展开并压栈（倒序），然后在递归调用`hasNext`，直到栈顶为数字时,然后调用`next`就直接返回栈顶即可：

```c++
class NestedIterator {
public:
    NestedIterator(vector<NestedInteger> &nestedList) {
        begins.push(nestedList.begin());
        ends.push(nestedList.end());
    }

    int next() {
        hasNext();
        return (begins.top()++)->getInteger();
    }

    bool hasNext() {
        while (begins.size()) {
            if (begins.top() == ends.top()) {
                begins.pop();
                ends.pop();
            } else {
                auto x = begins.top();
                if (x->isInteger())
                    return true;
                begins.top()++;
                begins.push(x->getList().begin());
                ends.push(x->getList().end());
            }
        }
        return false;
    }

private:
    stack<vector<NestedInteger>::iterator> begins, ends;
};
```