---
title: Best Time to Buy and Sell Stock with Transaction Fee
date: 2017-10-28 13:34:16
categories: LeetCode
tags:
- LeetCode
- DP
---

第34天。

今天又没做出来，sad，同样是一道DP的题目：

> Your are given an array of integers prices, for which the i-th element is the price of a given stock on day i; and a non-negative integer fee representing a transaction fee.
>
> You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction. You may not buy more than 1 share of a stock at a time (ie. you must sell the stock share before you buy again.)
>
> Return the maximum profit you can make.
> Example 1:
> Input: prices = [1, 3, 2, 8, 4, 9], fee = 2
> Output: 8
> Explanation: The maximum profit can be achieved by:
> Buying at prices[0] = 1
> Selling at prices[3] = 8
> Buying at prices[4] = 4
> Selling at prices[5] = 9
> The total profit is ((8 - 1) - 2) + ((9 - 4) - 2) = 8.
> Note:
> 0 < prices.length <= 50000.
> 0 < prices[i] < 50000.
> 0 <= fee < 50000.

先理解一下题意先，大概是输入是一个表示股票价格的数组`prices`以及一个表示交易费用的`fee`,这个`fee`在每次交易的时候都需要支付。

然后很自然的我们会用一个`profit`的数组来记录，每天能达到的最大`profit`，然后我们也比较容易写出一个递推式：
`profit[i] = max(profit[j],profit[j] + prices[i] - prices[j] -fee) for j in range(0,i)`

然后就写出了一个`O(n^2)`的算法：

```c++
int maxProfit(vector<int>& prices, int fee) {
    if (prices.size() == 0) return 0;
    vector<int> profit(prices.size(),0);
    profit[0] = 0;
    for(int i = 1;i < profit.size();i++) {
        for(int j = i-1;j>=0;j--) {
            profit[i] = max(profit[i],profit[j]);
            int t = profit[j] + prices[i] - prices[j] - fee;
            profit[i] = max(profit[i],t);
        }
    }
    return *profit.rbegin();
}
```

然后就时间超限了。

想了一个早上也没能解决，很好又一次被`KMP`的`next`误导了，又是打算用加快内层循环的方式去做，但是还是会出现时间超限的问题。

哎，还是来看看`dicuss`中的解法吧：

```c++
int maxProfit(vector<int>& prices, int fee) {
    int s0 = 0,s1 = INT_MIN;
    for(auto p:prices) {
        int t = s0;
        s0 = max(s0,s1+p);      //sell
        s1 = max(s1,t-p-fee);   //buy
    }
    return s0;
}
```

前面的解法之所以会出现超时，就是因为他的时间复杂度为`O(n^2)`,而`dicuss`中的解法却是`O(n)`的，这里的`s0`和第一个方法的`profit`是一样的，重要的s1.

我们知道一次交易可以分为`buy`和`sell`,他们消耗一次`fee`，那么我们可以将这个`fee`归入到`buy`的时候，如果当前操作是`buy`,那么必须保证我们当前没有股票，也就是说上一次操作是`sell`,这里的`s0`就是表示没有股票的状态，`s1`表示是有股票的状态。

对于`s0`,我们想要更新它，就只有将上一个`s1`卖出，然后取最大值
对于`s1`，我们要更新它，就只有将当前股票买入，然后取最大值。

所以就得到了上面的两条式子。



