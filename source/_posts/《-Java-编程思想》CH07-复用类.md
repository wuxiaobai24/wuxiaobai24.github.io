---
title: 《 Java 编程思想》CH07 复用类
date: 2020-02-15 14:58:12
tags:
  - Java
  - 阅读笔记
  - 《Java编程思想》
  - 后端
categories: 《Java编程思想》
---

**复用代码是 Java 众多引人注目的功能之一。**

Java 可以通过创建类来复用代码，要在使用类的时候不破坏现有代码，有两种方式：

- 组合：在新的类中使用现有类的对象。
- 继承：按照现有类的类型来创建新类，无需改变现有类的形式，并为其添加新代码。

## 组合语法

- 使用组合技术只需要将对象引用置于新类中。
- 每个非基本类型的对象都有一个 `toString()` 方法，而且当编译器需要一个 String 而你传入一个对象时，`toString()` 会被调用。
- 类中的对象引用会被默认初始化为 null，如果你对其调用任何方法都会抛出异常，但是可以在不抛出异常的情况下，仍然可以打印一个 null 引用
- 类中对象引用的初始化位置：
  - 在定义对象的地方
  - 在类的构造器中
  - 惰性初始化，即在要使用该对象的地方进行初始化
  - 实例初始化

```java
class Soap {
	private String s;
	Soap() {
		System.out.println("Soup()");
		s = "Constructed";
	}

	@Override
	public String toString() {
		return s;
	}
}

/**
 * Bath
 */
public class Bath {

	private String s1 = "happy",  // 在定义处初始化
					s2; 
	private Soap soap;
	private int i;
	
	public Bath() {
		System.out.println("Inside Bath()");
		soap = new Soap(); // 在构造函数中初四花	
	}

	@Override
	public String toString() {
		if (s2 == null) {
			s2 = "Joy"; // 惰性初始化
		}
		return s2;
	}

	{
		i = 2; // 实例初始化
	}

	public static void main(String[] args) {
		Bath b = new Bath();
		System.out.println(b);
	}
}
```

## 继承语法

- 继承是 OOP 语言和 Java 语言不可缺少的部分，当创建一个类时，总是在继承，即使没有显式继承某个类，也会隐式地从 Object 类中继承。
- 继承由关键词 `extends` 指定，其形式如`class Detergent extends Cleanser{}`，基类的所有方法和成员都会自动导入到导出类中。
- 可以为每个类都创建一个 main 方法，这样可以使得每个类的单元测试变得简便。即使某个类只有包访问权限，其`public main`也可以通过 `java className`的方式访问到
- 为了继承，一般是将所有的数据成员都指定为 private，将所有的方法指定为 public。
- 我们对继承来的方法进行重写，重写之后可以通过 `super` 关键词访问基类版本的方法，如`super.func()`;
- Java 会自动在导出类的构造器中插入对基类构造器的调用，其总是在导出类构造器执行之前，即使是在定义处初始化的语句也会在基类构造器执行之后执行。
- 即使没有为导出类创建构造器，编译器也会在默认构造器中调用基类的构造器
- 如果没有默认的基类构造器，或者想要调用一个带有参数的基类构造器，就必须使用 super 关键词显式调用基类构造器，**调用基类构造器必须是在你导出类构造器的第一条语句**。

## 代理

代理是指，我们将一个成员对象置于要构造的类中（像组合），但与此同时我们在新类中暴露该成员对象的所有或部分方法（想继承）。

IDEA自动创建代理的过程：
- 先在代理类中声明要代理的成员。
- `Alt + Insert`快捷键，选中 `Delegation`
- 选中要代理的函数即可。

```java
class SpaceShipControls {
    void up(int velocity) {}
    void down(int velocity) {}
    void left(int velocity) {}
    void right(int velocity) {}
    void back(int velocity) {}
    void turboBoost() {}
}


public class SpaceShipDelegation {
    SpaceShipControls spaceShipControls = new SpaceShipControls();

    public void up(int velocity) {
        spaceShipControls.up(velocity);
    }

    public void down(int velocity) {
        spaceShipControls.down(velocity);
    }

    public void left(int velocity) {
        spaceShipControls.left(velocity);
    }

    public void right(int velocity) {
        spaceShipControls.right(velocity);
    }

    public void back(int velocity) {
        spaceShipControls.back(velocity);
    }

    public void turboBoost() {
        spaceShipControls.turboBoost();
    }

    public static void main(String[] args) {
        SpaceShipDelegation spaceShipDelegation = new SpaceShipDelegation();
        spaceShipDelegation.left(1);
    }
}
```

