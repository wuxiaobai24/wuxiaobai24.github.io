---
title: Construct-the-Rectangle
date: 2018-01-24 12:36:36
categories: LeetCode
tags:
- LeetCode
---

第93天。

今天的题目是[Construct the Rectangle](https://leetcode.com/problems/construct-the-rectangle/discuss/):

> For a web developer, it is very important to know how to design a web page's size. So, given a specific rectangular web page’s area, your job by now is to design a rectangular web page, whose length L and width W satisfy the following requirements:

> 1. The area of the rectangular web page you designed must equal to the given target area.
>
> 2. The width W should not be larger than the length L, which means L >= W.
>
> 3. The difference between length L and width W should be as small as possible.
> You need to output the length L and the width W of the web page you designed in sequence.
> Example:
> Input: 4
> Output: [2, 2]
> Explanation: The target area is 4, and all the possible ways to construct it are [1,4], [2,2], [4,1]. 
> But according to requirement 2, [1,4] is illegal; according to requirement 3,  [4,1] is not optimal compared to [2,2]. So the length L is 2, and the width W is 2.
> Note:
> The given area won't exceed 10,000,000 and is a positive integer
> The web page's width and length you designed must be positive integers.

比较简单的题目，但是题目有点长，总结一下就是，你要求出`L`,`W`满足一下条件：

1. L, W is int
1. L*W=Area
1. L >= W > 0
1. min |L-W|

既然要使得`|L-W|`最小，那么显然，`L=W=sqrt(Area)`时，`L-W`是最小的，但是因为`L`和`W`限制成整数了,且`sqrt(Area)`不一定是整数，如果把它转换成`int`的话，`L*W`不一定等于`Area`了。所以我们必须调整`L`和`W`的值，简单的调整方法就是，如果`L*W < Area`,我们就加大`L`之所以是加大`L`而不是加大`W`的原因是需要满足`L >= W`，同理`L*W > Area`时，我们就减小`W`。这样子我们始终会找到一个`L,W`满足上面的条件：

```c++
vector<int> constructRectangle(int area) {
    int L, W;
    int sqrt_a = sqrt(area);
    W = L = sqrt_a;
    int a = W*L;
    while(a != area) {
        if (a < area) L++;
        else if (a > area) W--;
        a = W*L;
    }
    return {L, W};
}
```

然后`dicuss`中的解法更巧妙一点，我们只求`W`，然后`L = Area/W`：

```java
public int[] constructRectangle(int area) {
    int w = (int)Math.sqrt(area);
    while (area%w!=0) w--;
    return new int[]{area/w, w};
}
```