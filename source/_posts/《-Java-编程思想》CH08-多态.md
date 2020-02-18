---
title: 《 Java 编程思想》CH08 多态
date: 2020-02-18 11:19:00
tags:
  - Java
  - 阅读笔记
  - 《Java编程思想》
  - 后端
categories: 《Java编程思想》
---


- 在面向对象的程序设计语言中，多态是继数据抽象和继承之后的第三种基本特征。
- 多态通过分离做什么和怎么做，从另一个角度将接口和实现分离开来。
- “封装”通过合并特征和行为来创建新的数据类型。“实现隐藏”则通过将细节“私有化”把接口和实现分离开来，而多态的作用则是消除类型之间的耦合关系。

## 再论向上转型 & 转机

- 对象既可以作为它自己本身的类型使用，也可以作为它的基类使用，而这种把某个对象的引用视为其基类的引用的做法被称为“向上转型”
- 将一个方法调用同一个方法主体关联起来被称为**绑定**。
  - 若在程序执行前进行绑定（如果有的话，由编译器和链接器实现），叫做**前期绑定**。
  - 若在运行时根据对象的类型进行绑定，则叫做**后期绑定**，也叫做**动态绑定**或**运行时绑定**。
- Java 中除了 static 方法和 final 方法（private 方法属于 final 方法）外，其他所有方法都是后期绑定的。
- Java 用动态绑定实现了多态后，我们可以只编写与基类相关的代码，而这些代码可以对所有该基类的导出类正确运行。
- 多态的例子可以参考练习2。
- 在一个设计良好的 OOP 程序中，大多数或所有方法都只与基类接口通信。这样的程序是可扩展的，因为可以从通用的基类继承出新的数据类型，从而新添加一些功能。
- 域没有多态。
- 如果一个方法是静态的，那么它的行为就不具有多态性。静态方法是与类，而不是与单个对象相关联的。
- 由于 final 方法是无法覆盖的，所以 private 也是无法覆盖的，因此没办法进行动态绑定。即只有非 private 方法可以覆盖，但是“覆盖”private 方法编译器不会报错，但运行结果往往与预期不符：

```java
package com.company.ch08;

public class PrivateOverride {
    private void func() {
        System.out.println("private func()");
    }

    public static void main(String[] args) {
        PrivateOverride privateOverride = new Derived();
        privateOverride.func();
    }
}

class Derived extends PrivateOverride {
    public void func() { // 这里其实没有覆盖。
        System.out.println("Derived func()");
    }
}
// private func()
```

## 构造器和多态

**构造器不具有多态性**，它们实际上是 static 方法，只不过该 static 是隐式声明的。

### 构造器的调用顺序

- 基类的构造器总是在导出类的构造过程中调用，而且按照继承层次逐渐向上链接，以使每个基类的构造器都能得到调用。
- 在导出类的构造器主体中，如果没有明确指定调用某个基类构造器，它会默默地调用默认构造器。如果不存在默认构造器，编译器就会出错（如果某个类没有任何构造器，则编译器会给他添加一个默认构造器）

构造器的调用顺序：

1. 调用基类构造器。
2. 按照声明顺序调用成员的初始化方法。
3. 调用导出类的构造器的主体。

### 继承与清理

Java 中通常不需要考虑清理的问题，垃圾回收机制会解决大部分问题，但是如果真的需要进行清理操作时，我们需要手动调用某个特定的函数进行清理操作。因为继承的原因，我们在覆盖基类的清理函数时，需要调用基类版本的清理函数。通常在导出类清理函数的末尾。同时如果成员对象也有需要清理的话，也需要在清理函数中调用该成员的清理函数。调用的原则就是：**清理的顺序应该与初始化的顺序相同**。

如果某些成员对象存在于其他一个或多个对象共享的情况下，我们不能简单的调用其清理函数，我们可以使用“引用计数”来跟踪访问着共享对象的对象数量（就是C++中的shared_ptr）。

### 构造器内部的多态方法的行为：

