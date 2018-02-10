---
title: Rectangle-Area
date: 2018-01-17 12:35:45
categories: LeetCode
tags:
- LeetCode
---

第86天。

今天的题目是[Rectangle Area](https://leetcode.com/problems/rectangle-area/description/):

> Find the total area covered by two rectilinear rectangles in a 2D plane.
>
> Each rectangle is defined by its bottom left corner and top right corner as shown in the figure.
![](https://leetcode.com/static/images/problemset/rectangle_area.png)
> Assume that the total area is never beyond the maximum possible value of int.

一开始以为是求两个矩形重合部分的面积，后来仔细看了一下才发现是求它们的覆盖面积，好在把重合部分面积求出来后，求他们覆盖面积也比较简单，只需要先求出两个矩形的面积和之后再减去重合部分的面积就可以得到覆盖面积了。

```c++
int area(int A,int B,int C,int D) {
    return (C-A)*(D-B);
}
int intersect(int A, int B, int C, int D, int E, int F, int G, int H) {
    //求重合部分的面积
    if (!check(A, B, C, D, E, F, G, H)) return 0;
    return min(min(C-E,G-A),min(G-E,C-A)) * min(min(D-F,H-B),min(D-B,H-F));
}
int computeArea(int A, int B, int C, int D, int E, int F, int G, int H) {
    int a1 = area(A, B, C, D);
    int a2 = area(E, F, G, H);
    //cout << a1 << " " << a2 << endl;
    return a1- intersect(A, B, C, D, E, F, G, H) + a2;
}
bool check(int A, int B, int C, int D, int E, int F, int G, int H) {
    //判断是否重合
    return ( abs(A+C-E-G) <= (abs(A-C) + abs(G-E)) )&& (abs(B+D-F-H) <= (abs(D-B) + abs(H-F))); 
}
```

然后是`dicuss`中比较简洁的解法：

```c++
int computeArea(int A, int B, int C, int D, int E, int F, int G, int H) {
    int left = max(A,E), right = max(min(C,G), left);
    int bottom = max(B,F), top = max(min(D,H), bottom);
    return (C-A)*(D-B) - (right-left)*(top-bottom) + (G-E)*(H-F);
}
```

