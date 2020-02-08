---
title: 《 Java 编程思想》CH03 操作符
date: 2020-02-08 17:57:48
tags:
- Java
- 阅读笔记
- 《Java编程思想》
- 后端
categories: 《Java编程思想》
mathjax: true
---

> **在最底层，Java中的数据是通过操作符来操作的。**

## 操作符

- `+`,`-`,`*`,`*`，`=`与其他语言类似
- 几乎所有的操作符只能操作“基本类似”，而`=`，`==`，`!=`是例外
- String 类支持`+`和`+=`操作符，表示拼接操作，在进行拼接的操作会尝试将非 String 的元素转换为 String（调用tostring())
- 赋值操作符`=`的左边（左值）必须是一个明确的已命名的变量。

## 赋值

在为对象“赋值”时，其实质是拷贝“引用”，需要注意“别名现象”

```java
package com.company.ch03;

class Tank {
    int level;
}

public class Assignment {
    public static void main(String[] args) {
        Tank tank1 = new Tank();
        Tank tank2 = new Tank();
        tank1.level = 12;
        tank2.level = 13;
        System.out.println("tank1 = " + tank1.level);
        System.out.println("tank2 = " + tank2.level);

        tank1 = tank2;
        tank1.level++;
        System.out.println("tank1 = " + tank1.level);
        System.out.println("tank2 = " + tank2.level);
    }
}
//tank1 = 12
//tank2 = 13
//tank1 = 14
//tank2 = 14
```

### 方法调用中的别名问题

```java
package com.company.ch03;

class Letter {
    char c;
}

public class PassObject {
    static void f(Letter y) {
        y.c = 'z';
    }

    public static void main(String[] args) {
        Letter x = new Letter();
        x.c = 'a';
        System.out.println("x.c = " + x.c); // a
        f(x);
        System.out.println("x.c = " + x.c); // z
    }
}
```

不管是那种别名问题，关键是要理解到**拷贝的是引用，不是对象。**

## 算数操作符 & 自增与自减 & 按位操作符

- 整数除法不会四舍五入，而是直接舍去小数位
- 其余与C++中的一样

## 关系操作符

关系操作符与 C++ 也是类似，有一点比较特殊的是在 Java 中`==`和`!=`可以用在对象上，其比较的是**引用**，而不是对象内的值，如果要比较两个对象是否相等（语义上），通常调用`equals`函数来比较。

```java
Integer n1 = new Integer(47);
Integer n2 = new Integer(47);
n1 == n2; // false
n1.equals(n2); // true
```

**`equals`默认是比较引用，所以在自己实现的类中需要覆盖`equals`方法才能进行语义上的比较**


## 逻辑操作符

`&&`,`||`和`!`操作只能用于布尔值，**与C++不同，对一个非布尔值进行逻辑运算不会对该值强制转换，会报编译错误**

Java中的逻辑操作符也有“短路”现象

## 直接常量

- 十六进制`0x/0X`前缀+`0-9`和`a-f`
- 八进制`0`前缀+`0-8`
- 后缀`l/L`表示`long`类型
- 后缀`f/F`表示`float`类型
- 后缀`d/D`表示`double`类型
- 指数记数法：`1.39E-43`表示$1.39 \times e^{-43}$

## 移位操作符

- 移位操作符只能用于处理整数类型
- `>>`符号扩展，`>>>`0扩展
- 对 char、byte、short 类型进行移位运算，在进行移位之前会先转回为 int

## 三元运算符

> boolean-exp ? value0 : value1

## 字符串操作符 `+` 和`+=`

- 字符串中操作符 `+` 和`+=`表示“拼接”操作
- **如果一个表达式以字符串开头，那么其后续操作数都必须是字符串类型（不是则进行强制转换）**

## 类型转换操作符

**类型转换（`cast`)**是指，在适当的时候，Java 会将一种数据类型自动转换为另一种。

显式的类型转换如下：

```java
int i = 200;
long l = (long)i;
int j = (int)l;
```

### 类型转换：

- 窄式转换，需要显式指定（如 long 转 int）
- 扩展转换，无需显式指定（如 int 转 long）
- **Java允许任何基本类型之间的类型转换，除了布尔值。**
- “类”数据类型不允许类型转换

### 截尾和舍入

- 当 float 或 double 转向整型时，总是对数字进行截尾
- 如果需要舍入，可以调用`java.lang.Math.round()`

### 提升

**一个表达式中出现的最大的数据类型决定了该表达式最终结果的数据类型**，如 int 类型与 long 类型相加，得到一个 long 类型。

## Java 没有 sizeof

由于Java中所有基本数据类型的大小都是明确的，所以不需要sizeof。BTW，boolean 不是没有明确嘛。