如果在一个构造器的内部调用正在构造的对象的某个动态绑定方法，会发生什么？

```java
package com.company.ch08;

class Glyph {
    void draw() {
        System.out.println("Glyph.draw()");
    }
    Glyph() {
        System.out.println("Glyph() before draw()");
        draw();
        System.out.println("Glyph() after draw()");
    }
}

class RoundGlyph extends Glyph {
    private int radius = 1;
    RoundGlyph(int r) {
        radius = r;
        System.out.println("RoundGlyph.RoundGlyph(), radius = " + radius);
    }

    @Override
    void draw() {
        System.out.println("RoundGlyph.draw(), radius = " + radius);
    }
}

public class PolyConstructors {
    public static void main(String[] args) {
        new RoundGlyph(5);
    }
}
// Glyph() before draw()
// RoundGlyph.draw(), radius = 0
// Glyph() after draw()
// RoundGlyph.RoundGlyph(), radius = 5
```

从上面的输出可以看出，在基类中调用动态方法，的确会调用到对应导出类的方法，但是导出类的域却未完成初始化。

初始化实例的过程：

1. 在其他任何事物发生之前，将分配给对象的存储空间初始化成二进制的零
2. 调用基类构造器
3. 按声明顺序调用成员的初始化方法
4. 调用导出类的构造器主题。

在构造器内唯一能够安全调用的那些方法是基类中 final 方法（private 方法属于 final 方法）

## 协变返回类型

Java SE5 中添加了协变返回类型，它表示在导出类中的被覆盖方法可以返回基类方法的返回类型的某种导出类型。

```java
package com.company.ch08;

class Grain {
    @Override
    public String toString() {
        return "Grain";
    }
}

class Wheat extends Grain {
    @Override
    public String toString() {
        return "Wheat";
    }
}

class Mill {
    Grain process() {
        return new Grain();
    }
}

class WheatMill extends Mill {
    @Override
    Wheat process() { // 关键在这里，原本返回类型应该是 Grain，而这里使用了 Grain 的导出类 Wheat
        return new Wheat();
    }
}

public class CovariantReturn {
    public static void main(String[] args) {
        Mill mill = new Mill();
        Grain grain = mill.process();
        System.out.println("grain = " + grain);
        mill = new WheatMill();
        grain = mill.process();
        System.out.println("grain = " + grain);
    }
}
// grain = Grain
// grain = Wheat
```

## 用继承进行设计

我们应该首先选择“组合”，尤其是不能十分确定应该使用哪种方法时。组合不会强制我们的程序谁叫进入继承的层次结构。而且，组合更加灵活，他可以动态选择类型。

```java
package com.company.ch08;

class Actor {
    public void act() {}
}

class HappyActor extends Actor {
    @Override
    public void act() {
        System.out.println("HappyActor");
    }
}

class SadActor extends Actor {
    @Override
    public void act() {
        System.out.println("SadActor");
    }
}

class Stage {
    private Actor actor = new HappyActor();
    public void change() {
        actor = new SadActor();
    }
    public void performPlay() {
        actor.act();
    }
}

public class Transmogrify {
    public static void main(String[] args) {
        Stage stage = new Stage();
        stage.performPlay();
        stage.change();
        stage.performPlay();
    }
}
// HappyActor
// SadActor
```

我们通过在运行时将引用与不同的对象重新绑定起来，可以让我们在运行期间获得动态灵活性（也称为“状态模式”）。

**继承表示行为间的差异，字段表示状态上的变化**。

### 纯继承与扩展

- is-a 关系（纯继承）：只覆盖在基类中已有的方法，不对其进行扩展
  - 导出类和基类有完全相同的接口。
  - 只需要从导出类向上转型，永远不需要知道正在处理的对象的确切类型
- is-like-a 关系：对基类进行了扩展
  - 导出类接口中扩展部分不能被基类访问。

### 向下转型与运行时类型识别

