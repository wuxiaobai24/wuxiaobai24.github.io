---
title: Valid Parentheses
date: 2017-09-24 23:23:00
categories: LeetCode
---

 恩，照常打个卡（差点忘记）。。。。

由于比较晚才发现要刷个题（捂脸），所以找了个`Easy`的题目——[Valid Parentheses](https://leetcode.com/problems/valid-parentheses/description/)

> Given a string containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.
>
> The brackets must close in the correct order, `"()"` and `"()[]{}"` are all valid but `"(]"` and `"([)]"` are not.

很经典（很简单）的题目——括号匹配，显然用个栈来完成是最简单的了：

```c++
 bool isValid(string str) {
   stack<char> s;
   for(auto c:str){
     switch(c){
       case '(':case '{': case '[':
         s.push(c);
         break;
       case ')':
         if (s.empty() || s.top() != '(') return false;
         s.pop();
         break;
       case '}':
         if (s.empty() || s.top() != '{') return false;
         s.pop();
         break;
       case ']':
         if (s.empty() || s.top() != '[') return false;
         s.pop();
         break;
       default:
         return false;
     }
   }
   return s.empty()
 }
```

恩，好像没什么难度，多注意点细节就好了。

做完之后顺手看了一下`Discuss`,看了一下别人的[实现](https://leetcode.com/problems/valid-parentheses/discuss/)，同样是c++，同样的方法，为什么别人写的看起来就很舒服呢？

一起来对比一下:

```c++
 bool isValid(string s) {
   stack<char> paren;
   for (char& c : s) {
     switch (c) {
       case '(': 
       case '{': 
       case '[': paren.push(c); break;
       case ')': if (paren.empty() || paren.top()!='(') return false; else paren.pop(); break;
       case '}': if (paren.empty() || paren.top()!='{') return false; else paren.pop(); break;
       case ']': if (paren.empty() || paren.top()!='[') return false; else paren.pop(); break;
       default: ; // pass
     }
   }
   return paren.empty() ;
 }
```

突然很嫌弃自己的代码风格！！！