## 结合使用组合继承

- 可以结合组合和继承来创建复杂的类
- 编译器会强制你去初始化基类，并且要求在构造器最开始出就要这么做，但是它不会要求你对成员对象进行初始化，因此需要自己注意。
- Java 中没有 C++ 中的析构函数，就像之前所说的一样，如果我们的类的确需要做一些类似的工作（如关闭文件），我们需要自己实现一个方法来实现，而当涉及到继承时，我们要确保以正确的顺序调用该函数，推荐和C++中析构函数的执行顺序一样编写该函数，即先清理导出类本身，再调用基类的清理函数。
- 清理函数需要放在 finally 子句中，以防异常的出现，导致清理函数未被执行，可参考练习12
- 如果 Java 的基类拥有某个已经被多次重载的方法名称时，在导出类中重新定义该方法的名称，不会屏蔽其在基类中的任何版本。这意味着，在导出类中，重载和重新定义（重写）容易混淆在一起，如果不看基类的定义是很难分辨某个方法是否正确的被重新定义了。我们可以使用`@Override`注解来标识某个方法我们希望其是重写而不是重载，如果一不小心重载了，则会出现编译错误来提醒我们。

## 在组合与继承之间选择

- 组合和继承都允许在新的类中放置子对象，组合是显式地这样做，而继承则是隐式地这样做。
- 组合技术通常用于想在新类中使用现有类的功能而非它的接口这种情况。有时，允许类的用户直接访问新类中组合成分是有意义的。
- 在继承时，使用某个现有类，开发一个它的特殊版本。通常，这意味着你在使用一个通用类，并为了某种特殊需要而将其特殊化。

## 向上转型

- “为新的类提供方法”不是继承中最重要的部分，其重要的方面是用来表现新类和基类之间的关系。简单的说，我们可以认为“导出类是基类的一种类型”，即可以把导出类当成基类来使用
- 由于导出类转换为基类在继承图上是向上移动的，因为我们将其成为“向上转型”
- 向上转型是从一个较为专用的类向较为通用的类转变
- 虽然在教授OOP的过程中多次强调继承，但是我们应该慎用继承。判断是否要使用的继承的一个简单方法就是，判断我们是否要进行向上转型，如果要进行向上转型，则用继承，反之，则用组合。

```java
class Instrument {
    public void play() {}
    static void tune(Instrument i) {
        i.play();
    }
}

public class Wind extends Instrument {
    public static void main(String[] args) {
        Wind wind = new Wind();
        Instrument.tune(wind); // 传递参数时，用了向上转型
    }
}
```

## final 关键字

final 关键词的含义通常指“无法改变的”，使用这个关键词通常是因为设计和效率的原因。，final 可以用在数据、方法和类上。

### final 数据

- 数据的恒定不变分为两种情况：编译时常量和在运行时初始化并并无法的改变的值。
- 在 Java 中，这类常量必须是基本数据类型，并且用关键词 final 表示，并在该常量定义时对其初始化，如`final int value = 1`。通常，编译时常量还是一个`static`数据，即`static final int VALUE_ONE = 1`。
- 编译器常量的命名规则是：全用大写字母，单词与单词之间用`_`隔开
- 即使一个变量是`final`,我们也无法确定其是编译时常量，因为初始化没有要求是字面量，即初始化可以通过调用函数实现，如`final int value = rand.nextInt(20)`。
- 同时一个`final`数值，如果其是`static`的，那么它可能是在类导入时初始化的，而他不是`static`的话，它是在实例化时初始化的。
- 对于基本变量，final 使数值恒定不变，但是对于对象引用，其只是要求对象引用不变，即不指向新的对象，而对象本身是可以被修改的。
- Java 允许“空白 final”，即被声明为 final 但是又没有给定初值的域，虽然可以在定义时不给定初值，按时编译器会保证，final 域在使用前都必须被初始化，即如果没有在定义处给定 final 域的初值的话，就必须在每个构造器中对该 final 域进行赋值。
- Java 允许在参数列表中以声明的方式将参数指明为 final，其含义为，在该函数中无法修改该变量：
  - 参数类型为基本类型：可以读参数，但是不能修改
  - 参数类型为对象类型：无法修改引用