在 Java 中，所有转型都会得到检查。即使我们只是进行一次普通的加括弧形式的类型转换，在进入运行期时仍然会对其进行检查，如果不是我们想要转换的类型，那么会返回一个 ClassCastException。

## 练习

### 练习1

```java
package com.company.ch08;

public class Cycle {
    void run() {
        System.out.println("Cycle run");
    }
}

class Unicycle extends Cycle {
    @Override
    void run() {
        System.out.println("Unicycle run");
    }
}

class Bicycle extends Cycle {
    @Override
    void run() {
        System.out.println("Bicycle run");
    }
}

class Tricycle extends Cycle {
    @Override
    void run() {
        System.out.println("Tricycle run");
    }
}

class Test {
    static void ride(Cycle c) {
        c.run();
    }
    public static void main(String[] args) {
        Unicycle unicycle = new Unicycle();
        Bicycle bicycle = new Bicycle();
        Tricycle tricycle = new Tricycle();

        unicycle.run();
        bicycle.run();
        tricycle.run();
    }
}
// Unicycle run
// Bicycle run
// Tricycle run
```

### 练习2

```java
package com.company.ch08;

public class Shape {
    public void draw() {}
    public void erase() {}
}
```

```java
package com.company.ch08;

public class Circle extends Shape{
    @Override
    public void draw() {
        System.out.println("Circle draw");
    }

    @Override
    public void erase() {
        System.out.println("Circle erase");
    }
}
```

```java
package com.company.ch08;

public class Square extends Shape{
    @Override
    public void draw() {
        System.out.println("Square draw");
    }

    @Override
    public void erase() {
        System.out.println("Square erase");
    }
}
```

```java
package com.company.ch08;

public class Triangle extends Shape {
    @Override
    public void draw() {
        System.out.println("Triangle draw");
    }

    @Override
    public void erase() {
        System.out.println("Triangle erase");
    }
}
```

```java
package com.company.ch08;

import java.util.Random;

// 工厂模式
public class RandomShapeGenerator {
    private Random random = new Random(47);
    public Shape next() {
        switch (random.nextInt(3)) {
            default:
            case 0: return new Circle();
            case 1: return new Square();
            case 2: return new Triangle();
        }
    }
}
```

```java
package com.company.ch08;

public class Shapes {
    private static RandomShapeGenerator randomShapeGenerator = new RandomShapeGenerator();

    public static void main(String[] args) {
        Shape[] shapes = new Shape[9];
        for (int i = 0;i < 9;i++) {
            shapes[i] = randomShapeGenerator.next();
        }
        for (Shape shape: shapes) {
            shape.draw();
        }
    }
}
// Triangle draw
// Triangle draw
// Square draw
// Triangle draw
// Square draw
// Triangle draw
// Square draw
// Triangle draw
// Circle draw
```

### 练习3

```java
public class Shape {
    public void draw() {}
    public void erase() {}
    public void info() {
        System.out.println("Shape info");
    }
}
```

即使导出类没有覆盖它，但是由于继承的原因，导出类任然会有该方法。

```java
package com.company.ch08;

public class Circle extends Shape{
    @Override
    public void draw() {
        System.out.println("Circle draw");
    }

    @Override
    public void erase() {
        System.out.println("Circle erase");
    }

    @Override
    public void info() {
        System.out.println("Circle info");
    }
}
```

```java
package com.company.ch08;

public class Shapes {
    private static RandomShapeGenerator randomShapeGenerator = new RandomShapeGenerator();

    public static void main(String[] args) {
        Shape[] shapes = new Shape[9];
        for (int i = 0;i < 9;i++) {
            shapes[i] = randomShapeGenerator.next();
        }
        for (Shape shape: shapes) {
            shape.info();
        }
    }
}
// Shape info
// Shape info
// Circle info
// Circle info
// Shape info
// Shape info
// Shape info
// Shape info
// Circle info
```

如果只有一个导出类Circle覆盖了该方法，只有在正式类型为Circle的Shape调用info时，才会调用到覆盖后的方法，而其余的则是调用到基类的方法。

