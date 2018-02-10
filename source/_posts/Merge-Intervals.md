---
title: Merge-Intervals
date: 2017-10-17 11:13:24
categories: LeetCode
tags:
- LeetCode
---

第24天

emmm，又是一道10分钟刷完的题目——[Merge Intervals](https://leetcode.com/problems/merge-intervals/discuss/)

> Given a collection of intervals, merge all overlapping intervals.
>
> For example,
> Given [1,3],[2,6],[8,10],[15,18],
> return [1,6],[8,10],[15,18].

这个题目要考虑的就是怎么才能避免不断的插入删除。

其实再后来尝试优化的时候，就是陷入这个误区，尝试的写一个`O(n)`的算法出来，但是发现要不断的遍历和插入和删除元素，我们知道这对`vector`来说时比较耗时的。

我们先确定什么时候两个`Intervals`需要`merge`,考虑`i1`,`i2`,只有`i1.end > i2.start`，这时`i1`和`i2`就应该`merge`成`{i1.start,i2.end}`

* 先对`intervals`按`start`排序
* 将第一个元素放入`ret`，因为这时`start`是最小的，我们现在只需要寻找`end`即可
* 我们考察第二个元素，如果第二个元素的`start`小于第一个元素的`end`，我们就将修改`end`,并考察第三个元素，如果不成立，说明当前元素的`end`就已经找到了（因为`start < end`）

```c++
vector<Interval> merge1(vector<Interval>& intervals) {
    if (intervals.size() <= 1) return intervals;

    sort(intervals.begin(),intervals.end(),[](const Interval &a,const Interval b) -> bool{
        return a.start < b.start;
    });

    vector<Interval> ret;
    ret.push_back(intervals[0]);
    int last = 0;

    for(int i = 1;i < intervals.size();i++) {
        if (ret[last].end >= intervals[i].start)
            ret[last].end = max(intervals[i].end,ret[last].end);
        else {
            ret.push_back(intervals[i]);
            last++;
        }
    }

    return ret;
}
```

还有在`dicuss`中看到的答案，但是这个需要做两次`sort`，所以效率不会比上面的方法高:

```java
public List<Interval> merge(List<Interval> intervals) {
    // sort start&end
    int n = intervals.size();
    int[] starts = new int[n];
    int[] ends = new int[n];
    for (int i = 0; i < n; i++) {
        starts[i] = intervals.get(i).start;
        ends[i] = intervals.get(i).end;
    }
    Arrays.sort(starts);
    Arrays.sort(ends);
    // loop through
    List<Interval> res = new ArrayList<Interval>();
    for (int i = 0, j = 0; i < n; i++) { // j is start of interval.
        if (i == n - 1 || starts[i + 1] > ends[i]) {
            res.add(new Interval(starts[j], ends[i]));
            j = i + 1;
        }
    }
    return res;
}
```