---
title: Next-Permutation
date: 2017-10-10 12:50:17
categories: LeetCode
tags:
- LeetCode
---

打卡，第17天

恩，又是一道有趣的题目，不知不觉刷了12道`Medium`级别的题目了，要不要找个时间试试`hard`的？？

> Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.
>
> If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).
>
> The replacement must be in-place, do not allocate extra memory.
>
> Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
> 1,2,3 → 1,3,2
> 3,2,1 → 1,2,3
> 1,1,5 → 1,5,1

我们再观察几个示例：

> 1,2,5,4,3 -> 1,3,2,4,5
> 1,3,2,5,4 -> 1,3,4,2,5

我们的目的是：让这个序列变大一点，显然从后向前考虑会比较容易得出结果。

对于`1,2,5,4,3`，观察序列的最后，我们可以发现`4,3`是降序的，我们要让整个序列变得大一点，显然如果只修改对于`5,4,3`这个序列的顺序，我们是没法让整个序列变大的，所以我们要引入下一个数字，但是`5,4,3`也是降序的，所以我们也无法只修改后三个数字来是的序列变大，但是如果考虑`2,5,4,3`，这个序列再变大一点就是`3,2,4,5`,如果多试几次的话，就可以找出规律了：

* 我们从后向前找一个最长升序序列`nums[i:]`
* 如果`i=0`，按照题目要求，我们就应该给出一个最小的组合，就直接对`nums`进行排序即可。
* 如果`i!=0`，那么我们从后向前找第一个比`nums[i-1]`大的数字`nums[k]`，而且我们肯定能找出。交换`nums[i-1]`和`nums[k]`,然后再对`nums[i:]`进行一个排序即可。

```c++
void nextPermutation(vector<int>& nums) {
    for(int i = nums.size() - 1;i > 0;i--){
        if (nums[i-1] < nums[i]){
            int key = nums[i -1];
            int j;
            for(j = i;j < nums.size() && nums[j] > key;j++)
                /*do nothing*/;
            cout << nums[j-1] <<" " << nums[i-1];
            swap(nums[j-1],nums[i-1]);
            sort(nums.begin() + i,nums.end());
            return ;
        }
    }
    sort(nums.begin(),nums.end());
}
```

这样的话，时间复杂度是`O(nlogn)`了。其实我们要排序的序列，在某种程度上来说，他其实是降序的，我们只需要把降序换成升序即可。

```c++
void nextPermutation(vector<int>& nums) {
    int i,j = -1;
    for(i = nums.size() - 1;i > 0 && nums[i-1]>= nums[i] ;i--)
        /*do nothing*/;

    int first = i,last = nums.size()-1;

    while(first <= last) {
        if (i > 0 && nums[last] > nums[i-1]) {
            swap(nums[i-1],nums[last]);
            break;
        } else if (i > 0 && nums[first+1] <= nums[i-1] ) {
            swap(nums[i-1],nums[first]);
            break;
        }
        swap(nums[first++],nums[last--]);
    }
    while(first < last)
        swap(nums[first++],nums[last--]);
    return ;
}
```

还可以先对`nums[i:]`进行`reverse`,在找出第一个比`nums[i-1]`大的数和`nums[i-1]`进行交换。

```c++
void nextPermutation(vector<int>& nums) {
    if (nums.size() < 2) return ;
    int i,j = -1;
    for(i = nums.size() - 1;i > 0 && nums[i-1]>= nums[i] ;i--)
        /*do nothing*/;

    int first = i,last = nums.size()-1;
    while(first < last)
        swap(nums[first++],nums[last--]);
    //cout << i << endl;
    if (i > 0) {
        auto beg = nums.begin() + i;
        auto it = lower_bound(beg,nums.end(),nums[i-1]);
        //cout << *it << endl;
        while (*it == nums[i-1])
            it++;
        //cout << *it << nums[i-1] << endl;
        swap(*it,nums[i-1]);
    }
    return ;
}
```

由于`dicuss`中的都大同小异，所以就不贴`dicuss`中的算法了。