### 练习4

```java
class Line extends Shape {
    @Override
    public void draw() {
        System.out.println("Line draw");
    }

    @Override
    public void erase() {
        System.out.println("Line erase");
    }
}

public class Shapes {
    private static RandomShapeGenerator randomShapeGenerator = new RandomShapeGenerator();

    public static void main(String[] args) {
        Shape[] shapes = new Shape[9];
        for (int i = 0;i < 9;i++) {
            shapes[i] = randomShapeGenerator.next();
        }
        for (Shape shape: shapes) {
            shape.draw();
        }
        shapes[0] = new Line();
        shapes[0].draw();
    }
}

//Shape info
//Shape info
//Circle info
//Circle info
//Shape info
//Shape info
//Shape info
//Shape info
//Circle info
```

### 练习5

```java
package com.company.ch08;

public class Cycle {
    void run() {
        System.out.println("Cycle run");
    }
    int wheels() {
        return 0;
    }
}

class Unicycle extends Cycle {
    @Override
    void run() {
        System.out.println("Unicycle run");
    }

    @Override
    int wheels() {
        return 1;
    }
}

class Bicycle extends Cycle {
    @Override
    void run() {
        System.out.println("Bicycle run");
    }

    @Override
    int wheels() {
        return 2;
    }
}

class Tricycle extends Cycle {
    @Override
    void run() {
        System.out.println("Tricycle run");
    }

    @Override
    int wheels() {
        return 3;
    }
}

class Test {
    static void ride(Cycle c) {
        c.run();
    }
    public static void main(String[] args) {
        Unicycle unicycle = new Unicycle();
        Bicycle bicycle = new Bicycle();
        Tricycle tricycle = new Tricycle();

        unicycle.run();
        bicycle.run();
        tricycle.run();

        Cycle[] cycles = new Cycle[]{unicycle, bicycle, tricycle};
        for (Cycle cycle: cycles) {
            System.out.println("cycle.wheels() = " + cycle.wheels());
        }
    }
}
// Unicycle run
// Bicycle run
// Tricycle run
// cycle.wheels() = 1
// cycle.wheels() = 2
// cycle.wheels() = 3
```

### 练习6

```java
package com.company.ch08;



enum Note {
    MIDDLE_C, C_SHARP, B_FLAT;
}

class Instrument {
    void play(Note n) {
        System.out.println("Instrument.play() n = " + n);
    }
    @Override
    public String toString() {
        return "Instrument";
    }
    void adjust() {
        System.out.println("Adusting Instrument");
    }
}

class Wind extends Instrument {
    @Override
    void play(Note n) {
        System.out.println("Wind.play() n = " + n);
    }
}

class Percussion extends Instrument {
    @Override
    void play(Note n) {
        System.out.println("Percussion.play() n = " + n);
    }

    @Override
    public String toString() {
        return "Percussion";
    }

    @Override
    void adjust() {
        System.out.println("Adjusting Percussion");
    }
}

class Stringed extends Instrument {
    @Override
    void play(Note n) {
        System.out.println("Stringed.play() n = " + n);
    }

    @Override
    public String toString() {
        return "Stringed";
    }

    @Override
    void adjust() {
        System.out.println("Adjusting Stringed");
    }

}

class Brass extends Wind {
    @Override
    void play(Note n) {
        System.out.println("Brass.play() n = " + n);
    }

    @Override
    void adjust() {
        System.out.println("Adjusting Brass");
    }
}

class Woodwind extends Wind {
    @Override
    void play(Note n) {
        System.out.println("Woodwind.play() n = " + n);
    }

    @Override
    public String toString() {
        return "Woodwind";
    }
}

public class Music3 {
    public static void tune(Instrument i) {
        i.play(Note.MIDDLE_C);
    }

    public static void tuneAll(Instrument[] instruments) {
        for (Instrument instrument: instruments) {
            tune(instrument);
        }
    }

    public static void main(String[] args) {
        Instrument[] instruments = {
                new Wind(),
                new Percussion(),
                new Stringed(),
                new Brass(),
                new Woodwind(),
        };
        tuneAll(instruments);
        for (Instrument instrument: instruments) {
            System.out.println(instrument);
        }
    }
}
// Wind.play() n = MIDDLE_C
// Percussion.play() n = MIDDLE_C
// Stringed.play() n = MIDDLE_C
// Brass.play() n = MIDDLE_C
// Woodwind.play() n = MIDDLE_C
// Instrument
// Percussion
// Stringed
// Instrument
// Woodwind
```

