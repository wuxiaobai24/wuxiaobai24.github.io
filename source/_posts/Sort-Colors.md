---
title: Sort Colors
date: 2017-10-19 12:28:34
categories: LeetCode
tags:
- LeetCode
- sort
---

第26天。

今天的题目是个排序问题，经过算法的实验一后，这个问题其实就比较简单啦。

> Given an array with n objects colored red, white or blue, sort them so that objects of the same color are adjacent, with the colors in the order red, white and blue.
>
> Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.
>
> Note:
> You are not suppose to use the library's sort function for this problem.

题目的意思是他会给你一个只包含`0,1,2`三个数字的数组，你要对他进行排序。

因为里面的值只有三种可能，所以显然要用**计数排序**,他的时间复杂度是`O(n)`.

用这个例子大概的说明一下计数排序的原理：

现在待排数组里的值只能是`0,1,2`，所以我们通过一个长度为3的数组来记录`0,1,2`在待排序列中出现的次数（所以这个排序才叫计数排序），计算各个元素出现的次数我们只需要简单的遍历一遍序列即可，这里的时间复杂度是`O(n)`。

假如对于一个长度为10的序列，`0`出现了3次，`1`出现了4次，`2`出现了3次，我们又知道`0<1<2`，所以排完序之后序列的前3个元素一定是0,紧接着的四个元素一定是`1`，最后三个元素一定是`2`.

所以计数排序就两个步骤：

* 遍历待排数组，记录元素出现的次数
* 通过元素出现的次数，修改待排数组

```c++
void sortColors(vector<int>& nums) {
    vector<int> count(3,0);

    for(auto i:nums)
        count[i]++;

    int i = 0,k = 0;
    while(k < nums.size()) {
        while (count[i] == 0) i++;
        nums[k] = i;
        k++;
        count[i]--;
    }
}
```

然后是在`dicuss`中看到的，模仿了快排的`patition`的方法：

```c++
void sortColors(int A[], int n) {
    int second=n-1, zero=0;
    for (int i=0; i<=second; i++) {
        while (A[i]==2 && i<second) swap(A[i], A[second--]);
        while (A[i]==0 && i>zero) swap(A[i], A[zero++]);
    }
}
```
