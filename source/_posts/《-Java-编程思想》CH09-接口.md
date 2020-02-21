---
title: 《 Java 编程思想》CH09 接口
date: 2020-02-19 11:52:21
tags:
  - Java
  - 阅读笔记
  - 《Java编程思想》
  - 后端
categories: 《Java编程思想》
---

**接口和内部类为我们提供了一种将接口与实现分离的更加结构化的方法。**

## 抽象类和抽象方法

Java 提供一个叫做“抽象方法”的机制来建立通用接口，这样不同的子类可以用不同的方式表示此接口。如`abstract void fun()`。
包含抽象方法的类叫做抽象类，如果一个类包含一个或多个抽象方法，则该类必须限定为抽象的，如`abstract class ClassName`。

如果一个从一个抽象类中继承，我们需要为基类中所有的抽象方法提供定义，否则该导出类也是抽象类，需要用`abstract`进行限定。

```java
abstract class Instrument {
    private int i;
    public abstract void play(Note n);
    public String what() { return "Instrument"; }
    public abstract void adjust();
}
```

## 接口

`interface`关键字可以产生一个完全抽象的类，它允许创建者确定方法名，参数列表和返回类型，但是没有任何方法体。**接口只提供了形式，但是没有提供任何实现**。通常，接口被用来建立类之间的协议。之所以有了抽象类后还需要接口是因为：**一个类可以实现多个接口，从而实现类似多继承的特性**。

接口有两种访问权限：

- public
- 包访问权限

接口中可以包含域，但是这些域隐式地是`public`和`static`的。接口中的方法是`public`的，因此类在实现接口时，必须指定方法为`public`的。

```java
interface InstrumentInterface {
    int VALUE = 5; // static final public
    void play(Note n); // public
    void adjust();
}

class Wind implements InstrumentInterface {
    public void play(Note n) {
        System.out.println("Wind.play() n = " + n);
    }

    public void adjust() {

    }

    public String what() {
        return "Wind";
    }
}
```

## 完全解耦

策略设计模式：创建一个能够根据所传递的参数对象的不同而具有不同行为的方法。这类方法包含要执行算法中固定不变的部分，而“策略”包含变化的部分。

```java
package com.company.ch09;

import java.util.Arrays;

class Processor {
    public String name() {
        return getClass().getSimpleName();
    }
    Object process(Object input) { return input; }
}

class Upcase extends Processor {
    String process(Object input) { // 协变返回类型
        return ((String) input).toUpperCase();
    }
}

class Downcase extends Processor {
    String process(Object input) {
        return ((String) input).toLowerCase();
    }
}

class Splitter extends Processor {
    @Override
    String process(Object input) {
        return Arrays.toString(((String) input).split(" "));
    }
}

public class Apply {
    public static void process(Processor p, Object s) {
        System.out.println("Using Processor p.name() = " + p.name());
        System.out.println(p.process(s));
    }
    public static String s = "Disagreement with beliefs is by definition incorrect";

    public static void main(String[] args) {
        process(new Upcase(), s);
        process(new Downcase(), s);
        process(new Splitter(), s);
    }
}
```

如果`Filter`类与`Processer`有相同的接口，但是它不是继承与`Processer`，那么它就不能被`Apply.proceess`所使用。这是因为`Processer`和`Apply`过于耦合了，而导致我们没法复用代码。我们可以将`Processer`转变成接口来解耦。我们可以依据接口来实现`Filter`，也可以用适配器设计模式来完成。设配器中代码将接收已有的接口/代码，实现需要的接口：

```class
class FilterAdapter implements Processor {
  Filter filter;
  public FilterAdapter(Filter filter) {
    this.filter = filter;
  }
  public String name() {
    return filter.name();
  }
  public Waveform process(Object object) {
    return filter.process((Waveform)objec);
  }
}
```

## Java 中的多重继承

Java 可以组合多个接口来实现了类似C++中的多继承。

- 实现一个接口需要保证接口中所有方法类中都有，**该方法可以继承自基类**。
- 使用接口的原因：
  - 为了能够向上转型为多个基类
  - 防止客户端创建该类的对象，并确保这个仅仅是一个接口
- 如果要创建不带任何方法定义和成员变量的基类，那就应该选择接口而不是抽象类。

```java
package com.company.ch09;

interface CanFight {
    void fight();
}

interface CanSwim {
    void swim();
}

interface CanFly {
    void fly();
}

class ActionCharacter {
    public void fight() {
    }
}

class Hero extends ActionCharacter implements CanFight, CanFly, CanSwim {
    @Override
    public void swim() {
    }

    @Override
    public void fly() {
    }

    // 注意到这里fight()函数是继承与ActionCharac
}

public class Adventure {
    public static void t(CanFight x) {
        x.fight();
    }

    public static void u(CanSwim x) {
        x.swim();
    }

    public static void v(CanFly x) {
        x.fly();
    }

    public static void w(ActionCharacter x) {
        x.fight();
    }

    public static void main(String[] args) {
        Hero h = new Hero();
        t(h);
        u(h);
        v(h);
        w(h);
    }
}
```

## 通过继承来扩展接口

- 接口可以继承一个或多个接口
- 接口中方法签名同样是由函数名和参数列表组成的，因此如果两个接口有相同函数名和参数类型的方法，并且返回类型不相同的话，则不能同时`implement`。

```java
interface CanFight {
    void fight();
}

interface CanSwim {
    void swim();
}

interface CanFightAndSwim extends CanFight, CanSwim {

}
```

## 接口中的域

接口中的的域都是 static 和 final 的，所以接口用来创建常量组，接口中定义的域不能是"空final“，但是可以被非常量表达式初始化。现在建议使用`enum`来创建。

```java
public interface RandVals {
  Random RAND = new Random(24);
  int RANDOM_INT = RAND.nextInt(10);
  long RANDOM_LONG = RAND.nextLong(20) * 10;
}
```

## 嵌套接口

接口可以嵌套在类或其他皆苦中。

嵌套在类中的接口除了 public 和包访问权限，还有 private 访问权限。

嵌套在接口中的接口自动是 public 访问权限。