### final 方法

- 可以将一个方法定义成 final，这样可以防止任何继承类修改它的含义（即导出类无法覆盖实现）
- 在 Java 的早期实现中，对 final 方法的调用会被转为内嵌调用（C++ 中的 inline），但是现在不需要用这样的方式来优化代码了
- 类中的所有 private 方法都被隐式的指定为 final
- “覆盖”只有在方法是基类的接口的一部分时才会出现，即必须能将一个对象向上转型为它的基本类型并调用相同的方法，如果一个方法是 private，那么它就不是接口的一部分。


### final 类

当将一个类的整体定义为 final 时，就表明该类无法被继承，同时隐式地将所有方法都定义为 final。

## 初始化及类的加载

- 每个类的编译代码都存在与他自己独立的文件中。该文件只有在需要使用程序代码的时候才会被加载。
- 一般来说，只有在“类首次使用才加载”，即加载发生于第一次创建类的对象或第一次使用类中的静态域或静态方法。
- 在加载导出类是，Java 编译器会注意到它继承于某个基类，因此他会先去加载该基类。

```java
package com.company.ch07;

class Insert {
    private int i =  9;
    protected int j;
    Insert() {
        System.out.println("i = " + i + " j = " + j);
        j = 39;
    }
    private static int x1 = printInit("static Insert.x1 init");
    static int printInit(String s) {
        System.out.println(s);
        return 47;
    }
}

public class Beetle extends Insert {
    private int k = printInit("Beetle.k init");
    public Beetle() {
        System.out.println("k = " + k);
        System.out.println("j = " + j);
    }
    private static int x2 = printInit("static Beetle.x2 init");

    public static void main(String[] args) {
        System.out.println("Beetle constructor");
        new Beetle();
    }
}

//    static Insert.x1 init
//    static Beetle.x2 init
//    Beetle constructor
//    i = 9 j = 0
//    Beetle.k init
//    k = 47
//    j = 39
```

## 练习

### 练习1

```java
class Demo {
	public Demo() {
		System.out.println("Demo");
	}
	@Override
	public String toString() {
		return "toString()";
	}
}

/**
 * Ex1
 */
public class Ex1 {
	Demo demo;
	@Override
	public String toString() {
		if (demo == null) {
			demo = new Demo();
		}
		return demo.toString();
	}

	public static void main(String[] args) {
		Ex1 ex1 = new Ex1();
		System.out.println(ex1);
	}
}
```

### 练习2

```java
class Cleanser {
	private String s = "Cleanser";
	public void append(String a) {
		s += a;
	}
	public void dilute() { append(" dilute()"); }
	public void apply() { append(" apply()"); }
	public void scrub() { append(" scrub()"); }
	@Override
	public String toString() {
		return s;
	}
	public static void main(String[] args) {
		Cleanser cleanser = new Cleanser();
		cleanser.dilute(); cleanser.apply(); cleanser.scrub();
		System.out.println(cleanser);
	}
}

/**
 * Detergent
 */
public class Detergent extends Cleanser {

	@Override
	public void scrub() {
		append(" Detergent.scrub()");
		super.scrub();
	}

	public void foam() { append(" foam()");}
	public static void main(String[] args) {
		Detergent detergent = new Detergent();
		detergent.dilute();
		detergent.apply();
		detergent.scrub();
		detergent.foam();
		System.out.println(detergent);
		Cleanser.main(args);	
	}
}

class NewDetergent extends Detergent {
	public void scrub() {
		append("NewDetergent");
		super.scrub();
	}
	public void sterilize() {
		append("sterilize");
	}

	public static void main(String[] args) {
		NewDetergent newDetergent = new NewDetergent();
		newDetergent.dilute();
		newDetergent.apply();
		newDetergent.scrub();
		newDetergent.foam();
		newDetergent.sterilize();
		System.out.println(newDetergent);
		Detergent.main(args);
	}
}

// Cleanser dilute() apply()NewDetergent Detergent.scrub() scrub() foam()sterilize
// Cleanser dilute() apply() Detergent.scrub() scrub() foam()
// Cleanser dilute() apply() scrub()
```

### 练习3 & 练习4	

