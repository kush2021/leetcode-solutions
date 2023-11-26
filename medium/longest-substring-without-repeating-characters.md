# C++ Optimal Solution - Longest Substring Without Repeating Characters

## Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
The naive approach to solving this problem is to find all substrings and keep track of the longest one. This requires a nested loop and is inefficient. However, the problem can be solved in a single pass.

By keeping track of the last known location of any encountered character, we know exactly which part of the substring to ignore. For example, in the string "abcad", when we get to the second "a", we know that we can ignore the first "a" and start looking at the string from the "b" instead. 

## Approach
<!-- Describe your approach to solving the problem. -->
We will need two pointers, one to keep track of the start of the substring and another to keep track of the end. We will also require a hash map to remember the last known locations of characters.

Loop until the string is traversed. For each character, we need to update its location in the map. Before that, the only thing we need to check is if the current character has appeared previously, and if so, increment the left pointer to be just ahead of that last location. This guarantees that the substring between left and right has no repetitions. We also need to check that the last location is within the substring, or else the increment will actually put the left pointer behind the current location.

## Complexity

### Time Complexity:
<!-- Add your time complexity here, e.g. $$O(n)$$ -->
Since we are using a single pass, the time complexity is $O(n)$.

### Space Complexity:
<!-- Add your space complexity here, e.g. $$O(n)$$ -->
Since we are using a map that can hold up to $n$ key-value pairs, the space complexity is $O(n)$.

## Code

```cpp
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        if (s.size() == 0) return 0;
        std::unordered_map<char, int> last_location;
        unsigned short left = 0, right = 0, longest_substr = 0;
        while (right < s.size()) {
            auto it = last_location.find(s[right]);
            if (it != last_location.end() && left <= it -> second) left = it -> second + 1;
            last_location.insert_or_assign(s[right], right);
            longest_substr = std::max<unsigned short>(longest_substr, right++ - left + 1);
        }
        return longest_substr;
    }
};
```
