---
title: Add and Search Word - Data structure design
date: 2019-12-05 12:48:24
tags:
- LeetCode
categories: LeetCode
---

> 第29天。

今天的题目是[Add and Search Word - Data structure design](https://leetcode.com/problems/add-and-search-word-data-structure-design/):

一道字典树的题目，如果知道字典树是怎样的话，应该不难做。不过这道题直接套字典树是不行的，因为它需要支持 `.` 字符来标识任意字符，所以我们在Search的时候需要做一定的修改。
简单的来说就是原本用一个指针进行搜索，现在需要一个队列来维护多个指针进行搜索，恩，仅此而已。代码如下：

```c++
class TrieNode{
    
public:
    char c;
    vector<TrieNode*> childs;
    bool flag;
    TrieNode(char _c):c(_c),childs(26, nullptr),flag(false) {
    }
    TrieNode *addChild(char c) {
        if (childs[c - 'a']) return childs[c - 'a'];
        else return childs[c - 'a'] = new TrieNode(c);
    }
};

class WordDictionary {
    TrieNode *root;
public:
    /** Initialize your data structure here. */
    WordDictionary():root(new TrieNode('?')) {
        
    }
    
    /** Adds a word into the data structure. */
    void addWord(string word) {
        //cout << "Add " << word << endl;
        TrieNode *p = root;
        for(auto c: word) {
            p = p->addChild(c);
        }
        p->flag = true;
    }
    
    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    bool search(string word) {
        // cout << "Search " << word << endl;
        queue<TrieNode *> q;
        q.push(root);
        for(auto c: word) {
            if (q.empty()) return false;
            // cout << c << " ";
            if (c == '.') {
                for(int i = 0,size = q.size();i < size; i++) {
                    TrieNode *p = q.front(); q.pop();
                    for(int j = 0;j < 26;j++) {
                        if (p->childs[j]) q.push(p->childs[j]);
                    }
                }
            } else {
                for(int i = 0,size = q.size();i < size; i++) {
                    TrieNode *p = q.front(); q.pop();
                    if (p->childs[c - 'a']) q.push(p->childs[c - 'a']);
                }
            }
        }
        while(!q.empty()) {
            if (q.front()->flag) return true;
            q.pop();
        }
        return false;
    }
};
```