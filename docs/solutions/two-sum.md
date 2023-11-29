---
tags:
  - easy
  - array
  - hashtable
---

# Two Sum

## Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
The naive approach to solving this problem is find each pair of integers within `nums` and checking if they add up to `target`. Finding each pair of values requires a nested loop and will cost $O(n^2)$ in efficiency.

However, this problem can be solved in $O(n)$. When we are looping through the array, we know what the corresponding number is given the current value we are iterating on. In other words, given `nums[i]`, we know that the other number we are looking for is `target - nums[i]` (since both values must add up to `target`). If we keep track of the values already encountered (along with their indices), we can do a lookup to check if the corresponding value has been found. If not, we continue iterating.

## Approach
<!-- Describe your approach to solving the problem. -->
We need a data structure which can store pairs of values and has $O(1)$ lookup time. Therefore, a hash map can be utilized to solve this problem efficiently. Loop through the array. For each number check if the complement value (`target - nums[i]`) is in the map. If so, we can return the indices. Otherwise, add the current number and its index to the map and continue looping.

## Complexity

### Time Complexity
<!-- Add your time complexity here, e.g. $$O(n)$$ -->
The time complexity is $O(n)$ because we are using a single loop which spans the length of the input array.

### Space Complexity
<!-- Add your space complexity here, e.g. $$O(n)$$ -->
The space complexity is $O(n)$ because we have a hash map that will contain up to $n$ key-value pairs.

## Code

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        std::unordered_map<int, int> num_to_index;
        for (unsigned short i = 0; i < nums.size(); i++) {
            auto it = num_to_index.find(target - nums[i]);
            if (it == num_to_index.end()) num_to_index.insert({nums[i], i});
            else return std::vector<int> {it -> second, i};
        }
        throw;
    }
};
```
