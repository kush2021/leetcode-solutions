---
tags:
  - hashtable
  - medium
  - slidingwindow
  - string
---

# Longest Substring Without Repeating Characters

## Intuition

The naive approach to solving this problem is to use a nested loop and calculate
every possible substring in turn while keeping track of the longest substring
without repeating characters. However, this has a time complexity of $O(n^2)$.
In order to solve this question in one pass, we need to use the sliding window
approach.

The sliding window will keep track of the current substring we are considering.
Whenever we find a repeated character, we can shorten the window so that it
moves forward and excludes the last location of the repeated character. We can
continue until the window reaches the end of the string.

## Approach

Initialize two pointers, `left` and `right` to keep track of the start and end
of the window. We also need a hash table to provideconstant-time lookup for the
location of last characters found. For every iteration, first check if the
current character (note that the current character is indexed using the `right`
pointer) has already been found. If not, add the character and the current index
to the map. Otherwise, check if the previous location of the current character
is inside of our window. If not, we can just continue our loop. However, if the
previous location is inside our current window, we need to increment the start
of the window to be just after that previous location. At the end of each
iteration, calculate the maximum value of the susbtring using the current window
and the current maximum.

## Complexity

### Time Complexity

The time complexity is $O(n)$ where $n$ is the length of the input string `s`.
This is because we are looping through the entire string once and each iteration
is constant-time.

### Space Complexity

The space complexity is $O(n)$ where $n$ is the length of the input string `s`.
This is because we need space for $n$ key-value pairs (at most).

## Code

```cpp
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        if (s.size() == 0) return 0;
        unsigned short left = 0, right = 0, longestSubstr = 0;
        std::unordered_map<char, int> lastCharLocation;
        while (right < s.size()) {
            auto it = lastCharLocation.find(s[right]);
            if (it != lastCharLocation.end() && left <= it -> second) {
                left = it -> second + 1;
            }
            lastCharLocation.insert_or_assign(s[right], right);
            longestSubstr = std::max<unsigned short>(longestSubstr, right++ - left + 1);
        }
        return longestSubstr;
    }
}
```
