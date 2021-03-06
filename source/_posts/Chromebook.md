---
title: Chromebook 体验
date: 2019-10-07 19:50:44
tags: 
- Chromebook
- ChromeOS
categories:
- 杂事一堆
---

## 剁手的心路历程

### 缘起
大概是暑假的时候，刷手机的时候刷到了和Chromebook有点关系的东西吧，好像是在v2ex上看到了FydeOS的软文。随后就去了解了一下这个操作系统，从描述上来看，轻办公的话，好像还是不错的。讲道理，当时就挺心动了，好奇心驱使着我下载了FydeOS的ISO，并在U盘上体验了一番，感觉略卡，顿时就没有了兴趣，而且他们家推的那款电脑好像看起来很廉价，2k的价格为啥我不去买iPad呢？因为当时刚发布没多久好像没看到几个评测，所以慢慢就对其失去了想法，但是关于Chromebook的种子已经埋在了我心里。

### 重逢

开学没多久就到了中秋，因为是新生，所以入学那几天都是不用上课的，但是也上了一天（刚好周四课贼多），所以感觉在上那些无聊的课程时如果能有个iPad或轻薄本的话应该会挺方便的。

大概是中秋假期的某个晚上，刷手机时又刷到了和Chromebook有关的东西吧，买一台Chromebook的想法又从我心中浮起。当时刚好比较闲，在Chromebook吧上看各位老哥关于Chromebook的分享和评测，并跑去下来一个CloudReady的镜像在虚拟机上玩耍了一下。虽然说是因为比较闲才去干这些的，但是其实当时应该是算在评估Chromebook对自己是否适合了。回想一下当时得出的结果应该是这样的：

- Chromebook大多数比较轻薄，续航较好，很适合做二奶机（自己的笔记本太大太重了）
- 买对的机器的话，可以很方便的开一个Linux的虚拟机（对自己来说有一定的生产力，本人常年使用Linux）
- 很多情况需要梯子（反正我的梯子也没断过）

从上面来看，这东西应该是挺适合我的。因为贴吧有位老哥对三星那款Chromebook Plus做了评测，而且本人有点颜值党，所以对三星这款还是比较满意的。

### 剁手

由于Chromebook没有在国内发行，所以淘宝和京东什么的是搜不到什么东西的，想要买Chromebook大概就只有几种途径：

1. 海淘
2. 肉身翻出去买（因为在深圳，所以去香港澳门买东西还是比较方便的）
2. 闲鱼收二手

恩，因为价格的原因，所以我还是选择了最轻松方便的闲鱼。在多次翻阅和比较后，我发现了一个比Chromebook Plus更好的选择，那就是Chromebook Plus v2。之所以说他是更好的选择，最主要是因为当时有位老哥给出来1k4的价格（因为机器A面有个小坑和两条划痕所以才那么低的），而且这款是支持电信LTE的。剁手嘛，总是会有点冲动的，在看到这个价格后没多久，我就和那位老哥联系了一下，并拍下了这款。

## Chromebook Plus V2 体验

### 硬件篇

因为不是特别懂这块的东西，所以就不班门弄斧了，这里之见见主观的想法：

- 键盘不算好，应该是低于笔记本的平均水平的，但是也不差，起码比MacBook的好（前几天刚好去体检店玩了一下，没有回弹的键盘实在是太难受了），同时键盘和普通的有点区别，首先没有Win键（这可以理解，毕竟本来就不打算让你装window嘛），其次caps lock键被换成了搜索键（搞得我现在用其他笔记本的时候老是按caps lock），最后他的F1-F12全部被替换成了一些功能键（好像问题不大，有些情况下好像还是会映射成对于F*键的，比如开启开发者模式后，Ctrl+Shift+F*打开另一个tty，这和Linux的传统是一样的）。
- 触控板挺好用的，用来那么久了，基本没想过要插一个鼠标。
- 4G内存+32GB SSD实在是有点不够用啊，内存占有常年是满的，32GB装完系统和必要的东西后，基本上10GB都不一定有。
- 屏幕相当不错，触摸屏也挺好的。
- 摄像头没怎么体验过，两个摄像头好像都挺烂的，不过一般人也不会在笔记本上用到摄像头。
- S Pen配合一些软件用起来相当好，就是笔有点小，拿久了会不舒服。
- Chromebook Plus V2相比与Chromebook Plus多了一个LTE版本，亲测，可以插电信卡（应该是只能插电信卡），而且网络效果还行，没事不会断掉（断掉就重启），个人认为对于Chromebook这种上网本来说，随时随地的网络还是比较重要的，这也是我买V2版本的原因。

