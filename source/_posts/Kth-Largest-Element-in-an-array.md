---
title: Kth Largest Element in an array
date: 2017-11-03 08:28:57
categories: LeetCode
tags:
- LeetCode
---

第39天。

今天的题目是[Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array/description/):

> Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.
>
> For example,
> Given [3,2,1,5,6,4] and k = 2, return 5.
>
> Note:
> You may assume k is always valid, 1 ≤ k ≤ array's length.

简单的做法就是先对无序的数组进行倒序排序，然后返回`nums[k-1]`即可。

```c++
int findKthLargest(vector<int>& nums, int k) {
    sort(nums.begin(),nums.end(),[](int a,int b ){ return a > b; });
    return nums[k-1];
}
```

时间复杂度是`O(nlog(n))`.然后是利用`partition`的方法:

```c++
int findKthLargest(vector<int>& nums, int k) {
    return findKthLargest(nums,0,nums.size() - 1,k-1); 
}
int findKthLargest(vector<int> &nums,int first,int last,int k) {
    int p = partition(nums,first,last);
    if (k > p) return findKthLargest(nums,p+1,last,k);
    else if (k < p) return findKthLargest(nums,first,p-1,k);
    else return nums[p];
}
int partition(vector<int> &nums,int first,int last) {
    if (first == last) return first;
    swap(nums[first],nums[(random() % (last-first) + first)]);
    int k = nums[first];
    while(first < last) {
        while(first < last && nums[last] <= k) last--;
        nums[first] = nums[last];
        while(first < last && nums[first] >= k) first++;
        nums[last] = nums[first];
    }
    nums[first] = k;
    return first;
}
```

显然和上面快排的方法一样时间复杂度都是`O(nlogn)`.

然后是在`dicuss`中看到的用堆排的方法:

```c++
int heap_size;
inline int left(int idx) {
    return (idx << 1) + 1;
}
inline int right(int idx) {
    return (idx << 1) + 2;
}
void max_heapify(vector<int>& nums, int idx) {
    int largest = idx;
    int l = left(idx), r = right(idx);
    if (l < heap_size && nums[l] > nums[largest]) largest = l;
    if (r < heap_size && nums[r] > nums[largest]) largest = r;
    if (largest != idx) {
        swap(nums[idx], nums[largest]);
        max_heapify(nums, largest);
    }
}
void build_max_heap(vector<int>& nums) {
    heap_size = nums.size();
    for (int i = (heap_size >> 1) - 1; i >= 0; i--)
        max_heapify(nums, i);
}
int findKthLargest(vector<int>& nums, int k) {
    build_max_heap(nums);
    for (int i = 0; i < k; i++) {
        swap(nums[0], nums[heap_size - 1]);
        heap_size--;
        max_heapify(nums, 0);
    }
    return nums[heap_size];
}
```

还有用`STL`中`priority_queue`的：

```c++
int findKthLargest(vector<int>& nums, int k) {
    priority_queue<int> pq(nums.begin(), nums.end());
    for (int i = 0; i < k - 1; i++)
        pq.pop(); 
    return pq.top();
}
```