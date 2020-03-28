---
title: LeetCode Stack Tag 总结
date: 2020-03-23 10:03:40
tags:
- LeetCode
- Stack
categories: LeetCode
---

> 准备按 Tag 过一遍之前刷过的 LeetCode，总结一些常用的技巧和套路。

## 题目列表

| Name                                                         | No   | Difficulty | Blog Link                                              | Note                                                         |
| :----------------------------------------------------------- | :--- | :--------- | :----------------------------------------------------- | :----------------------------------------------------------- |
| [Valid Parentheses](https://leetcode-cn.com/problems/valid-parentheses/) | 20   | Easy       | https://blog.codeand.fun/2017/09/24/Valid-Parentheses/ | 可以建一个右括号到左括号的`map`来使代码更加简洁              |
| [Simplify Path](https://leetcode-cn.com/problems/simplify-path/) | 71   | Medium     | https://blog.codeand.fun/2019/03/02/Simplify-Path/     | 用FSM的思想也可以解，可以用`stringstream`和`getline`进行字符串分割 |
| [Binary Tree Inorder Traversal](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/) | 94   | Medium     |                                                        |                                                              |

![Alt text](https://g.gravizo.com/svg?
digraph G {
	State0 [shape = circle]
	State1 [shape = circle]
	State2 [shape = circle]
	State3 [shape = circle]
	State0 -> State1 [label = "slash"];
	State0 -> State0 [label = "char"];
	State0 -> State2 [label = "point"];
	State1 -> State0 [label = "char"];
	State1 -> State1 [label = "slash"];
	State1 -> State2 [label = "point"];
	State2 -> State3 [label = "point"];
	State2 -> State0 [label = "char"];
	State2 -> State1 [label = "slash"];
	State3 -> State0 [label = "char and point"];
	State3 -> State1 [label = "slash"];
})

![Alt text](https://g.gravizo.com/svg?
digraph example4 {
    node1 -> node2 [label = "condition1"]
    node2 -> node3 [label = "condition2"]
    node3 -> node1 [label = "condition3"]
})