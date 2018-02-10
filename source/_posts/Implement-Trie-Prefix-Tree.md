---
title: Implement Trie(Prefix Tree)
date: 2017-11-17 09:47:05
categories: LeetCode
tags:
- Tree
---

第51天。

今天的题目是[Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/description/):

> Implement a trie with insert, search, and startsWith methods.
>
> Note:
> You may assume that all inputs are consist of lowercase letters a-z.

[Tire](https://zh.wikipedia.org/wiki/Trie)也就是前缀树，也叫字典树。

它大概是是这样子的：

- 除了root节点以外，每个节点都有一个字符。
- 从根节点到**某个节点（可以不是叶子节点）**的一条路径表示一个字符串。
- 对于某个节点其孩子节点的字符不唯一

![mark](http://olrv1mriz.bkt.clouddn.com/blog/171117/Dgeh3dCJeB.png?imageslim)

从上图可以看出每个节点都可以唯一对应一个字符串，即使每个节点只存放一个字符，但是`root`节点到这个节点的路径可以唯一确定一个字符串。

既然说它是前缀树，那肯定和前缀有关啦。两个节点所代表的字符串用公共前缀，那么`root`节点到他们的路径肯定有公共路径。

```python
class TrieNode:

        def __init__(self):
            """
            Initialize the TireNode.
            """
            self.child = {}
            self.count = 0

class Trie:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.root = TrieNode()


    def insert(self, word):
        """
        Inserts a word into the trie.
        :type word: str
        :rtype: void
        """
        p = self.root
        for c in word:
            q = p.child.get(c,None)
            if q is None:
                p.child[c] = TrieNode()
                q = p.child[c]
            p = q
        p.count += 1

    def search(self, word):
        """
        Returns if the word is in the trie.
        :type word: str
        :rtype: bool
        """
        p = self.root
        for c in word:   
            q = p.child.get(c,None)
            if q is None:
                return False
            p = q
        return p.count > 0


    def startsWith(self, prefix):
        """
        Returns if there is any word in the trie that starts with the given prefix.
        :type prefix: str
        :rtype: bool
        """
        p = self.root
        for c in prefix:
            q = p.child.get(c,None)
            if q is None:
                return False
            p = q
        return True


# Your Trie object will be instantiated and called as such:
# obj = Trie()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.startsWith(prefix)
```

因为`python`中有一些好用的数据结构，比如说`dict`，所以实现起来并不难。

贴一个`dicuss`中的`c++`解法吧，因为他这里限定了字符只是26个，所以写起来也挺方便的：

```c++
class TrieNode
{
public:
    TrieNode *next[26];
    bool is_word;

    // Initialize your data structure here.
    TrieNode(bool b = false)
    {
        memset(next, 0, sizeof(next));
        is_word = b;
    }
};

class Trie
{
    TrieNode *root;
public:
    Trie()
    {
        root = new TrieNode();
    }

    // Inserts a word into the trie.
    void insert(string s)
    {
        TrieNode *p = root;
        for(int i = 0; i < s.size(); ++ i)
        {
            if(p -> next[s[i] - 'a'] == NULL)
                p -> next[s[i] - 'a'] = new TrieNode();
            p = p -> next[s[i] - 'a'];
        }
        p -> is_word = true;
    }

    // Returns if the word is in the trie.
    bool search(string key)
    {
        TrieNode *p = find(key);
        return p != NULL && p -> is_word;
    }

    // Returns if there is any word in the trie
    // that starts with the given prefix.
    bool startsWith(string prefix)
    {
        return find(prefix) != NULL;
    }

private:
    TrieNode* find(string key)
    {
        TrieNode *p = root;
        for(int i = 0; i < key.size() && p != NULL; ++ i)
            p = p -> next[key[i] - 'a'];
        return p;
    }
};
```