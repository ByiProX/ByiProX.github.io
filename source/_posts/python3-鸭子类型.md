---
title: Python3 鸭子类型
date: 2018-03-03 01:52:21
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 鸭子类型
---

## 来源和解释
Duck typing 这个概念来源于美国印第安纳州的诗人詹姆斯·惠特科姆·莱利（James Whitcomb Riley,1849-1916）的诗句：

>" When I see a bird that walks like a duck and swims like a duck and quacks like a duck, I call that bird a duck."

中文：

>“当看到一只鸟走起来像鸭子、游泳起来像鸭子、叫起来也像鸭子，那么这只鸟就可以被称为鸭子。”

“鸭子类型”的语言是这么推断的：一只鸟走起来像鸭子、游起泳来像鸭子、叫起来也像鸭子，那它就可以被当做鸭子。也就是说，它不关注对象的类型，而是关注对象具有的行为(方法)。
<!-- more -->

鸭子类型是程序设计中的一种类型推断风格，这种风格适用于动态语言(比如PHP、Python、Ruby、Typescript、Perl、Objective-C、Lua、Julia、JavaScript、Java、Groovy、C#等)和某些静态语言(比如Golang,一般来说，静态类型语言在编译时便已确定了变量的类型，但是Golang的实现是：在编译时推断变量的类型)，支持"鸭子类型"的语言的解释器/编译器将会在解析(Parse)或编译时，推断对象的类型。

`在鸭子类型中，关注的不是对象的类型本身，而是它是如何使用的。` 例如，在不使用鸭子类型的语言中，我们可以编写一个函数，它接受一个类型为鸭的对象，并调用它的走和叫方法。在使用鸭子类型的语言中，这样的一个函数可以接受一个任意类型的对象，并调用它的走和叫方法。如果这些需要被调用的方法不存在，那么将引发一个运行时错误。任何拥有这样的正确的走和叫方法的对象都可被函数接受的这种行为引出了以上表述，这种决定类型的方式因此得名。

`鸭子类型通常得益于不测试方法和函数中参数的类型，而是依赖文档、清晰的代码和测试来确保正确使用。`从静态类型语言转向动态类型语言的用户通常试图添加一些静态的（在运行之前的）类型检查，从而影响了鸭子类型的益处和可伸缩性，并约束了语言的动态特性。


## 不足
"鸭子类型"没有任何静态检查，如类型检查、属性检查、方法签名检查等。

“鸭子类型”语言的程序可能会在运行时因为不具备某种特定的方法而抛出异常：如果一只小狗(对象)想加入合唱团(以对象会不会嘎嘎嘎叫的方法为检验标准)，也学鸭子那么嘎嘎嘎叫，好吧，它加入了，可是加入之后，却不会像鸭子那样走路，那么，迟早要出问题的。

再举个例子：一只小老鼠被猫盯上了，情急之下，它学了狗叫，猫撤了之后，小老鼠的妈妈不无感叹的对它说：看吧，我让你学的这门儿外语多么重要啊。这虽然是个段子，但是，由于猫在思考时，使用了 "鸭子测试"，它以为会叫的就是狗，会对自己产生威胁，所以撤退了，也正是因为这个错误的判断，它误失了一次进食机会。

## 静态类型语言和动态类型语言的区别

静态类型语言在编译时便已确定变量的类型，而动态类型语言的变量类型要到程序运行的时候，待变量被赋予某个值之后，才会具有某种类型。  

`静态类型语言的优点`首先是在编译时就能发现类型不匹配的错误，编辑器可以帮助我们提前避免程序在运行期间有可能发生的一些错误。其次，如果在程序中明确地规定了数据类型，编译器还可以针对这些信息对程序进行一些优化工作，提高程序执行速度。  

`静态类型语言的缺点`首先是迫使程序员依照强契约来编写程序，为每个变量规定数据类型，归根结底只是辅助我们编写可靠性高程序的一种手段，而不是编写程序的目的，毕竟大部分人编写程序的目的是为了完成需求交付生产。其次，类型的声明也会增加更多的代码，在程序编写过程中，这些细节会让程序员的精力从思考业务逻辑上分散开来。  

`动态类型语言的优点`是编写的代码数量更少，看起来也更加简洁，程序员可以把精力更多地放在业务逻辑上面。虽然不区分类型在某些情况下会让程序变得难以理解，但整体而言，代码量越少，越专注于逻辑表达，对阅读程序是越有帮助的。  
`动态类型语言的缺点`是无法保证变量的类型，从而在程序的运行期有可能发生跟类型相关的错误。

**动态类型语言对变量类型的宽容给实际编码带来了很大的灵活性。由于无需进行类型检测，我们可以尝试调用任何对象的任意方法，而无需去考虑它原本是否被设计为拥有该方法。**

## 面向接口编程

动态类型语言的面向对象设计中，鸭子类型的概念至关重要。利用鸭子类型的思想，我们不必借助`超类型`的帮助，就能轻松地在动态类型语言中实现一个原则：“面向接口编程，而不是面向实现编程”。
例如,
1. 一个对象若有push和pop方法，并且这些方法提供了正确的实现，它就可以被当作栈来使用。
2. 一个对象如果有length属性，也可以依照下标来存取属性（最好还要拥有slice和splice等方法），这个对象就可以被当作数组来使用。
3. 比如在python中，有很多file-like的东西，比如StringIO,GzipFile,socket。它们有很多相同的方法，我们把它们当作文件使用。
4. 又比如list.extend()方法中,我们并不关心它的参数是不是list,只要它是可迭代的,所以它的参数可以是list/tuple/dict/字符串/生成器等.

鸭子类型在动态语言中经常使用，非常灵活，使得python不想java那样专门去弄一大堆的设计模式。


在静态类型语言中，要实现“面向接口编程”并不是一件容易的事情，往往要通过抽象类或者接口等将对象进行`向上转型`。当对象的真正类型被隐藏在它的超类型身后，这些对象才能在`类型检查系统`的“监视”之下互相被替换使用。只有当对象能够被互相替换使用，才能体现出对象多态性的价值。

## Python中的多态

**Python中的鸭子类型允许我们使用任何提供所需方法的对象，而不需要迫使它成为一个子类。**  
由于python属于动态语言，当你定义了一个基类和基类中的方法，并编写几个继承该基类的子类时，由于python在定义变量时不指定变量的类型，而是由解释器根据变量内容推断变量类型的（也就是说变量的类型取决于所关联的对象），这就使得python的多态不像是c++或java中那样---定义一个基类类型变量而隐藏了具体子类的细节。

请看下面的例子和说明：
```python
class AudioFile:
    def __init__(self, filename):
        if not filename.endswith(self.ext):
            raise Exception("Invalid file format")
        self.filename = filename

class MP3File(AudioFile):
    ext = "mp3"
    def play(self):
        print("Playing {} as mp3".format(self.filename))

class WavFile(AudioFile):
    ext = "wav"
    def play(self):
        print("Playing {} as wav".format(self.filename))

class OggFile(AudioFile):
    ext = "ogg"
    def play(self):
        print("Playing {} as ogg".format(self.filename))

class FlacFile:
    """
    Though FlacFile class doesn't inherit AudioFile class,
    it also has the same interface as three subclass of AudioFile.

    It is called duck typing.
    """
    def __init__(self, filename):
        if not filename.endswith(".flac"):
            raise Exception("Invalid file format")
        self.filename = filename

    def play(self):
        print("Playing {} as flac".format(self.filename))


```
>Though FlacFile class doesn't inherit AudioFile class,
>it also has the same interface as three subclass of AudioFile.
>It is called duck typing.

上面的代码中，`MP3File`、`WavFile`、`OggFile`三个类型继承了`AudioFile`这一积累，而`FlacFile`没有扩展`AudioFile`，但是可以在python中使用完全相同的接口与之交互。  

因为任何提供正确接口的对象都可以在python中交替使用，它减少了多态的一般`超类`的需求。继承仍然可以用来共享代码，但是如果所有被共享的都是公共接口，鸭子类型就是所有所需的。这减少了继承的需要，同时也减少了多重继承的需要；通常，当多重继承似乎是一个有效方案的时候，我们只需要使用鸭子类型去模拟多个超类之一（定义和那个超类一样的接口和实现）就可以了。

>作者：JasonDing
>链接：https://www.jianshu.com/p/650485b78d11
>來源：简书
>著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


## 参考
1. https://baike.baidu.com/item/鸭子类型/10845665?fr=aladdin
2. https://www.jianshu.com/p/650485b78d11
