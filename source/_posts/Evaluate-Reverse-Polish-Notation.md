---
title: Evaluate Reverse Polish Notation
date: 2020-03-31 09:29:10
tags:
- LeetCode
- Stack
categories: LeetCode
---

> 因为最近在总结 LeetCode 中 `Stack` 标签下做过的题目，然后这道题做了但是没有写题解，所以补充一下。

一道`Medium`的题目，但是数据结构课上提到栈时，都会举这个例子才对，所以这道题挺简单的。

因为输入的已经是解析好的`token`了，所以不用额外的做 parse 的工作。我们只需要用一个栈来保存操作树即可。

- 当遇到一个操作数时，就压入栈中。
- 当遇到一个操作符时，就弹出两个操作数，然后根据操作符对这两个操作数进行操作，并将结果压入栈中。

由于题目保证了输入一定是正确的，所以很多判断都可以省略掉。然后又一个需要主要的就是栈是后进先出的，所以操作数的顺序不要弄反了就好了。

```c++
bool isOp(const string &s) {
	return s.size() == 1 && (s[0] == '+' || s[0] == '-' || s[0] == '*' || s[0] == '/');
}
int calc(int a, char op, int b) {
	switch(op) {
		case '+': return a + b;
		case '-': return a - b;
		case '*': return a * b;
		case '/': return a / b;
	}
	return -1;
}
int evalRPN(vector<string>& tokens) {
	stack<int> st;
	for(auto &s: tokens) {
		if (!isOp(s)) {
			st.push(atoi(s.c_str()));
		} else {
			int b = st.top(); st.pop();
			int a = st.top(); st.pop(); 
			st.push(calc(a, s[0], b));
		}  // else return -1;
	}
	return st.top();
}
```
