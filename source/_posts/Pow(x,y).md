---
title: 'Pow(x,n)'
categories:
  - LeetCode
tags:
  - LeetCode
  - 算法
author: wuxiaobai24
date: 2017-09-26 12:17:00
---

打卡第三天！！！

今天刷的题是[Pow(x,n)](https://leetcode.com/problems/powx-n/description/)

> implement pow(x,n)

题目相当简洁，看起来好像也不会很难的样子，不过他竟然是一道`Medium`的题目（万万没想到）.
`pow(x,n)`大家应该都多少有接触过，就是求x的n次方嘛。
我们可以把n分成三种情况去考虑：
- `n > 0` ： 可以转化成求`myPow(1/x,-n)`
- `n == 0` ：直接`return 1`即可
- `n < 0` ：这个是我们实现的关键，只要完成这个就可以AC这道题了。

首先，一个最简单的思路就是n个`x`相乘.
```c++
double ret = 1
for(int i = 0;i < n;i++)
	ret *= x;
return ret
```
这样需要做n次乘法，时间复杂度是`O(n)`,在`LeetCode`中，这样做是会超时的，我们需要找到一个 时间复杂度更小的算法。

可以考虑使用分治法去完成：
也就是说，我们要求`myPow(x,n)`的值，那我们可以转化成求`myPow(x,n/2)`的值，然后将其返回值乘二即可（n为奇数，还需要 乘多一个x）。
```c++
double ret = myPow(x,n/2);
return (n%2)?(ret*ret*x):(ret*ret);
```
这是递归的做法，显然这已经能够完成了,这也是我的做法。
这里面还有一个坑点没提到，就是在`n < 0`的情况下，我们前面的做法是直接`return myPow(1/x,-n)`的，但是这样是会出错的：
当`n=-2147483648`时，会出现`RunTime Error`，也就是那个`-n`是求不出来的，因为`int`类型的最大值为2147483647。
这里用了一个小技巧：
`return myPow(1/x, -(n + 1) ) *1/x;`
 因为这里的`n`满足`n < 0`，所以可以不用考虑正溢出的情况。
 完整的代码为：
```C++
double myPow(double x, int n) {
    if (n == 0) return 1;
    else if (n > 0) {
        double ret = myPow(x,n/2);
        return (n%2)?ret*ret*x:ret*ret;
    } else {
        //n < 0
        return myPow(1/x,-(n + 1 )) * 1/x;
    }
}
```

恩，按照惯例，看看`dicuss`中别人的做法:
```c++
double myPow(double x, int n) {
	double ans;
	unsigned long long;
	if ( n < 0 ) {
		p = -n;
		x = 1/x;
	} else {
		p = n;
	}

	while(p) {
		if (p & 1)
			ans *= x;
		x *= x;
		p >>= 1;
	}

}
```

看到这个做法的第一眼就想起了某位老师说的：
> “有时候你需要从二进制的角度去看问题。”

我们来考虑`myPow(a,7)`的情况：
`7`的二进制编码为：`0000 0111`,也就是`7 = 4 + 2 + 1`
而 $ a^{7} = a^{4} * a^{2} * a^{1} $  
相信上面的代码应该能够很容易的看懂了。
另外我们还可以看到，他用`unsigned long long`来避免溢出的情况，这也是一个小技巧。