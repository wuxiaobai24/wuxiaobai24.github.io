---
title: 《 Java 编程思想》CH05 初始化与清理
date: 2020-02-09 11:24:03
tags:
  - Java
  - 阅读笔记
  - 《Java编程思想》
  - 后端
categories: 《Java编程思想》
---

## 用构造器确保初始化

在 Java 中，通过提供构造器，类的设计者可确保每个对象都会得到初始化。Java 会保证初始化的进行。**构造器采用与类相同的名称**。

- 由于构造器的名称必须与类名完全相同，所以“每个方法首字母小写”的风格在这里不适用。
- 构造器方法可以有参数，这样可以在初始化对象时提供实际参数。
- 不接受任何参数的构造器叫做“默认构造器”。
- 构造器一种特殊类型的方法，**它没有返回值**

## 方法重载

因为可以要用多种方式来创建并初始化一个对象，所以就需要多个构造器，而构造器的名称又需要和类名相同，所以必须允许**方法名相同而形式参数不同的构造器**存在，所以 Java 中有**方法重载**。

```java
class Rock {
	Rock() {
		// 默认构造器
	}
	Rock(int i) {
		// 带参数的构造器
		System.out.println("i=" + i);
	}
	void print() {
		System.out.println("i = null");
	}
	void print(int i) {
		System.out.println("i = " + i);
	}
}

// 初始化
Rock r1 = new Rock(); // 调用默认构造器
Rock r2 = new Rock(1); // 调用带参数的构造器
r2.print();
r2.print(1);
```

### 区分重载方法

**方法签名是由方法名和参数类型列表构成的**，所以用参数类型列表区分重载方法。**不能用返回值区分重载方法**

### 设计基本类型的重载

由于基本类型可能会从一个“较小”的类型自动提升为一个“较大”的类型，所以在重载方法中需要特别注意：

- 常数值当作`int`处理
- 实参的数据类型小于形参的数据类型时，会自动提升
- 对于 char 类型，如果找不到以 char 作为形参的方法的话，会把 char 类型提升成 int 类型
- 如果实参大于形参的话，需要显式的强制转换否则会报编译错误

## 默认构造器

- 默认构造器是一个没有形式参数的构造器，其作用是创建一个“默认对象”
- 如果类中没有构造器，编译器会自动创建一个默认构造器
- 如果类中已经有了一个构造器了，编译器则不会自动创建默认构造器

## this 关键字

由于同一类型的对象都可以调用相同的方法，为了在方法中区分不同的对象，会把对象的引用作为参数传递给方法，`a.fun(1)`在编译器内部会被翻译成`ClassName.fun(a, 1)`，我们可以通过`this`关键字在方法中访问到对象的引用。

- 在方法内部调用同个类的另一个方法不需要使用`this`,直接调用即可。
- this 可以在方法内部作为参数传递给另一个方法，也可以作为返回值（可以构造出链式操作）

### 在构造器中调用构造器

- 可以利用 this 来实现在构造器中调用构造器，这样可以避免重复代码。
- this 在一个构造器中只能调用一次构造器
- 必须将构造器置于最开始处，否则编译器会报错

```java
public class Flower {
    int petalCount = 0;
    String s = "initial value";

    Flower(int petals) {
        petalCount = petals;
        System.out.println("int arg ,petalCount = " + petalCount);
    }

    Flower(String ss) {
        s = ss;
        System.out.println("string arg ,s = " + s);
    }

    Flower(String s, int petals) {
        this(petals);
        // this 只能调用一次构造器
        this.s = s;
        System.out.println("string & int arg, s = " + s + ", petalCount = " + petalCount);
    }

    Flower() {
        this("hello", 24);
    }

    public static void main(String[] args) {
        Flower flower = new Flower();
        System.out.println("flower.petalCount = " + flower.petalCount);
        System.out.println("flower.s = " + flower.s);
    }
}
// int arg ,petalCount = 24
// string & int arg, s = hello, petalCount = 24
// flower.petalCount = 24
// flower.s = hello
```

