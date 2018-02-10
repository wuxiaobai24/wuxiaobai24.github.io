---
title: Course-Schedule
date: 2017-11-18 16:35:54
categories: LeetCode
tags:
- LeetCode
- 图
---

第52天。

---
昨晚去见了一下一起做东西的研究生师兄师姐们，感觉很`nice`,不嫌弃我什么都不会还教了我很多东西，恩，等下开始学机器学习的东西。

---

今天的题目是[Course Schedule](https://leetcode.com/problems/course-schedule/description/):

> There are a total of n courses you have to take, labeled from 0 to n - 1.
>
> Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]
>
> Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?
>
> For example:
>
> 2, [[1,0]]
> There are a total of 2 courses to take. To take course 1 you should have finished course 0. So it is possible.
>
> 2, [[1,0],[0,1]]
> There are a total of 2 courses to take. To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
>Note:
> The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how a graph is represented.
> You may assume that there are no duplicate edges in the input prerequisites.

这个问题可以转化成——有向图是否有环路。

这里是使用[拓扑排序](https://zh.wikipedia.org/zh-hans/%E6%8B%93%E6%92%B2%E6%8E%92%E5%BA%8F)做的.
拓扑排序是只能在有向无环图中进行排序，如果它有环，那么它进会出错，我们对这个图进行一次拓扑排序就可以知道这个图是不是有环了。

一开始是使用维护一个入度的数组，然后通过不断删除入度为0点的方式来完成拓扑排序的，但是超时了，所以这里用`DFS`的方法来实现，而且这种方法还比之前的要简单。

原本的`DFS`需要一个`visited`，来表示某个节点是否被访问了，这里扩展一下`visited`，原本的`visited`只有两个状态：被访问了，未被访问。
这里加入一个新的状态`访问中`,这里用`-1`来表示。

之所以要加入这个状态，是因为我们需要判断这个图是否有环路。让我们看个例子。

![mark](http://olrv1mriz.bkt.clouddn.com/blog/171118/m8Ege7CeCj.png?imageslim)

我们尝试着对这个图进行一次`DFS`:

```python
2
3->8->9->10
5->11
7
```

从上面我们可以知道这个图，需要四次调用`DFS`的递归函数才能完成整个遍历，我们认为如果某个节点在某次递归中，那么它的状态就是`访问中`,也就是说在第二次调用`DFS`的递归函数时如果访问了`3,8`节点，准备访问`9`节点时，`3`,`8`就是被访问状态，一旦访问完所以节点（也就是访问完`10`,这是在这条链路中所以节点都被访问了，递归函数开始返回，然后我们可以依次把`10`,`9`,`8`,`3`的设为`已访问`的状态。

讲了那么多，如果定义`访问中`状态，好像还没有提到他的用处，还是刚才的例子，如果上图加上一个`9->3`的边，那么我们是不是在访问`9`时，发现他可以通向一个`访问中`的节点（即`3`节点)，这时说明他们之间必定有回路。

大概的思路就是这样吧，其实看代码会简单一点：

```python
def helper(self,v,visited,graph):
    visited[v] = -1 #设置为访问中
    for i in graph[v]:
        if visited[i] == -1: #访问中
            return False
        if visited[i] == 0: #未访问
            if self.helper(i,visited,graph) == False:
                return False
    visited[v] = 1 # 递归函数开始返回了，设置为已访问的状态
    return True
def canFinish(self, numCourses, prerequisites):
    """
    :type numCourses: int
    :type prerequisites: List[List[int]]
    :rtype: bool
    """
    visited = [0]*numCourses #初始时，所有节点都未访问
    #将边集转化成邻接表
    graph = [[] for i in range(numCourses)] 
    for e in prerequisites:
        graph[e[0]].append(e[1])

    #DFS
    for i in range(numCourses):
        if visited[i] == False:
            if self.helper(i,visited,graph) == False:
                return False

    return True
```

`dicuss`中的`BFS`解法：

```c++
class Solution {
public:
    bool canFinish(int numCourses, vector<pair<int, int>>& prerequisites) {
        vector<unordered_set<int>> graph = make_graph(numCourses, prerequisites);
        vector<int> degrees = compute_indegree(graph);
        for (int i = 0; i < numCourses; i++) {
            int j = 0;
            for (; j < numCourses; j++)
                if (!degrees[j]) break;
            if (j == numCourses) return false;
            degrees[j] = -1;
            for (int neigh : graph[j])
                degrees[neigh]--;
        }
        return true;
    }
private:
    vector<unordered_set<int>> make_graph(int numCourses, vector<pair<int, int>>& prerequisites) {
        vector<unordered_set<int>> graph(numCourses);
        for (auto pre : prerequisites)
            graph[pre.second].insert(pre.first);
        return graph;
    }
    vector<int> compute_indegree(vector<unordered_set<int>>& graph) {
        vector<int> degrees(graph.size(), 0);
        for (auto neighbors : graph)
            for (int neigh : neighbors)
                degrees[neigh]++;
        return degrees;
    }
};
```

好像就是我一开始做的那种想法，但是为什么我的又没通过。