### 软件篇

这部分是这篇文章的重点（写这篇文章的主要想法就是想记录下Chromebook上一些好用的应用），主要分为3个部分来展开，这三个部分是分别从Chrome，Linux，Android三个平台来介绍各个软件。

#### Chrome

> Chrome主要是介绍一些插件和应用。

- Proxy SwitchyOmega：搭梯子时用到的
- Adblock Plus：广告拦截
- Evernote Web Clipper: 其实我已经弃用Evernote挺久的了，但是在Chromebook上Evernote的确是一个挺好的选择（主要是他安卓上优化的好，后面会提）
- OneTab：一键把所有打开的Tab收起来，在Chromebook这种小内存的机子上，这东西太有用了
- Vimium：在浏览器上使用vim快捷键，喜欢vim的和键盘党可以试一下，不适合大部分人
- All-in-One Messenger：用来打开网页版的微信还是不错的选择，但在Chromebook上用微信的次数不多，不确定有没有更好的选择
- Cog：用来看Chromebook的硬件信息的，感觉还可以，主要是能看到内存和CPU占用（Chromebook自带的任务管理器看不了，不过最近发现Ctrl + Alt + T打开crosh，里面自带了top命令，会用的人可以考虑用top）
- Google Keep：ChromeOS自带，和S Pen配合还是挺好用的，但是同步需要梯子。
- Minimalist Markdown Editor：很小巧的Markdown编辑器，这篇文章就是在这上面编辑的（当初码字还是很舒服的）
- Secure Shell App：SSH Client，大半的生产力在上面，不过对中文的兼容不是很好，主要体现在输入中文时，显示会乱掉（估计是没有实时刷新），但是现在还没有找到更好的选择。同时他还可以安装SFTP到文件管理器上，感觉还算挺好用的
- TeamViewer：TeamViewer是我见过全平台做的最好的一款产品了，虽然不常用，但是总是会有需要它的时候。
- Text：自带的文本编辑器，编辑一下简单的文本文件（比如V2ray的配置文件）还是挺好用的。
- Code Pad Text Editor: 代码编辑器，写这篇文章期间发现的，第一感觉还可以
- ~~马克飞象：用来做Markdown编辑器还是挺好的，足够好看，而且能够同步到印象笔记中，但是他要收费，所以最后还是弃了~~
- Firefox Send：传一些中小文件用的，速度上还不错，但是有点比较麻烦的就是它不是通过特殊的PIN码来分享，而是URL。把一个URL传到另一个机器上和传一个文件到另一个机器上的麻烦程度其实是一样的，个人认为这是它最大的缺点。不过我后面会有解决（妥协）办法。
- Pushbullet：一个多平台的App，可以比较方便的传输信息，文件（传文件和图片什么的其实很慢），这就是用来解决Firefox Send需要把URL传到另一个机器上的方法。

#### Linux

这部分只是简单介绍一下Chromebook上三个不同的Linux环境以及对它们的一些评价吧。

- ChromeOS
	
	众所周知，ChromeOS其实是一个Linux的发行版，所以在crosh输入shell其实是可以进入一个Linux环境的，但是ChromeOS的确不像其他常用的Linux发行版，他的终端支持的东西太少了，以至于很多东西想要安装上去其实很困难，例如如果你想要安装v2ray的话，通过go.sh其实是安装不上去的（反正我没成功）。同时，这个环境好像会因为ChromeOS的升级而被破换掉（亲身经历过，但不确定是不是运气刚好比较差）。因此，个人是不建议在这个环境安装太多东西的，不过还是有人弄出来一个ChromeOS的包管理器（chromebrew)，梯子好的话，安装起来并不困难，但是感觉没什么太大用处，我机子上只是用它安装了V2ray而已。

