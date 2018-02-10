---
title: Group-Anagrams
date: 2017-10-15 10:32:00
categories: LeetCode
tags:
- LeetCode
---

第22天，今天刷回了`Medium`，果然这个难度才适合我。

> Given an array of strings, group anagrams together.
>
> For example, given: ["eat", "tea", "tan", "ate", "nat", "bat"], 
> Return:

```python
[
  ["ate", "eat","tea"],
  ["nat","tan"],
  ["bat"]
]
```

> Note: All inputs will be in lower-case.

题目很简短，主要的难点是怎样判断两个字符串是同组的（即`s1`是`s2`的一个置换），我的想法是利用`hash`来区分，不过这个`hash`函数写起来就比较麻烦了，主要是要考虑碰撞：

```c++
unsigned hashString(string &s) {
    int sum = 1;
    int count[26]{0};
    for(auto c:s)
        count[c-'a']++;
    for(int i = 0;i < 26;i++){
        sum = sum*133 + count[i];
    }
    return sum;
}
```

然后就是一些细节问题了：

```c++
vector<vector<string>> groupAnagrams(vector<string>& strs) {
    vector<vector<string> > ret;
    unordered_map<unsigned,int> mRet;
    int now = 0;
    for(auto &s:strs) {
        unsigned h = hashString(s);
        cout << h << endl;
        if (mRet.find(h) == mRet.end()){
            ret.push_back({});
            mRet[h] = now;
            now++;
        }
        ret[mRet[h]].push_back(s);
    }
    return ret;
}
```

`dicuss`中有另外一种`hash`的方法:

```java
public static List<List<String>> groupAnagrams(String[] strs) { 
   int[] prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103};//最多10609个z
            List<List<String>> res = new ArrayList<>();
            HashMap<Integer, Integer> map = new HashMap<>();
            for (String s : strs) {
                int key = 1;
                for (char c : s.toCharArray()) {
                    key *= prime[c - 'a'];
                }
                List<String> t;
                if (map.containsKey(key)) {
                    t = res.get(map.get(key));
                } else {
                    t = new ArrayList<>();
                    res.add(t);
                    map.put(key, res.size() - 1);
                }
                t.add(s);
            }
            return res;
    }
```

额，说实话，里面的数学依据我没看懂，是因为素数只能被1和它本身整除吗？

然后同样是在`dicuss`中看到的，对字符串`sort`来判断是否在同一组的方法：

```c++
vector<vector<string>> groupAnagrams(vector<string>& strs) {
    unordered_map<string, vector<string> > anagrams;
    for (string s: strs) {
        string sorted = s;
        sort(sorted.begin(), sorted.end());
        anagrams[sorted].push_back(s);
    }
    vector<vector<string> > res;
    for (auto p: anagrams) res.push_back(p.second);
    return res;
}
```

没想到这道题还有`solution`,里面有两个方法，一个是用sort的，和上面的差不多。另一个有趣点，通过计数来生成一个新的字符串，然后在`hash`:

```java
public List<List<String>> groupAnagrams(String[] strs) {
    if (strs.length == 0) return new ArrayList();
    Map<String, List> ans = new HashMap<String, List>();
    int[] count = new int[26];
    for (String s : strs) {
        Arrays.fill(count, 0);
        for (char c : s.toCharArray()) count[c - 'a']++;

        StringBuilder sb = new StringBuilder("");
        for (int i = 0; i < 26; i++) {
            sb.append('#');
            sb.append(count[i]);
        }
        String key = sb.toString();
        if (!ans.containsKey(key)) ans.put(key, new ArrayList());
        ans.get(key).add(s);
    }
    return new ArrayList(ans.values());
}
```