### 练习7

```java
class Piano extends Instrument {
    @Override
    void play(Note n) {
        System.out.println("Piano.play() n = " + n);
    }

    @Override
    public String toString() {
        return "Piano";
    }

    @Override
    void adjust() {
        System.out.println("Adjusting Piano");
    }
}

public class Music3 {
    public static void tune(Instrument i) {
        i.play(Note.MIDDLE_C);
    }

    public static void tuneAll(Instrument[] instruments) {
        for (Instrument instrument: instruments) {
            tune(instrument);
        }
    }

    public static void main(String[] args) {
        Instrument[] instruments = {
                new Wind(),
                new Percussion(),
                new Stringed(),
                new Brass(),
                new Woodwind(),
                new Piano(),
        };
        tuneAll(instruments);
        for (Instrument instrument: instruments) {
            System.out.println(instrument);
        }
    }
}
// Wind.play() n = MIDDLE_C
// Percussion.play() n = MIDDLE_C
// Stringed.play() n = MIDDLE_C
// Brass.play() n = MIDDLE_C
// Woodwind.play() n = MIDDLE_C
// Piano.play() n = MIDDLE_C
// Instrument
// Percussion
// Stringed
// Instrument
// Woodwind
// Piano
```

### 练习8

```java
class InstrumentGenerator {
    private Random random = new Random(42);
    public Instrument next() {
        switch (random.nextInt(6)) {
            default:
            case 0: return new Wind();
            case 1: return new Percussion();
            case 2: return new Stringed();
            case 3: return new Brass();
            case 4: return new Woodwind();
            case 5: return new Piano();
        }
    }
}

public class Music3 {
    public static void tune(Instrument i) {
        i.play(Note.MIDDLE_C);
    }

    public static void tuneAll(Instrument[] instruments) {
        for (Instrument instrument: instruments) {
            tune(instrument);
        }
    }



    public static void main(String[] args) {
        Instrument[] instruments = new Instrument[10];
        InstrumentGenerator instrumentGenerator = new InstrumentGenerator();
        for (int i = 0;i < 10; i++) {
            instruments[i] = instrumentGenerator.next();
        }
        tuneAll(instruments);
        for (Instrument instrument: instruments) {
            System.out.println(instrument);
        }
    }
}

// Stringed.play() n = MIDDLE_C
// Brass.play() n = MIDDLE_C
// Wind.play() n = MIDDLE_C
// Stringed.play() n = MIDDLE_C
// Wind.play() n = MIDDLE_C
// Percussion.play() n = MIDDLE_C
// Piano.play() n = MIDDLE_C
// Stringed.play() n = MIDDLE_C
// Percussion.play() n = MIDDLE_C
// Piano.play() n = MIDDLE_C
// Stringed
// Instrument
// Instrument
// Stringed
// Instrument
// Percussion
// Piano
// Stringed
// Percussion
// Piano
```

### 练习9

