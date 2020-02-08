---
title: 《 Java 编程思想》CH02 一切都是对象
date: 2020-02-08 13:52:42
tags:
- Java
- 阅读笔记
- 《Java编程思想》
- 后端
categories: 《Java编程思想》
---


## 用引用操纵对象

尽管Java中一切都看作为对象，但是操纵的标识符实际上对象的一个“引用”。

```java
String s; // 这里只是创建了一个引用，而不是一个对象
String s = new String("abcd"); // 使用`new`操作符来创建一个对象，并将其与一个引用相关联
String s = "abcd"; // 字符串可以直接用带引号的文本初始化
```
## 必须由你创建所有对象

使用`new`操作符创建一个对象

### 存储到什么位置

由五个地方可以存储数据：

1. 寄存器：由于寄存器数量有限，所有无法直接控制
2. 堆栈（栈）：RAM中，存储在栈中的数据必须明确知道其生命周期，通常局部存放对象引用和局部基本类型的变量。
3. 堆：存放所有的对象
4. 常量存储：通常直接存放在代码内部，其永远不会改变
5. 非RAM存储：数据存放在程序之外，不受程序的控制，如流对象（System.out）和持久化对象（存放在磁盘的文件）。


### 特例：基本类型

一些比较小的，简单的类型，如果放在堆中往往效率不高，所以这些类型不需要使用`new`来创建，而是创建一个“自动”变量来直接存储“值”，并置于栈中。

**Java 中所有基本类型所占据存储空间的大小都是明确的**.

