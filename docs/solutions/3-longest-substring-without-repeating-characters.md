---
tags:
  - Hash Table
  - Medium
  - Sliding Window
  - String
---

# Longest Substring Without Repeating Characters

## Description

Given a string `s`, find the length of the **longest substring** without repeating characters.

A **substring** is a contiguous **non-empty** sequence of characters within a string.

### Example 1

Input: `s = "abcabcbb"`  
Output: `3`  
Explanation: The answer is `"abc"`, with the length of `3`.

### Example 2

Input: `s = "bbbbb"`  
Output: `1`  
Explanation: The answer is `"b"`, with the length of `1`.

### Example 3

Input: `s = pwwkew`  
Output: `3`
Explanation: The answer is `"wke"`, with the length of `3`. Notice that the answer must be a substring, `"pwke"` is a subsequence and not a substring.

### Constraints

- `0 <= s.length <= 5 * 10^4`
- `s` consists of English letters, digits, symbols, and spaces.

## Intuition

The naive approach to solving this problem is to use a double-loop to consider every possible substring of `s` and find the longest one without repeating characters. However, this brute-force method is time consuming.

In order to solve similar problems with a single pass, we can use the sliding window algorithm. The sliding window algorithm will utilize a left and right index. The substring between these indices will be the current substring that we're considering.

The right index will increment every iteration. During these iterations, we can check whether or not we have found the current character already. If so, we need to consider if it was last seen _outside_ of our current substring (it's location is less than the left index). If so, we can ignore this. Otherwise, we can update the left index to be the position after the location of where the character was last seen. Finally, we can update the location of the current character.

We will also need to use a hash map to store characters and their last seen positions.

## Approach

1. Initialize an empty map, `found`, `l` and `r` indices to `0`, and a variable to keep track of the longest substring, `longest`, to `0`.

2. Loop until `r` reaches the end of the `s`.

    a. Let `char = s[r]`. If `char` is in `found` and `found[char] >= l` then update `l` to be `found[char] + 1`.

    b. Set `found[char]` to `r`.

    c. Set `longest` to the maximum of `longest` and `r - l + 1`. Increment `r`.

3. Return `longest`.

## Complexity

### Time Complexity

The time complexity is $O(n)$ where $n$ is the length of the input string `s`. This is because we need to iterate once through the entire input string.

### Space Complexity

The space complexity is $O(1)$ because we are not using additional space based on the input `s`. You might consider the hash map that is storing characters and their positions as additional space, but this hash map is bounded by a constant factor since it can only ever contain a constant number of key-value pairs as there are only a constant number of possible unique characters `s` can have, regardless of the length of `s`.

## Code

```python
class Solution:
  def lengthOfLongestSubstring(self, s: str) -> int:
    found = dict()
    l = 0
    r = 0
    longest = 0
    while r < len(s):
      char = s[r]
      if char in found and found[char] >= l:
        l = found[char] + 1
      found[char] = r
      longest = max(longest, r - l + 1)
      r += 1
    return longest
```