### static 的含义

static 方法就是没有 this 的方法，在 static 中不能调用非静态方法，但是反过来可以。

## 清理：终结处理和垃圾回收

1. 对象可能不会被垃圾回收
2. 垃圾回收不等于“析构”
   1. Java 未提供“析构函数”或相似的概念，要做类似的清理工作，必须手动创建一下执行清理工作的普通方法
3. 垃圾回收只与内存有关
   1. 对与垃圾回收有关的任何行为来说（尤其是 finalize() 方法），它们必须同内存及其回收相关
   2. finalize() 的需求通常是用于一种特殊情况，即通过某种创建对象方式以外的方式为对象分配了存储空间，这种情况主要发生在使用了“本地方法”的情况下，本地方法是一种在 Java 中调用非 Java 代码的方式。如在非 Java 代码中调用了 malloc，为了释放内存，我们需要在 finalize() 中调用对应的本地方法进行 free。
   3. finalize() 方法的执行机制：**一旦垃圾回收器准备释放对象占用的存储空间，首先调用其 finalize() 方法，并且在下一次垃圾回收动作发生时，才会真正回收对象占用的内存。**

### 你必须实施清理

Java 中没有用于释放对象的 delete，因为垃圾回收器会自动帮你释放存储空间，因此 Java 中没有析构函数。**但是垃圾回收不能完全代替析构函数**，如果希望进行除释放存储空间之外的清理工作，我们需要明确调用某个 Java 方法。例如某个类打开了一个文件，垃圾回收不能自动帮我们关闭这个文件。为什么这个工作不能有 finalize() 方法来完成呢，原因其实在上面已经说明了，**对象可能不会被垃圾回收**，也就是说 finalize() 方法可能永远都不会被调用。

如果 JVM 没有面临内存耗尽的情况，它是不会浪费时间去执行垃圾回收以恢复内存的。

### 终结条件

虽然我们不能用 finalize() 方法来进行“清理”，但是我们可以利用它验证某个对象的终结条件。还是刚才那个打开文件的例子，假设在文件没有关闭的时候，垃圾回收将对象回收了，这就会产生一些非常难找的 bug。而 finalize() 可以帮助我们发现这种 bug。

```java
class Book {
    boolean checkedOut = false;
    Book(boolean checkOut) {
        checkedOut = checkOut;
    }
    void checkIn() {
        checkedOut = false;
    }

    protected void finalize() {
        if (checkedOut) {
            System.out.println("Error: checked out");
        }
        // super.finalize();
    }
}

public class TerminationCondition {
    public static void main(String[] args) {
        Book novel = new Book(true);
        novel.checkIn();
        new Book(true);
        System.gc();
    }
}
// Error: checked out
```

如上面这个例子，我们希望 Book 在被回收前已经 checkIn 了，所以我们在 finalize() 中写了一个条件语句来判断。

- `System.gc()`强制 GC
- 应该总是假设基类的 finalize() 也需要做某些时间，所以我们应该在 finalize() 函数的末尾加入 `super.finalize();`

### 垃圾回收器如何工作

垃圾回收器会提高对象在堆上创建的速度，这是因为 Java 的堆的实现与 C++ 的不同，其更像是一个传送带，每分配一个对象，它就往前移动一格，所以“堆指针” 只是简单的移动到尚未分配的空间，这意味 Java 中在堆上的分配速度非常快。当然，如果只是简单的像传送带一样工作的话，Java 的堆会占用大量的虚拟内存，进而导致频繁的页面调度，并可能会导致内存资源耗尽，因此需要有垃圾回收器的介入。垃圾回收会一边回收空间一边对堆进行“紧凑”操作。

几种常见的垃圾回收机制：

- 引用计数：一种简单但比较慢的垃圾回收机制。
  - 每个对象都有一个引用计数器，当引用连接对象时，引用计数加一，当引用离开作用域或被置 null 时，引用计数减一。
  - 这种方法无法处理“循环引用”的情况。
