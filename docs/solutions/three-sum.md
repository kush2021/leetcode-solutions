---
tags:
  - Array
  - Two Pointers
  - Sorting
---

# Three Sum

## Intuition

This problem can be solved by fixing a number and solving the two sum problem. The only additional subproblem we need to account for is avoiding duplicates. We can also do this by sorted the input array at the beginning and skipping traversal of duplicate elements.

## Approach

Sort the input array. Use a nested for loop. At each inner iteration, check if the three values (find the third using a binary search) add to zero. If so, add this to the final solution. Increment the loop pointer to skip copied elements. Do this for both loop pointers.

## Complexity

### Time Complexity

The time complexity is $O(n^2)$ since we have two loops.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  std::vector<std::vector<int>> threeSum(std::vector<int>& nums) {
    std::vector<std::vector<int>> threeSumSet;
    std::sort(nums.begin(), nums.end());
    for (int i = 0; i < nums.size() - 1; i++) {
      for (int j = i + 1; j < nums.size(); j++) {
        if (std::binary_search(nums.begin() + j + 1, nums.end(), -nums[i] - nums[j])) {
          threeSumSet.push_back(std::vector<int> {nums[i], nums[j], -nums[i] - nums[j]});
        }
        while (j < nums.size() - 1 && nums[j] == nums[j + 1]) j++;
      }
      while (i < nums.size() - 1 && nums[i] == nums[i + 1]) i++;
    }
    return threeSumSet;
  }
};
```