![Java基本类型大小](http://imagehosting.wuxiaobai24.fun//blog/Java基本类型大小.png)

- 所有数值类型都有正负号
- `boolean`类型所占存储空间的大小没有明确，仅定义为能够去字面值`true`或`false`
- 基本类型和其对应的包装类之间可以自动装包、自动解包
- Java 提供了两个用于高精度计算的类：`BigInteger`和`BigDecimal`

### Java 中的数组

- Java 确保数组会被初始化，且会进行范围检查
- 当创建一个数组对象时实际就是创建一个引用数组，并且每个引用都会被自动初始化为一个特定值`null`
- 也可以创建用来存放基本数据类型的数组，此时的初始化则是置零

## 永远不需要销毁对象

### 作用域

- 作用域决定了在其内定义的变量的可见性和生命周期
- 在作用域里定义的变量只可用于作用域结束前
- Java 中不允许“覆盖”变量的可见性

```java
{
	int x = 12;
	// x available
	{
		int q = 96;
		// Both x & q available
		int x = 96 // Illegal
	}
	// only x available
}
```

### 对象的作用域

- Java 对象不具备和基本类型一样的生命周期，由`new`创建的对象，只要你需要，其会一直保留下去。
- Java 使用垃圾回收器来监视`new`创建的对象，辨别并释放那些不会再被引用的对象


## 创建新的数据类型：类

使用`class`来创建一个新的类型：

```java
class ATypeName { }
```

## 字段和方法

一旦定义了一个类，就可以在类中设置两种元素：字段（数据成员）和方法（成员函数）。字段可以是任何类型的对象或基础类型。每个对象都有存储其字段的空间，即普通字段不在对象间共享。

引用一个对象的成员的方式：`objectReference.member`

基本数据类型的变量只有是类的成员时，才确保其获得一个默认值，否则的话，与C++一样，该变量可能是任意值（其实就是在堆还是栈的问题嘛），不过这种情况下Java会报编译错误。

## 方法、参数和返回值

方法的基本组成部分包括：名称、参数、返回值和方法体：

```java
ReturnType methodName ( /* Argument list */) {
	/* Method body */
}
```

方法名和参数列表唯一地标识某个方法（合起来称为“方法签名”）**注意：方法签名不包含返回值**。

Java 中的方法只能作为类的一部分来创建，方法通常只有通过对象才能调用，且这个对象必须有这个方法。


### 参数列表

方法的参数列表指定要传递给方法什么样的信息，这里采用的都是**对象的类型**，即包含指定的类型和名字，这里传递的实际上是**引用**，传递基础类型则通过自动包装来实现。

## 构建一个 Java 程序

### 名字可见性

为了防止不同类库中使用了相同的类名，Java 将反过来的域名作为唯一标识符（即包名），如我的域名为`codeand.fun`,则我的类库则使用`fun.codeand.utils`的形式。

**包名使用小写**

### 运用其他构件

使用`import`导入想要的包：

```java
import java.util.ArrayList;
import java.util.*; // 导入java.util下所有的类
```

`java.lang`默认导入到每一个Java文件中。


### static 关键字

当声明一个事物为`static`时，就意味着这个域或方法不会与包含它的类的任何对象实例关联在一起，可以理解为*类数据*和*类方法*。

```java
class StaticTest {
	static int i = 47;
	static void inc() { i++; }
}

int j = StaticTest.i; // 47
StaticTest st1 = new StaticTest();
StaticTest.inc();
StaticTest st2 = new StaticTest();
// st1.i == st2.i == 48 // 所有i都指向同一个存储空间
```


## 你的第一个 Java 程序

```java
// HelloDate.java
import java.util.*;

public class HelloDate {
    public static void main(String[] args) {
        System.out.println("Hello, it's");
        System.out.println(new Date());
    }
}
```

要创建一个独立运行的程序，那么该文件中必须存在某个类与该文件同名，且那个类必须又一个`main`方法，其形式如`public static void main(String[] args)`。

## 编译和运行

```bash
$ javac HelloDate.java // 编译，产生一个 HelloDate.class 文件
$ java HelloDate // 运行
```

## 注释和嵌入式文档

- 多行注释：`/* something */`
- 单行注释：`// something`

### 注释文档

Java 中可以将代码与文档放到一个文件中，这样有利于文档的维护，为了实现这一目的，这里使用一种特殊的注释语法来标记文档，此外还有一个工具`javadoc`来提取注释。javadoc的输出是一个html

```bash
# wuxiaobai24 @ wuxiaobai24-pc in ~/code/Java/ch2 [17:56:05] C:1
$ javadoc HelloDate.java 
正在加载源文件HelloDate.java...
正在构造 Javadoc 信息...
标准 Doclet 版本 1.8.0_242
正在构建所有程序包和类的树...
正在生成./HelloDate.html...
正在生成./package-frame.html...
正在生成./package-summary.html...
正在生成./package-tree.html...
正在生成./constant-values.html...
正在构建所有程序包和类的索引...
正在生成./overview-tree.html...
正在生成./index-all.html...
正在生成./deprecated-list.html...
正在构建所有类的索引...
正在生成./allclasses-frame.html...
正在生成./allclasses-noframe.html...
正在生成./index.html...
正在生成./help-doc.html...

# wuxiaobai24 @ wuxiaobai24-pc in ~/code/Java/ch2 [17:56:11] 
$ ls
allclasses-frame.html    HelloDate.class  index-all.html      package-list          stylesheet.css
allclasses-noframe.html  HelloDate.html   index.html          package-summary.html
constant-values.html     HelloDate.java   overview-tree.html  package-tree.html
deprecated-list.html     help-doc.html    package-frame.html  script.js
```

![打开index.html](http://imagehosting.wuxiaobai24.fun//blog/Index显示.png)

### 注释语法

所有 javadoc 命令都只能在由`/**`和`*/`组成的注释中

javadoc 的注释，只能为`public`和`protected`成员进行文档注释，而`private`和`defaule`成员的注释会被忽视掉

javadoc 主要有两种形式：

- 嵌入HTML
- **文档标签**：
	- **独立文档标签**是一些以`@`字符开头的命令，且置于注释行的最前面（除了前导的 `*`）
	- **行内文档标签**则可以在 javadoc 注释中的任何位置，同样以`@`开头，但要在花括号内。

常用的标签有：

- `@see`：引用其他类，会生成一个超链接条目（不会校验该链接是否有效），超链接文本为“See Also”
	```java
	@see classname
	@see fully-qualified-classname
	@see fully-qualified-classname@method-name
	```
- `{@link package.class#member label}`：与`@see`类似，不过是行内标签，使用“label”来处理作为超链接文本
- `{@docRoot}`：该标签产生到文档根目录的相对路径
- `{@inheritDoc}`：该标签从当前这个类最直接的基类继承相关文档到当前文档注释中
- `@version`:版本信息
- `@author`:作者信息
- `@since`:指定JDK版本最低为多少
- `@param`:表示参数含义，形式如`@param parameter-name description`
- `@return`:描述返回值，形式如`@return description`
- `@throws`:异常描述，该方法可能抛出的每个异常都需要说明，形式如`@throws fully-qualified-class-name description`
- `@deprecated`:指出一些旧特性已由改进的新特性所取代，不建议使用。调用一个标记为`@deprecated`的方法，编译器会发出警告。


```java
// HelloDate.java
import java.util.*;

/** A class comment
 * Test comment
 * @author wuxiaobai24
 * @version 0.1
 */
public class HelloDate {
    /** a field comment */
    public int i;
    /**
     * a <strong>protected</strong> filed comment
     * <ol>
     *  <li>one</li>
     *  <li>two</li>
     *  <li>three</li>
     * </ol>
     */
    protected int p;
    /** a private field comment */
    private int j;

    /** A method comment
     * @param args args comment
     */
    public static void main(String[] args) {
        System.out.println("Hello, it's");
        System.out.println(new Date());
    }
}
```

![javadoc输出1](http://imagehosting.wuxiaobai24.fun//blog《-Java-编程思想》CH02-一切都是对象-20200208150609-2020-2-8-15-6-9)
![《-Java-编程思想》CH02-一切都是对象-javadoc输出-2020-2-8-15-7-31](http://imagehosting.wuxiaobai24.fun//blog《-Java-编程思想》CH02-一切都是对象-javadoc输出-2020-2-8-15-7-31)
![《-Java-编程思想》CH02-一切都是对象-javadoc输出2-2020-2-8-15-7-59](http://imagehosting.wuxiaobai24.fun//blog《-Java-编程思想》CH02-一切都是对象-javadoc输出2-2020-2-8-15-7-59)



## 编码风格

- 驼峰式写法
- 标识符的第一个字符采用小写，其余用大写

## 练习

### 练习1

```java
// Ex1.java
public class Ex1 {
    public int i;
    public char c;

    public static void main(String[] args) {
        Ex1 e = new Ex1();
        System.out.println(e.i);
        System.out.println(e.c);
    }

}
```

### 练习2

```java
// Ex2.java

public class Ex2 {
    public static void main(String[] args) {
        System.out.println("Hello, World");
    }
}

```

### 练习3 & 练习4 & 练习5

```java
// Ex3.java

class DataOnly {
    int i;
    double d;
    boolean b;
}

class ATypeName {

}

public class Ex3 {
    public static void main(String[] args) {
        ATypeName a = new ATypeName();
        DataOnly d = new DataOnly();
        d.i = 1;
        d.d = 2.0;
        d.b = false;
        System.out.println(d.i);
        System.out.println(d.d);
        System.out.println(d.b);
    }
}
```

### 练习6

```java
// Ex4.java

public class Ex4 {
    int storage(String s) {
        return s.length() * 2;
    }
    public static void main(String[] args) {
        String s = new String("Hello");
        Ex4 e = new Ex4();
        int len = e.storage(s);
        System.out.println(len);
    }
}
```

### 练习7 & 练习8

```java
// Ex7.java

class StaticTest {
    static int i = 47;
}

class Incrementable {
    static void increment() { StaticTest.i++; }
}

public class Ex7 {
    public static void main(String[] args) {
        StaticTest st1 = new StaticTest();
        Incrementable.increment();
        StaticTest st2 = new StaticTest();
        System.out.println(st1.i);
        System.out.println(st2.i);
        System.out.println(StaticTest.i);
    }
}
```

### 练习9

```java
// Ex9.java

public class Ex9 {
    public static void main(String[] args) {
        int i = 24;
        Integer bi = i;
        System.out.println(i);
        System.out.println(bi);
        // ....
    }
}
```

### 练习10

```java
// Ex10.java

public class Ex10 {
    public static void main(String[] args) {
        if (args.length == 3) {
            System.out.println(args[0]);
            System.out.println(args[1]);
            System.out.println(args[2]);
        }
    }
}

```

### 练习11

```java
// Ex11.java

class AllTheColorsOfTheRainbow {
    int anIntegerRepresentingColors;

    void changeTheHueOfTheColor(int newHue) {
        anIntegerRepresentingColors = newHue;
    }
}

public class Ex11 {
    public static void main(String[] args) {
        AllTheColorsOfTheRainbow allTheColorsOfTheRainbow = new AllTheColorsOfTheRainbow();
        allTheColorsOfTheRainbow.changeTheHueOfTheColor(1);
        System.out.println(allTheColorsOfTheRainbow.anIntegerRepresentingColors);
    }
}
```