- 停止-复制（stop-and-copy)：
  - 其依据的思想是：对任何“活”的对象，一定能最终追溯到其存活在堆栈或静态存储区域之中。因此，可以从堆栈和静态存储区开始，遍历所有的引用，并递归查找该对象所包含的所有对象，即可找到所有“活”的对象。
  - 该机制会先暂停程序的运行，然后将所有存活的对象从当前堆复制到另一个堆，然后更新引用
  - 当对象被复制到新的堆中时，没复制的则相当于被回收了，同时可以实现“紧凑”的目标。
  - 该机制会有以下两个缺点：
    - 需要两个堆，进而需要维护比之前大一倍的空间
    - 如果只有少量垃圾甚至没有垃圾，而这时如果进行垃圾回收的话，开销太大了。
- 标记-清扫（mark-and-sweep)：
  - 与 stop-and-copy 机制依据的思想是一样的也是，用同样的方式找到“活”的对象
  - 每当它找到一个“活”的对象，就会给该对象一个标记，这个过程中不会回收任何对象。只有当全部标记工作完成时，才会进行清理。
  - 清理的过程中，没有被标记的对象被释放，但**不会做任何复制动作**。
  - 为了避免存储空间的“碎片化”，JVM 需要做紧凑操作

JVM 中采用的垃圾回收机制：

- 一种结合的 stop-and-copy 和 mark-and-sweep 的自适应垃圾回收算法
- 内存分配以较大的“快”作为单位，较大的对象可以独占一个块。每个块都有相应的代数（generation count）来记录它是否存活。
- 垃圾回收会对上次回收操作之后新分配的快进行整理，这样有助于解决有大量短命对象的情况。
- 垃圾回收机制会定期进行完整的清理——大型对象仍然不会被复制（只是其代数会增加），而那些含有大量小型对象的快会被复制并整理。
- 当只有少量或没有垃圾产生时，则转为使用 mark-and-sweep 算法。

Java 中 JIT（Just-In-Time）技术：

这种技术可以把程序全部或部分翻译成本地机器码，而不是通过 JVM，进而提升程序的运行速度。

当需要装载某个类时（第一次创建这个类时），编译器会找到其.class 文件，然后将该类的字节码装入内存，此时有两种做法：

- JIT 直接编译所有代码，但这个做法会有两个缺点：
  - 加载动作分散在整个程序中，累加起来要话更多时间
  - 可能会增加可执行代码的长度，进而导致页面调度
- 惰性评估（lazy evaluation）：，即 JIT 只在必要时才编译，这样不会执行的代码就不会被 JIT 所编译。

## 成员初始化

**Java 尽力保证：所有变量在使用前都能得到适当的初始化。**

局部变量没有默认初始值，如有在未初始化前使用它会报错编译错误，而类变量则有默认初始值。

### 指定初始化

Java 允许在定义类成员变量的时候为其赋值进行初始化。非基本类型也可以，同时可以使用已经函数或已经初始化好的变量进行初始化，但要保证初始化顺序的正确。

```java
public class InitialValues {

	boolean t = false;
	char c = 'a';
	byte b = 1;
	short s = 2;
	int i = func(s);
	long l = 4 + i;
	float f = (float)5.0; // 浮点数字面量是 double 类型的
	double d = 6.0;
	String reference = new String("hello world"); // 非基本类型也可以

    int func(short s) {
        return s*2;
    }
}
```

## 构造器初始化

- 无法阻止自动初始化的进行，它将在构造器之前执行。
- 类变量的定义顺序决定了初始化的顺序
- 静态数据的默认值与类变量一致
- 对于静态变量，Java 可以将多个初始化语句组合成一个静态块，其和静态变量初始化一样在类加载时执行。顺序与定义时的顺序相同
- 对于非静态变量，Java 中也可以将多个初始化语句组成一个块，在实例初始化执行。
- 对于以上两种块，既可以可以把它当成一条初始化语句来看待。