```java
package com.company.ch08;

public class Rodent {
    void eat() {
        System.out.println("Rodent.eat()");
    }

    public static void main(String[] args) {
        Rodent[] rodents = new Rodent[] {
                new Rodent(),
                new Mouse(),
                new Gerbil(),
                new Hamster(),
        };
        for (Rodent rodent: rodents) {
            rodent.eat();
        }
    }
}

class Mouse extends Rodent {
    @Override
    void eat() {
        System.out.println("Mouse.eat()");
    }
}

class Gerbil extends Rodent {
    @Override
    void eat() {
        System.out.println("Gerbil.eat()");
    }
}

class Hamster extends Rodent {
    @Override
    void eat() {
        System.out.println("Hamster.eat()");
    }
}
// Rodent.eat()
// Mouse.eat()
// Gerbil.eat()
// Hamster.eat()
```

### 练习10

```java
package com.company.ch08;

class Base {
    void func1() {
        func2();
    }
    void func2() {
        System.out.println("Base");
    }
}

public class Ex10 extends Base {
    @Override
    void func2() {
        System.out.println("Ex10");
    }

    public static void main(String[] args) {
        Base base = new Ex10();
        base.func1();
    }
}
// Ex10
```

因为`func2`既不是static也不是final，所以他是动态绑定的，因此基类的 func1 中调用 func2 方法也是调用到导出类的 func2。

### 练习11

```java
package com.company.ch08;

class Meal {
    Meal() {
        System.out.println("Meal()");
    }
}

class Bread {
    Bread() {
        System.out.println("Bread()");
    }
}

class Cheese {
    Cheese() {
        System.out.println("Cheese()");
    }
}

class Lettuce {
    Lettuce() {
        System.out.println("Lettuce()");
    }
}

class Lunch extends Meal {
    Lunch() {
        System.out.println("Lunch()");
    }
}

class PortableLunch extends Lunch {
    PortableLunch() {
        System.out.println("PortableLunch()");
    }
}

class Pickle {
    Pickle() {
        System.out.println("Pickle");
    }
}

public class Sandwich extends PortableLunch {
    private Bread b = new Bread();
    private Cheese c = new Cheese();
    private Lettuce l = new Lettuce();
    private Pickle p = new Pickle();
    public Sandwich() {
        System.out.println("Sandwich()");
    }

    public static void main(String[] args) {
        new Sandwich();
    }
}
```

### 练习12

```java
package com.company.ch08;

public class Rodent {
    Rodent() {
        System.out.println("Rodent");
    }
    void eat() {
        System.out.println("Rodent.eat()");
    }

    public static void main(String[] args) {
        Rodent[] rodents = new Rodent[] {
                new Rodent(),
                new Mouse(),
                new Gerbil(),
                new Hamster(),
        };
        for (Rodent rodent: rodents) {
            rodent.eat();
        }
    }
}

class Mouse extends Rodent {
    Mouse() {
        System.out.println("Mouse");
    }
    @Override
    void eat() {
        System.out.println("Mouse.eat()");
    }
}

class Gerbil extends Rodent {
    Gerbil() {
        System.out.println("Gerbil");
    }
    @Override
    void eat() {
        System.out.println("Gerbil.eat()");
    }
}

class Hamster extends Rodent {
    Hamster() {
        System.out.println("Hamster");
    }
    @Override
    void eat() {
        System.out.println("Hamster.eat()");
    }
}

```

### 练习13

```java
package com.company.ch08;

class Shared {
    private int refcount = 0;
    private static long counter = 0;
    private final long id = counter++;
    public Shared() {
        System.out.println("Create " + this);
    }
    void addRef() {
        refcount++;
    }
    protected void dispose() {
        if(--refcount == 0)
            System.out.println("Disposing " + this);
    }

    @Override
    public String toString() {
        return "Shared{" +
                "id=" + id +
                '}';
    }

    @Override
    protected void finalize() throws Throwable {
        System.out.println("finalize()");
        if (refcount != 0) {
            System.out.println("refcount != 0");
        }
        super.finalize();
    }
}

class Composing {
    private Shared shared;
    private static long counter = 0;
    private final long id = counter++;
    public Composing(Shared shared) {
        System.out.println("Creating " + this);
        this.shared = shared;
        this.shared.addRef();
    }
    protected void dispose() {
        System.out.println("disposing " + this);
        shared.dispose();
    }

    @Override
    public String toString() {
        return "Composing{" +
                "id=" + id +
                '}';
    }
}

public class ReferenceCounting {
    public static void main(String[] args) {

//        Shared shared = new Shared();
//        Composing[] composings = {
//                new Composing(shared), new Composing(shared),
//                new Composing(shared), new Composing(shared),
//                new Composing(shared)
//        };
//
//        for (Composing composing: composings) {
//            composing.dispose();
//        }
        new Composing(new Shared());
        System.gc();
    }
}
```

