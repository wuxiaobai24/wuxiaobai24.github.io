---
title: Judge-Route-Cicle
date: 2017-12-19 08:20:43
categories: LeetCode
tags:
- LeetCode
---

第83天。

今天的题目是:[Judge Route Circle](https://leetcode.com/problems/judge-route-circle/description/):

> Initially, there is a Robot at position (0, 0). Given a sequence of its moves, judge if this robot makes a circle, which means it moves back to the original place.
>
> The move sequence is represented by a string. And each move is represent by a character. The valid robot moves are R (Right), L (Left), U (Up) and D (down). The output should be true or false representing whether the robot makes a circle.
>
> Example 1:
> Input: "UD"
> Output: true
> Example 2:
> Input: "LL"
> Output: false


比较无聊的一道题目,我们只需要维护一组下标来记录所在的位置即可，然后判断移动完后是否回到了最开始的位置即可：

```c++
bool judgeCircle(string moves) {
    int x = 0, y = 0;
    for(auto c:moves) {
        switch(c){
            case 'U': y++; break;
            case 'D': y--; break;
            case 'L': x--; break;
            case 'R': x++; break;
        }
    }
    return x == 0 && y == 0;
}
```