```java
class Art {
	Art() {
		System.out.println("Art");
	}
}

class Drawing extends Art {
	Drawing() {
		System.out.println("Drawing");
	}
}

/**
 * Cartoon
 */
public class Cartoon extends Drawing{

	// public Cartoon() {
	// 	System.out.println("Cartoon");
	// }

	public static void main(String[] args) {
		new Cartoon();
	}
}

// Art
// Drawing
```

### 练习5

```java
class A {
	A() {
		System.out.println("A");
	}
}

class B {
	B() {
		System.out.println("B");
	}
}

class C extends A {
	B b = new B();
	public static void main(String[] args) {
		new C();
	}
}

// A
// B
```

### 练习6

```java
class Game {
	Game(int i) {
		System.out.println("Game" + i);
	}
}

class BoardGame extends Game {
	BoardGame(int i) {
		super(i);
		System.out.println("BoardGame");
	}
}

/**
 * Chess
 */
public class Chess extends BoardGame {
	
	Chess() {
		super(11); // 去掉这条语句，会报编译错误
		System.out.println("Chess");
	}
	public static void main(String[] args) {
		new Chess();
	}
}
```

### 练习7

```java
class A {
	A(int i) {
		System.out.println("A");
	}
}

class B {
	B(int i) {
		System.out.println("B");
	}
}

class C extends A {
	B b = new B(1);
	C() {
		super(2);
	}
	public static void main(String[] args) {
		new C();
	}
}
```
### 练习8

```java
class Game {
	Game(int i) {
		System.out.println("Game" + i);
	}
}

class BoardGame extends Game {
	BoardGame() {
		super(1);
		System.out.println("BoardGame Default");
	}
	BoardGame(int i) {
		super(i);
		System.out.println("BoardGame");
	}
}
```

### 练习9

```java
class Component1 {
	Component1() {
		System.out.println("Component1");
	}
}

class Component2 {
	Component2() {
		System.out.println("Component2");
	}
}

class Component3 {
	Component3() {
		System.out.println("Component3");
	}
}

class Root {
	Component1 c1 = new Component1();
	Component2 c2 = new Component2();
	Component3 c3 = new Component3();
	Root() {
		System.out.println("Root");
	}
}

class Stem extends Root {
	Stem() {
		System.out.println("Stem");
	}

	public static void main(String[] args) {
		new Stem();
	}
}
// Component1
// Component2
// Component3
// Root
// Stem
```

### 练习10

```java
class Component1 {
	Component1(int i) {
		System.out.println("Component1");
	}
}

class Component2 {
	Component2(int i) {
		System.out.println("Component2");
	}
}

class Component3 {
	Component3(int i) {
		System.out.println("Component3");
	}
}

class Root {
	Component1 c1 = new Component1(1);
	Component2 c2 = new Component2(2);
	Component3 c3 = new Component3(3);
	Root(int i) {
		System.out.println("Root");
	}
}

class Stem extends Root {
	Stem(int j) {
		super(j);
		System.out.println("Stem");
	}

	public static void main(String[] args) {
		new Stem(2);
	}
}
```

### 练习11

```java
class DetergentDelegation {
	Detergent detergent = new Detergent();

	public void append(String a) {
		detergent.append(a);
	}

	public void dilute() {
		detergent.dilute();
	}

	public void apply() {
		detergent.apply();
	}

	public void scrub() {
		detergent.scrub();
	}

	public void foam() {
		detergent.foam();
	}

	public static void main(String[] args) {
		Detergent.main(args);
	}
}
```

### 练习12

```java
package com.company.ch07;

class Component1 {
	Component1(int i) {
		System.out.println("Component1");
	}
	void dispose() {
		System.out.println("Component1 dispose");
	}
}

class Component2 {
	Component2(int i) {
		System.out.println("Component2");
	}
	void dispose() {
		System.out.println("Component2 dispose");
	}
}

class Component3 {
	Component3(int i) {
		System.out.println("Component3");
	}
	void dispose() {
		System.out.println("Component3 dispose");
	}
}

class Root {
	Component1 c1 = new Component1(1);
	Component2 c2 = new Component2(2);
	Component3 c3 = new Component3(3);
	Root(int i) {
		System.out.println("Root");
	}
	void dispose() {
		System.out.println("root dispose");
		c1.dispose();
		c2.dispose();
		c3.dispose();
	}
}

class Stem extends Root {
	Stem(int j) {
		super(j);
		System.out.println("Stem");
	}
	void dispose() {
		System.out.println("Stem dispose");
		super.dispose();
	}
	public static void main(String[] args) {
		Stem stem = new Stem(2);
		try {
			// do something
		} finally {
			stem.dispose();
		}

	}
}
// Component1
// Component2
// Component3
// Root
// Stem
// Stem dispose
// root dispose
// Component1 dispose
// Component2 dispose
// Component3 dispose
```

