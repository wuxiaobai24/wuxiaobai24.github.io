---
title: 《 Java 编程思想》 CH04 控制执行流程
date: 2020-02-09 10:47:56
tags:
tags:
- Java
- 阅读笔记
- 《Java编程思想》
- 后端
categories: 《Java编程思想》
---

> Java 中控制流程基本与 C/C++ 类似，所以大部分相同的部分会选择跳过。

## true 和 false

**Java 不允许使用一个数字作为布尔值使用**

## if-else

与 C/C++ 一样：

- if
- else 
- if else

## 迭代

与 C/C++ 一样：

- while
- do-while
- for

使用逗号操作符可以在 for 语句中定义多个变量（必须是同样类型）和执行多个语句：

```java
for(int i = 1, j = 1 + 1; i < 10; i++, i++) {
	System.out.println("i = " + i + ",j = " + j);
}
```

## Foreach 语法

使用`foreach`语法可以方便的遍历数组或容器：

```java
// f 为一个float的数组
for(float x: f) {
	System.out.println(x);
}
```

## return

`return`的两种用途：

- 指定方法的返回值
- 从方法的任何位置退出

返回值类型为 void 的方法可以没有 return，此时该方法的结尾处会有一个隐式的 return

## break & continue  & goto

Java 中 break 和 continue 与 C/C++ 类似，但是 Java 中没有 goto，但可以用 break 和 continue 实现跳转。

标签：

- 标识符 + `，如`label1:`
- 应该放在迭代语句之前，中间不能有任何语句

continue & break 与标签一起使用：

- 一般的 continue 会退回到最内层循环的开头继续执行
- 带标签的 continue 会退回到标签的位置，并重新进行标签后面那个循环
- 一般 break 会跳出当前循环
- 带标签的 break 会跳出标签所指定的循环

```java
outer:
for(;true;) { // for1
	inner:
	for(;true;) { // for2
		continue; //继续执行 for2 循环
		continue inner; // 继续执行 for2 循环
		continue outer; // 继续执行 for1 循环
		break; // 跳出 for2
		break inner; // 跳出 for2
		break outer; // 跳出 for1
	}
}
```

## switch

与 C++ 类似

```java
switch(integral-selector) {
	case integral-value1: statement; break;
	case integral-value2: statement; break;
	case integral-value3: statement; break;
	default: statement;
}
```