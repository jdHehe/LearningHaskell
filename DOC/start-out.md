# 从本章开始进入haskell的学习
## Haskell是一种函数式编程语言，曾写过scala对这类编程模式很有兴趣，于是开始学习Haskell，并记录这个过程，希望为有需要的同学提供帮助

首先需要安装环境，下载安装包 [download](https://www.haskell.org/platform/)。安装完毕后，进入命令行键入ghci，然后可以看到如下的界面，
```
$ ghci
WARNING: GHCi invoked via 'ghci.exe' in MinTTY consoles (e.g., Cygwin or MSYS)
         doesn't handle Ctrl-C well; use the 'ghcii.sh' shell wrapper instead
GHCi, version 8.2.2: http://www.haskell.org/ghc/  :? for help
Prelude>
```
你可以设置自己喜欢的名称 `:set prompt "youname> "`。

### Haskell语言初识

#### 算术运算和布尔运算
下图所示，是haskell中的基本运算的方式
```
Prelude> 100*100
10000
Prelude> 10/10
1.0
Prelude> 10*1.0
10.0
Prelude> 5 == 5
True
Prelude> 5 /= 4
True
Prelude> 5 /= 5
False
Prelude> not True
False
Prelude> not False
True
Prelude> True && False
False
```

haskell内置了一些基本算子，例如succ、min、max等，haskell的函数调用方式与c系语言不同，haskell不是以()作为函数调用的标志，而是用空格，例如`succ 8`就是以8为参数调用succ函数。再如，如果我们需要用8*9的结果作为参数调用succ函数，我们需要这么写`succ (8*9)`而不是`succ 8*9`这里 () 起到了运算优先级的作用。

#### 自定义函数
如上，是我们如何调用已有的函数。现在我们将试着定义我们自己的函数。
``` haskell
Prelude>  doubleMe x = x*2
Prelude>  doubleMe 2
4
Prelude>  doubleUs x y = x*2+y*2
Prelude> doubleUs 2 3
10
Prelude> doubleUs 2 3 + doubleMe 2
14
Prelude> doubleUs x y = doubleMe x + doubleMe y
```
还可以通过已有的利用已有的函数定义新的函数，例如通过doubleMe 定义doubleUs`doubleUs x y = doubleMe x + doubleMe y`，复杂的函数都是由一些简单的函数构成的。

Haskell中的不会检查函数的定义顺序，也就是说，不一定非要定义了doubleMe才能定义doubleUs。函数不能以大写字母开头，可以带有`'`字符。

Haskell是一种命令式编程语言(imperative language)，Haskell中的每一个表达式和函数都必须有返回值。

#### lists介绍
在Haskell中list是最常使用的数据结构。 Haskell中list也是同质的数据结构，它存储着多个相同类型的元素，也就是说我们不可以有一个list既有int又有string

##### list定义和操作
###### 定义
```
Prelude> let numbers=[1,2]
Prelude> str = "123"
```
正如你所见，我们定义了两个list，一个包含int的1,2的numbers，另一个包含字符的str（string也是一种list）。

###### list融合
```
Prelude> [1,2,3,4] ++ [9,10,11,12]
[1,2,3,4,9,10,11,12]
Prelude> "hello" ++ " " ++ "world"
"hello world"
5:[1,2,3,4,5]
[5,1,2,3,4,5]
```
如上显示了在连接两个list的时候采用`++`，当扩展一个元素的时候用`:`，但是如果两个的两个list的类型不一致会报错。
```
Prelude> let b = [[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]]
Prelude> b ++ [[1,1,1,1]]
[[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3],[1,1,1,1]]
Prelude> b ++ [1]

<interactive>:58:1: error:
    ? Non type-variable argument in the constraint: Num [a]
      (Use FlexibleContexts to permit this)
    ? When checking the inferred type
        it :: forall a. (Num [a], Num a) => [[a]]
```
##### 操作list的算子
利用操作符`!!` 选取list b的下标为2的
```
Prelude> b !! 2
[1,2,2,3,4]
```
`head`: 取起一个元素

`tail`: 取除去第一个元素的剩余

`last`: 取最后一个元素

`init`: 除去最后一个元素后的list

`length`: 长度

`null`: 判空

`reverse`: 对一个列表进行倒序

`take`: 从起始选取指定数目的list元素

`drop`: 和take类似，不过动作是删去

`maximum`: 选取最大的(按照一定的排序，ascii码)

`sum`: 求和

`product`: 求积

`elem`: 判断元素是否在list中


##### 利用range操作生成list
如果我想要产生1到20的list，如何可以便利的产生呢？如果我想要指定间距呢？同理如果A-Z的字母呢？如下：
```
Prelude> [1..20]
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
Prelude> [2,4..20]
[2,4,6,8,10,12,14,16,18,20]
Prelude> ['A'..'H']
"ABCDEFGH"
Prelude> ['A','C'..'Z']
"ACEGIKMOQSUWY"
```
这种方式不使用与 float 浮点数，因为会有精度误差。
`repeat`: 接受一个元素并循环产生该元素
`cycle`: 接受一个list并将其加入一个无限list中
```
Prelude>  take 10 (cycle [1,2,3])
[1,2,3,1,2,3,1,2,3,1]
Prelude> take 10 (repeat 5)
[5,5,5,5,5,5,5,5,5,5]
```

#### list 推演 (list comprehension)
利用表达式表达list的产生逻辑，并通过表达式产生list。

如果我们想要获得头十个自然偶数，我们可以采用`take 10 [2,4..]`， 当然我们也可以可以采用list comprehension的形式，我们可以从`[1..10]`获得元素，然后对每个元素*2变成偶数
```
[x*2 | x <- [1..10]]
[2,4,6,8,10,12,14,16,18,20]
```
如果我们的要求更加苛刻，我们要求大于12
```
Prelude>  [x*2 | x <- [1..10], x*2 >= 12]
[12,14,16,18,20]
```
或者我们增加一个要求，除3余数为1的数。
```
Prelude> [x*2 | x <- [1..10], x`mod`3==1]
[2,8,14,20]
```
现在我们想要将所有大于10的数用"bang"替代，小于10的用"boom", 等于10的用"ligang"替代

```
Prelude> boomBangs xs = [ if x < 10 then "BOOM!" else if x == 10 then "ligang" else "BANG!" | x <- xs, even x]
Prelude> x = [x*2 | x <- [1..10], x`mod`3==1]
Prelude>
Prelude> boomBangs x
["BOOM!","BOOM!","BANG!","BANG!"]
```
#### Tuple 二元组
当我们需要从编译期就确定list的某些类型时，如下的两种方式的区别就会显现出来了`[[1,2],[8,11],[4,5]]`和`[(1,2),(8,11),(4,5)]`后者采用了Tuple的方式组织数据，确保了这种数据形式不会被打破。

##### tuple的操作函数
`fst`: tuple的第一个元素
`snd`: 第二个元素
`zip`: 组合两个list产生tuple的list形式
```
Prelude> zip [5,3,2,6,2,7,2,5,4,6,6] ["im","a","turtle"]
[(5,"im"),(3,"a"),(2,"turtle")]
```

>hello world