### 练习13

```java
class Plate {
    Plate(int i) {
        System.out.println("Plate");
    }
    void func(int i) {
        System.out.println("func int " + i);
    }
    void func(double d) {
        System.out.println("func double " + d);
    }
    void func(String s) {
        System.out.println("func string " + s);
    }
}

class DinnerPlate extends Plate {
    DinnerPlate(int i) {
        super(i);
        System.out.println("DinnerPlate");
    }
    void func(char c) {
        System.out.println("func char " + c);
    }

    public static void main(String[] args) {
        DinnerPlate dinnerPlate = new DinnerPlate(1);
        dinnerPlate.func('c');
        dinnerPlate.func("hello");
        dinnerPlate.func(1);
        dinnerPlate.func(1.0);
    }
}
// Plate
// DinnerPlate
// func char c
// func string hello
// func int 1
// func double 1.0
```

### 练习14

```java
package com.company.ch07;

class Engine {
    public void start() {}
    public void rev() {}
    public void stop() {}
    void service() {}
}

class Wheel {
    public void inflate(int psi) {}
}

class Window {
    public void rollup() {}
    public void rolldown() {}
}

class Door {
    public Window window = new Window();
    public void open() {}
    public void close() {}
}

public class Car {
    public Engine engine = new Engine();
    public Wheel[] wheels = new Wheel[4];
    public Door left = new Door(), right = new Door();
    
    public Car() {
        for (int i = 0;i < 4; i++) {
            wheels[i] = new Wheel();
        }
    }

    public static void main(String[] args) {
        Car car = new Car();
        car.left.window.rollup();
        car.right.window.rolldown();
        car.wheels[0].inflate(72);
        car.engine.service();
    }
}
```

### 练习15

```java
package com.company.ch05;

public class Test {
    protected void func() {}
}
```

```java
package com.company.ch07;
import com.company.ch05.*;

public class Ex15 extends Test{
    public static void main(String[] args) {
        Ex15 ex15 = new Ex15();
        ex15.func();
    }
}
```


### 练习16

```java
class Amphibian {
    void func() {
    }

    static void test(Amphibian amphibian) {
        amphibian.func();
    }
}

public class Frog extends Amphibian {
    public static void main(String[] args) {
        Frog frog = new Frog();
        Amphibian.test(frog);
    }
}
```

### 练习17

```java
class Amphibian {
    void func() {
        System.out.println("Amphibian func");
    }

    static void test(Amphibian amphibian) {
        amphibian.func();
    }
}

public class Frog extends Amphibian {

    @Override
    void func() {
        System.out.println("Frog func");
    }

    public static void main(String[] args) {
        Frog frog = new Frog();
        Amphibian.test(frog);
    }
}
// Frog func
```

### 练习18

```java
public class Ex18 {
    static Random random = new Random(12);
    final int i = random.nextInt(12);
    static final int j = random.nextInt(12);

    public static void main(String[] args) {
        Ex18 ex18 = new Ex18();
        System.out.println("ex18.i = " + ex18.i);
        System.out.println("ex18.j = " + ex18.j);
        Ex18 ex181 = new Ex18();
        System.out.println("ex181.i = " + ex181.i);
        System.out.println("ex181.j = " + ex181.j);
    }
}
// ex18.i = 8
// ex18.j = 6
// ex181.i = 4
// ex181.j = 6
```

### 练习19

```java
public class Ex19 {
    final int k;
    Ex19() {
        k = 1; // 必须赋值
        // k = 2; // 会报错
    }

    public static void main(String[] args) {
        Ex19 ex19 = new Ex19();
        // ex19.k = 1; // 会报错
    }
}
```

### 练习20