### 练习14

### 练习15

```java
package com.company.ch08;

class Glyph {
    void draw() {
        System.out.println("Glyph.draw()");
    }
    Glyph() {
        System.out.println("Glyph() before draw()");
        draw();
        System.out.println("Glyph() after draw()");
    }
}

class RoundGlyph extends Glyph {
    private int radius = 1;
    RoundGlyph(int r) {
        radius = r;
        System.out.println("RoundGlyph.RoundGlyph(), radius = " + radius);
    }

    @Override
    void draw() {
        System.out.println("RoundGlyph.draw(), radius = " + radius);
    }
}

class RectangularGlygh extends Glyph {
    private int length;
    RectangularGlygh(int length) {
        this.length = length;
        System.out.println("RectanguarGlygh length = " + length);
    }

    @Override
    void draw() {
        System.out.println("RectanguarGlygh.draw() length = " + length);
    }
}

public class PolyConstructors {
    public static void main(String[] args) {
        new RectangularGlygh(10);
    }
}
// Glyph() before draw()
// RectanguarGlygh.draw() length = 0
// Glyph() after draw()
// RectanguarGlygh length = 10
```

### 练习16

```java
package com.company.ch08;

class Status {
    void func() {}
}

class StatusA extends Status {
    void func() {
        System.out.println("Status A");
    }
}

class StatusB extends Status {
    void func() {
        System.out.println("Status B");
    }
}

class StatusC extends Status {
    void func() {
        System.out.println("Status C");
    }
}

class AlterStatus {
    Status status = new StatusA();
    void A() {
        status = new StatusA();
    }
    void B() {
        status = new StatusB();
    }
    void C() {
        status = new StatusC();
    }
    void call() {
        status.func();
    }
}

public class Starship {
    public static void main(String[] args) {
        AlterStatus alterStatus = new AlterStatus();
        alterStatus.call();
        alterStatus.B();
        alterStatus.call();
        alterStatus.C();
        alterStatus.call();
        alterStatus.A();
        alterStatus.call();
    }
}
// Status A
// Status B
// Status C
// Status A
```

### 练习17

```java
package com.company.ch08;

public class Cycle {
    void run() {
        System.out.println("Cycle run");
    }
    int wheels() {
        return 0;
    }
}

class Unicycle extends Cycle {
    @Override
    void run() {
        System.out.println("Unicycle run");
    }

    @Override
    int wheels() {
        return 1;
    }
    
    void balance() {}
}

class Bicycle extends Cycle {
    @Override
    void run() {
        System.out.println("Bicycle run");
    }

    @Override
    int wheels() {
        return 2;
    }

    void balance() {}
}

class Tricycle extends Cycle {
    @Override
    void run() {
        System.out.println("Tricycle run");
    }

    @Override
    int wheels() {
        return 3;
    }
}

class Test {
    static void ride(Cycle c) {
        c.run();
    }
    public static void main(String[] args) {
        


        Cycle[] cycles = new Cycle[]{new Unicycle(), new Bicycle(), new Tricycle()};
//        for(Cycle cycle: cycles) {
//            cycle.balance(); // 无法调用
//        }
        Unicycle unicycle = (Unicycle)cycles[0];
        Bicycle bicycle = (Bicycle)cycles[1];
        Tricycle tricycle = (Tricycle)cycles[2];
        
        unicycle.balance();
        bicycle.balance();
//        tricycle.balance(); //无法调用
    }
}
```