---
title: Median Of Two Sorted Arrays
date: 2017-10-14 12:47:24
categories: LeetCode
tags:
- LeetCode
---

第21天，尝试了一下`hard`，结果是完全没做出来。。。从早上8点多到11点半，一直没能AC，最后只好看`dicuss`中的解法了，然后理解还理解了很久。。。看了现在的我还不适合做`hard`级别的。

> There are two sorted arrays nums1 and nums2 of size m and n respectively.
>
> Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
> Example 1:
> nums1 = [1, 3]
> nums2 = [2]
>
> The median is 2.0
> Example 2:
> nums1 = [1, 2]
> nums2 = [3, 4]
>
> The median is (2 + 3)/2 = 2.5

因为没做出来，所以只能写写别人的思路了。

我们现在要找的是中位数，那么就有两种情况：

* 整体长度是奇数，那么中位数是序列中的数
* 整体长度是偶数，那么中位数是序列中两个数的平均值。

先考虑奇数的情况，因为是序列中的数，所以我们现在要求的就是在两个序列中第`（size)/2 + 1`大的数。

现在问题转换成在两个序列中求第k个数：

不断的将`k`减半，并把小的数从序列中排出，每次都能排出掉`k/2`.

```c++
double getKth(vector<int> &nums1,int beg1,int size1,vector<int> &nums2,int beg2,int size2,int k) {
        //cout << beg1<<" " <<size1<<"\t"<<beg2<<" "<<size2<<"\t"<<k<<endl;
        if (size1 > size2) {
                return getKth(nums2,beg2,size2,nums1,beg1,size1,k);
        }

        if (size1 == 0) { return nums2[beg2 + k-1];}
        if (k == 1) return min(nums1[beg1],nums2[beg2]);

        int i = min(size1,k/2);
        int j = min(size2,k/2);

        if (nums1[beg1 + i-1] > nums2[beg2 + j-1]) {
            return getKth(nums1,beg1,size1,nums2,beg2+j,size2-j,k-j);
        } else
            return getKth(nums1,beg1+i,size1-i,nums2,beg2,size2,k-i);
    }
```

考虑偶数的情况，我们只要找出第`(size)/2 + 1`和`(size)/2`的大的数的平均值即可。

将两者统一一下：

```c++
double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
    int l = (nums1.size() + nums2.size() + 1) >> 1;
    int r = (nums1.size() + nums2.size() + 2) >> 1;
    //cout << "#" << l << r << endl;
    double dl = getKth(nums1,0,nums1.size(),nums2,0,nums2.size(),l); 
    double dr = getKth(nums1,0,nums1.size(),nums2,0,nums2.size(),r);
    //cout << dl <<dr << endl;
    return (dr+dl)/2;
}
```

恩，等下次感觉有能力做了，在来尝试一次！！！