```java
package com.company.ch07;

class WithFinal {
    private final void f() {
        System.out.println("WithFinal.f()");
    }

    private void g() {
        System.out.println("WithFinal.g()");
    }
}

class OverridingPrivate extends WithFinal {
//    @Override //加上注解后编译错误
    private final void f() {
        System.out.println("OverridingPrivate.f()");
    }
//    @Override //加上注解后编译错误
    private void g() {
        System.out.println("OverridingPrivate.g()");
    }
}

class OverridingPrivate2 extends OverridingPrivate {
//    @Override //加上注解后编译错误
    public final void f() {
        System.out.println("OverridingPrivate2.f()");
    }
//    @Override //加上注解后编译错误
    public void g() {
        System.out.println("OverridingPrivate2.g()");
    }
}

public class FinalOverridingIllusion extends OverridingPrivate2 {
    public static void main(String[] args) {
        OverridingPrivate2 overridingPrivate2 = new OverridingPrivate2();
        overridingPrivate2.f();
        overridingPrivate2.g();

        OverridingPrivate overridingPrivate = overridingPrivate2;
//        overridingPrivate.f(); 无法调用
//        overridingPrivate.g();
        WithFinal withFinal = overridingPrivate;
//        withFinal.f(); 无法调用
//        withFinal.g();
    }
}

```

### 练习21

```java
package com.company.ch07;

class Final {
    final void f() {}
}

public class Ex21 extends Final {
    void f() {} // 编译出错
}

```

### 练习22

```java
package com.company.ch07;

final class FinalClass {
    
}

public class Ex22 extends FinalClass { //编译出错
}
```

### 练习23

```java
class Insert {
    private int i =  9;
    protected int j;
    Insert() {
        System.out.println("i = " + i + " j = " + j);
        j = 39;
    }
    private static int x1 = printInit("static Insert.x1 init");
    static int printInit(String s) {
        System.out.println(s);
        return 47;
    }
}

public class Beetle extends Insert {
    private int k = printInit("Beetle.k init");
    public Beetle() {
        System.out.println("k = " + k);
        System.out.println("j = " + j);
    }
    private static int x2 = printInit("static Beetle.x2 init");
    public static int x3 = 3;
    public static void main(String[] args) {
        System.out.println("Beetle constructor");
        new Beetle();
    }
}

class Ex23 {
    public static void main(String[] args) {
        new Beetle();
//        static Insert.x1 init
//        static Beetle.x2 init
//        i = 9 j = 0
//        Beetle.k init
//        k = 47
//        j = 39
        // or
        // System.out.println(Beetle.x3);
//        static Insert.x1 init
//        static Beetle.x2 init
//        3
    }
}
```

### 练习24

```java
class Insert {
    private int i =  9;
    protected int j;
    Insert() {
        System.out.println("i = " + i + " j = " + j);
        j = 39;
    }
    private static int x1 = printInit("static Insert.x1 init");
    static int printInit(String s) {
        System.out.println(s);
        return 47;
    }
}

public class Beetle extends Insert {
    private int k = printInit("Beetle.k init");
    public Beetle() {
        System.out.println("k = " + k);
        System.out.println("j = " + j);
    }
    private static int x2 = printInit("static Beetle.x2 init");
    public static int x3 = 3;
    public static void main(String[] args) {
        System.out.println("Beetle constructor");
        new Beetle();
    }
}

class Ex24 extends Beetle {
    public static void main(String[] args) {
        new Ex24();
//        static Insert.x1 init
//        static Beetle.x2 init
//        i = 9 j = 0
//        Beetle.k init
//        k = 47
//        j = 39
    }
}
```

1. 调用 Ex24 的main函数（静态方法），准备加载 Ex24，但是发现其继承与 Beetle
2. 准备加载 Beetle，但是发现其继承与 Insert，因此先加载 Insert
3. Insert 中的静态数据先初始化，所以会输出`static Insert.x1 init`
4. Insert 加载并初始化完后，加载 Beetle 并对静态数据进行初始化，所以会输出`static Beetle.x2 init`
5. 然后加载 Ex24，加载过程完成，调用 main 函数
6. `new Ex24`时，实例化的顺序为 `Insert -> Beetle -> Ex24`
7. 所以先输出 Insert 构造函数中的 `i = 9 j = 0`，之所以 j 为0，是因为int默认值为0
8. 然后在实例化 Beetle 时，先会执行 实例初始化，即`private int k = printInit("Beetle.k init");`
9. 最后才是 Beetle 的构造函数。