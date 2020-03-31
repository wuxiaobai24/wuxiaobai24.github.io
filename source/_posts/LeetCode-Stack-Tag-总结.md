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

| Name                                                         | No   | Difficulty | Blog Link                                                    | Note                                                         |
| :----------------------------------------------------------- | :--- | :--------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Valid Parentheses](https://leetcode-cn.com/problems/valid-parentheses/) | 20   | Easy       | https://blog.codeand.fun/2017/09/24/Valid-Parentheses/       | 可以建一个右括号到左括号的`map`来使代码更加简洁              |
| [Simplify Path](https://leetcode-cn.com/problems/simplify-path/) | 71   | Medium     | https://blog.codeand.fun/2019/03/02/Simplify-Path/           | 用FSM的思想也可以解，可以用`stringstream`和`getline`进行字符串分割 |
| [Binary Tree Inorder Traversal](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/) | 94   | Medium     | https://blog.codeand.fun/2020/03/24/Binary-Tree-Preorder-Inorder-Postorder-Traversal/ | 递归、栈、莫里斯遍历                                         |
| [ Binary Tree Zigzag Level Order Traversal](https://leetcode-cn.com/problems/binary-tree-zigzag-level-order-traversal/) | 103  | Medium     | https://blog.codeand.fun/2018/02/11/Binary-Tree-Zigzag-Level-Order-Traversal/ | 用栈来模拟，可以避免逆序操作                                 |
| [Binary Tree Preorder Traversal](https://leetcode-cn.com/problems/binary-tree-preorder-traversal/) | 144  | Medium     | https://blog.codeand.fun/2020/03/24/Binary-Tree-Preorder-Inorder-Postorder-Traversal/ | 递归、栈、莫里斯遍历                                         |
| [Binary Tree Postorder Traversal](https://leetcode-cn.com/problems/binary-tree-postorder-traversal) | 145  | Medium     | https://blog.codeand.fun/2020/03/24/Binary-Tree-Preorder-Inorder-Postorder-Traversal/ | `function`对象+`lambda`表达式可以减少代码冗余。              |
| [Evaluate Reverse Polish Notation](https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/) | 150  | Medium     |                                                              |                                                              |
|                                                              |      |            |                                                              |                                                              |