```java
public class InitialValues {

	boolean t = false;
	char c = 'a';
	byte b = 1;
	short s = 2;
	int i = 3;
	long l = 4;
	float f;
	double d;
	String reference;

	{
		f = (float) 1.0;
		d = 2*f;
		reference = new String("hello");
		reference = reference + f + d;
	}

	static {
		System.out.println("hello");
	}
	static int a;
	static {
		System.out.println("A is " + a);
		a = 2;
	}
}
```

对象的创建过程：

1. 第一次创建类或者访问其静态数据或方法，JVM 会加载其 .class 文件，此时执行所有静态初始化（按定义的顺序执行）。
2. 当 new 该类时，首先会在堆上分配空间，因为堆在分配前被置零了，所以本类型的默认值都是 0，非基本类型的引用的默认值则是 null。
3. 按顺序执行非静态的初始化
4. 执行构造器

## 数组初始化

数组是同类型的、用一个标识符名称封装到一起的一个对象序列或基本类型数据序列。

定义方式：

```java
int[] a; //建议使用这种
int a[]; //这样也可以， 但是不能指定数组的类型。`int a[3];` 这样是不允许的
```

`int[] a;`这样只是定义了一个数组的引用，我们可以使用`new`来创建一个数组，也可以直接初始化数组：

```java
int[] a = new int[3]; // 使用 new 来创建一个数组，这时真实数据会分配在堆中，所以默认值都为“零”
int[] b = {1, 2, 3}; // 直接初始化一个长度为3的数组
Integer[] c = new Integer[3]; // 创建一个对象数组，保存引用，这时初始值都为 null
Random rand = new Random(2);
int len = rand.nextInt(20);
int[] c = new int[len]; // 长度不一定要是一个字面值，可以是变量
```

数组初始化的坑点：

```java
InitialValues initialValues = new InitialValues();
initialValues.printInitialValues();
String[] stringArray = {"hello", "world"};
// initialValues.printStringArrary({"hello", "world"}); // 编译错误
initialValues.printStringArrary(stringArray);
initialValues.printStringArrary(new String[]{"hello", "world"}); //正确打开方式
int[] intArray = {1, 2, 3, 4};
// initialValues.printIntArray({1, 2, 3, 4}); // 编译错误
initialValues.printIntArray(intArray);
initialValues.printIntArray(new int[]{1, 2, 3, 4});
```

## 可变参数列表

在方法中，用`ClassName... ArgName`的形式可以定义可变参数列表，在方法中，ArgName 本质上是一个数组。在可变列表中可以使用任何类型，包括基础类型。这里传入基本类型时，没有依赖自动装包和解包，这意味着，ClassName 为 int 时，ArgName 是一个 int[]，而不是 Integer。**在重载方法时，应该只在一个方法中使用可变参数列表**

```java
static void printArray(Object... args) {
    for(Object arg: args) {
        System.out.print(arg + " ");
    }
    System.out.println();
}

static void f(int required, int... args) {
    System.out.println("Required: " + required);
    for(int i: args) {
        System.out.print(i + " ");
    }
    System.out.println();
}

public static void main(String[] args) {
    printArray(1, 2, 3, 4, 5);
    f(1);
    f(1, 2, 3);
    Integ
}
```

## 枚举类型

- 按照命名习惯，枚举值一般用全大写字母
- 为了使用 enum，需要创建一个该类型的引用
- enum 会自动创建一些实用的函数，如`toString()`显示其名称，`ordinal()`表示声明顺序
- enum 适合与 switch 一起使用

```java
enum EnumDemo {
	HELLO, WORLD, 
};

EnumDemo e1 = EnumDemo.HELLO;
System.out.println(e1); // 自动调用toString()
System.out.println(e1.ordinal());

for(EnumDemo e: EnumDemo.values()) {
    System.out.println("EnumDemo: " + e + " ordinal " + e.ordinal());
}
// HELLO
// 0
// EnumDemo: HELLO ordinal 0
// EnumDemo: WORLD ordinal 1
```