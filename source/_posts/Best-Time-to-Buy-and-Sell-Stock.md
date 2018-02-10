---
title: Best Time to Buy and Sell Stock
date: 2017-11-15 08:05:42
categories: LeetCode
tags:
- LeetCode
---

第49天。

今天的题目是[Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/discuss/):

> Say you have an array for which the ith element is the price of a given stock on day i.
>
> If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit.
>
> Example 1:
> Input: [7, 1, 5, 3, 6, 4]
> Output: 5
>
> max. difference = 6-1 = 5 (not 7-1 = 6, as selling price needs to be larger than buying price)
> Example 2:
> Input: [7, 6, 4, 3, 1]
> Output: 0
>
> In this case, no transaction is done, i.e. max profit = 0.

之前好像做过一道类似的题目，但是那道题比这道题难多了，那道题是可以多次买入卖出的，而成每次交易是需要支付一定费用的，这道就简单多了，我们只需要记录当前最小元素，然后每次更新最小元素，然后记录当前元素与最小元素的差值即可。

```python
def maxProfit(self, prices):
    """
    :type prices: List[int]
    :rtype: int
    """
    profit,minElem = 0,sys.maxsize
    for p in prices:
        if p < minElem:
            minElem = p
        t = p - minElem
        if t > profit:
            profit = t
    return profit
```

然后是`c++`的解：

```c++
int maxProfit(vector<int> &prices) {
    int maxPro = 0;
    int minPrice = INT_MAX;
    for(int i = 0; i < prices.size(); i++){
        minPrice = min(minPrice, prices[i]);
        maxPro = max(maxPro, prices[i] - minPrice);
    }
    return maxPro;
}
```

以及在`dicuss`中看到的：

```java
public int maxProfit(int[] prices) {
    int maxCur = 0, maxSoFar = 0;
    for(int i = 1; i < prices.length; i++) {
        maxCur = Math.max(0, maxCur += prices[i] - prices[i-1]);
        maxSoFar = Math.max(maxCur, maxSoFar);
    }
    return maxSoFar;
}
```