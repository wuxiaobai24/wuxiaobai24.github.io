---
title: Queue Reconstruction by Height
date: 2018-03-04 12:50:30
tags:
- LeetCode
---

题目是[Queue Reconstruction by Height](https://leetcode.com/problems/queue-reconstruction-by-height/description/):

题目描述：

Suppose you have a random list of people standing in a queue. Each person is described by a pair of integers (h, k), where h is the height of the person and k is the number of people in front of this person who have a height greater than or equal to h. Write an algorithm to reconstruct the queue.

Note:
The number of people is less than 1,100.

Example

Input:
[[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]

Output:
[[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]

求解思路：

很好玩的题目，一开始是没有思路怎么做的，先解释一下题目先

首先它的输入是一个格式为`(h,k)`的二元组的列表，`h`表示`person`的高度，然后`k`是在队伍中站在它前面且高度大于等于他的人的个数。

我们要根据这些信息来重建这个队列（输入是乱的），是它符合上面的格式。

首先想到的就是先排序，不排序，肯定要一直扫描所有的person才能得到我们的想要的信息。

然后就按`h`的顺序来排序，当`h`相等时就按`k`排序。

按照上面的样例进行排序就得到：

```python
[[4,4], [5, 0], [5, 1], [6, 1], [7, 0], [7, 1]]
```

我们先考虑第一个位置放什么，从头开始扫描：
`[4,4]`显然不是，`[5, 0]`，因为`k`为0，所以显然就是它了，我们并不需要扫描到后面去，因为它是高度最小的且`k`为`0`的`person`,所以我们可以直接把它放到第一个位置上去，这样的话，现在我们考虑可以第二个位置了，有了放第一个的方法，我们就可以递归的去做，现在是找`[[4,4],[5,1],[6,1],[7,0],[7,1]`第一个放的位置，直接扫过去就可以得到`[7,0]`的位置，看起来好像是对的方法，但是我们很容易就发现，下一个我们就没法找出来了，因为没有`k`为`0`的`person`了，所以我们要不断的更新去做，比如`[5, 0]`移动到第一个位置需要经过`[4,4]`，那么这时`[4,4]`前面就站着一个`[5,0]`而且比他高，所以在后面的扫描中，它的`k`应该就是`3`了，`[7,0]`向前移动的时候同理，`[4,4], [5, 1], [6, 1]`的`k`都需要减一。

因为我们是不能直接修改`people`的`k`的，所以我们需要一个数组来保存。

还有一点就是上面没有考虑到高度相同的情况，比如`[7,0],[7,1]`，第二个人前面其实已经站着一个高度大于等于它的人了，其实它的`k`其实应该是`0`,而不是`1`，所以我们需要继续调整，因为可能会出现`[7,0],[7,1],[7,2]`的情况，所以在从前往后生成新的数组保存`k`值的时候，我们还需要向前扫描看前面有多少个高度相同的人才能计算出实际的`k`值，这样的时间复杂度是`O(n^2)`，所以我们不保存`k`值，我们保存`k`前面有多少个高度大于等于它的人，这样的生成辅助数据的时间复杂度就是`O(n)`了。

```cpp
class Solution {
public:
    vector<pair<int, int>> reconstructQueue(vector<pair<int, int>>& people) {

        int size = people.size();
        if (size == 0 || size == 1) return people;

        sort(people.begin(), people.end(), [](const pair<int, int> &p1,const pair<int, int> &p2) {
            return p1.first < p2.first || (p1.first == p2.first && p1.second < p2.second);
        });

        vector<int> m(size, 0);
        m[0] = 0;
        for(int i = 1;i < size;i++) {
            if (people[i].first == people[i-1].first) {
                m[i] = m[i-1] + 1;
            } else m[i] = 0;
        }
        // like insert sort.
        for(int i = 1;i < size;i++) {
            auto p = people[i];
            int t = m[i], j;
            for(j = i-1;j >= 0 && (p.second - t) < (people[j].second - m[j]) ;j--) {
                if (people[j].first <= p.first) m[j]++;
                people[j+1] = people[j];
                m[j+1] = m[j];
            }
            people[j+1] = p;
            m[j+1] = t;
        }

        return people;
    }
};
```
