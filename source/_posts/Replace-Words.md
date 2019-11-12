---
title: Replace Words
date: 2019-11-12 13:35:18
tags:
- LeetCode
categories: LeetCode
---

> 第8天。

今天的题目是[ Replace Words ]( https://leetcode.com/problems/replace-words/ )

---

In English, we have a concept called `root`, which can be followed by some other words to form another longer word - let's call this word `successor`. For example, the root `an`, followed by `other`, which can form another word `another`.

Now, given a dictionary consisting of many roots and a sentence. You need to replace all the `successor` in the sentence with the `root` forming it. If a `successor` has many `roots` can form it, replace it with the root with the shortest length.

You need to output the sentence after the replacement.

**Example 1:**

```
Input: dict = ["cat", "bat", "rat"]
sentence = "the cattle was rattled by the battery"
Output: "the cat was rat by the bat"
```

 

**Note:**

1. The input will only have lower-case letters.
2. 1 <= dict words number <= 1000
3. 1 <= sentence words number <= 1000
4. 1 <= root length <= 100
5. 1 <= sentence words length <= 1000

---

看到题目给出了一个字符串字典，然后要根据单词中是否包含字典中的前缀来生成结果，想都不用想，就是用前缀树/字典树来做，关于前缀树的介绍可以看 https://oi-wiki.org/string/trie/ 。

首先先根据字典建立字典树，然后根据空格分隔单词，然后检查是否有前缀，如果没有前缀就将原始的单词插入结果中，如果有，则将前缀插入。由于在进行检查时，每次从一个节点跳到其子节点时都会检查者是否是一个在词典出现的前缀，所以所求的前缀一定是最短的。

具体代码如下：

```c++
struct Node {
    struct Node* childs[26];
    bool isLeaf;
    Node():isLeaf(false){
        for(int i = 0;i < 26;i++) childs[i] = nullptr;
    }
    ~Node() {
        for(int i = 0;i < 26;i++) if (childs[i]) delete childs[i];
    }

};

void insert(struct Node *root, string &s) {
    for(int i = 0, size = s.size(); i < size; i++) {
        int index = s[i] - 'a';
        if (root->childs[index] == nullptr) root->childs[index] = new Node;
        root = root->childs[index];
    }
    root->isLeaf = true;
}
int getMinLen(struct Node *root, string &sentence, int beg, int end) {
    for(int i = beg;i < end; i++) {
        int index = sentence[i] - 'a';
        if (root->childs[index] == nullptr) return end;
        root = root->childs[index];
        if (root->isLeaf) return i + 1;
    }
    return end;
}
string replaceWords(vector<string>& dict, string sentence) {
    // sort(dict.begin(), dict.end());

    // build dict tree
    struct Node *root = new Node();
    for(int i = 0;i < dict.size(); ++i) {
        insert(root, dict[i]);
    }

    struct Node * p = root;

    // parse sentence
    string res, word;
    int beg = 0;
    for(int i = 0, size = sentence.size(); i < size; i++) {
        if (sentence[i] == ' ') {
            int end = getMinLen(root, sentence, beg, i);
            for(int j = beg;j < end; j++) res.push_back(sentence[j]);
            res.push_back(' ');
            beg = i + 1;
            word = "";

        }
    }

    int end = getMinLen(root, sentence, beg, sentence.size());
    for(int j = beg;j < end; j++) res.push_back(sentence[j]);
    delete root;
    return res;
}
```