- Crostini

	这个东西是现在官方在推的，弄起来比较方便，在设置里面开启Linux终端，用起来还是比较方便的。这东西就是在ChromeOS上起了一个Linux的虚拟机，装的是Debian系统（有需要是可以换成其他系统的，在Reddit上有帖子介绍如何在把Debian换成Arch Linux），如果只是想要个命令行来跑一些小程序，用这个还是不错的，debian虽然装东西不如Arch那么方便，但是生态还是不错的，大部分Linux的软件都会有deb包。同时这个东西还有一点比较好的就是在这里面装GUI软件的话，其实可以很方便的在ChromeOS上打开（有点像VirtualBox的无缝模式），不过这样打开的软件是没法使用ChromeOS的输入法的，需要在debian上安装中文环境和输入法（这个网上介绍挺多的，不细讲）。BTW，由于屏幕是高分屏，然后Linux对其支持不太好，所以字体会显示的很小（有低分辨率模式，不过建议不要用，太糊了）


- Crouton

	没搞懂这东西的原理，简单介绍一下他的效果吧。看起来也像是开了一个Linux虚拟机的样子，安装时可以选择不同的发行版（不过选择不多，基本都是debian系的，比如Ubuntu，Kail），同时可以选择安装不同的桌面（比如Unity，xfce，KDE）。一般情况下打开后切换到装好的Linux系统的桌面上，然后你就可以使用这个Linux啦，就像在虚拟机里面开全屏模式一样，可以用`Ctrl + Alt + ->`和`Ctrl + Alt + <-`在ChromeOS和Linux之间切换。这东西和Crostini一样也需要自己安装中文环境和输入法。要切来切去肯定比较麻烦，但是它还有个叫xiwi的东西可以实现在ChromeOS上打开LinuxGUI应用，不过体验没有Crostini好，也一样会有高分屏的问题。
	还有一点比较重要的就是，Crouton安装起来比较麻烦，大部分包可以用镜像很快的下载下来，但是有个包没办法。个人的解决方法就是先直接用镜像安装，失败后再加http代理。

说实话，ChromeOS对Linux的支持是我最不满意的一部分，无论那种方式都有很多坑，而且有些好像没法解决（起码我现在还没有解决办法）。我现在的情况是，在ChromeOS上只使用Chromebrew安装v2ray，然后开发用Crostini。对于Crouton，我是直接弃掉了。不过Crostini中文上的确支持不好，他的终端App和Secure Shell App采用的估计是同一套代码，所以中文输入时一样会乱掉。不知道什么原因，在Crostini上使用vscode实在是太卡了，卡成PPT的那种。

#### Android

个人觉得，ChromeOS蹭Android的应用的确满足了一部分人的刚需，Android上的一部分应用在Chromebook表现的非常好，当然也有坑点，但是相对于Linux那部分，个人还是比较满意Android的表现的。

- MS Office 三件套：Word和ppt应该对大部分人来说是无法避免的东西。不过有点不好的就是，这个东西如果没有Office 365账号的话，是只能看，不能修改的。（hhh，我有学生账号）如果不想订阅Office 365的话，可以考虑下WPS，但是我感觉没有微软出的好用。BTW，**大部分Android应用在用键盘输入的时候，输入法的提示栏会跑到左上方去，所以会很难受。**
- OneDrive：同步神器（才不是因为有1TB容量我才用它的呢）
- Squid：手写神器，试了很多款，就这个好用点，做做简单的笔记，免费版其实已经够用了。其实收费版好像也就导入PDF有点吸引力，不过这东西不支持PDF的书签，能导入PDF好像也没太大作用
- Xodo：PDF神器，手写支持的很好（就是有时候有点卡）
- Evernote：点名表扬一下，这个可能是对Chromebook支持最好的了，他会把输入法的提示栏拉到当前输入的位置（虽然会闪一下，但是相比其他的好很多了）

## 总结

总的来说，Chromebook作为一个二奶机，还是很不错的选择，不贵的价格（特指二手的），足够好的屏幕和续航。虽然软件应用上还做的不够，但是这在一些轻办公环境下已经相当不错了。
