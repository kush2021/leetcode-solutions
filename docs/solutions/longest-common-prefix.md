---
tags:
  - Easy
  - String
  - Trie
---

# Longest Common Prefix

## Intuition

For this problem, we can simply iterate through the array of strings in such a way where we check each starting character. If all characters match, we can append this character to our prefix string and move onto the next character. Otherwise, we can exit the function.

## Approach

Create an empty string to hold our prefix. Loop through the size of the first string (i.e., number of characters in the first string). For each character, loop through the remaining strings in the array and check if the characters all match. If not (or if the character position is out-of-bounds), return our prefix. Otherwise, append the character to our prefix.

## Complexity

### Time Complexity

The time complexity is $O(nm)$ where $n$ is the length of the shortest string and $m$ is the length of the array.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  std::string longestCommonPrefix(std::vector<std::string>& strs) {
    std::string commonPrefix = "";
    for (int i = 0; i < strs[0].size(); i++) {
      const char possiblePrefixChar = strs[0][i];
      for (int j = 1; j < strs.size(); j++) {
        if ((i >= strs[j].size()) || (strs[j][i] != possiblePrefixChar)) return commonPrefix;
      }
      commonPrefix += possiblePrefixChar;
    }
    return commonPrefix;
  }
};
```
