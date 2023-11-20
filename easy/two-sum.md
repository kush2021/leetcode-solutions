# C++ Optimal Solution - Two Sum

## Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
The naive approach to solving this problem is using a double loop to go through pairs of numbers in the array and find the desired values that add up to the target.

However, this problem can be solved in one pass. When we are looping through the array, we know exactly which is the corresponding number for the current number we are on (by finding the difference between the target and the current value). If we keep track of the values already encountered, we can do a lookup to check if the corresponding value has been found. If not, we continue our loop.

## Approach
<!-- Describe your approach to solving the problem. -->
We should utilize a hash map to solve this problem. A hash map provides a constant-time lookup and lets us keep track of a second value, the index (which is what we will be returning). Loop through the array and for each value, find the complement value needed to add to the target. Check if the complement is in the hash map. If so, we can return the respective indices. Otherwise, we add the current number and its index to the hash map and continue looping.

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
        std::unordered_map<int, int> found;
        for (int i = 0; i < nums.size(); i++) {
            auto it = found.find(target - nums[i]);
            if (it == found.end()) found.insert({nums[i], i});
            else return std::vector<int> {it -> second, i};
        }
        return std::vector<int> {-1, -1};
    }
};
```
