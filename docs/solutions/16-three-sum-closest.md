---
tags:
  - Array
  - Two Pointers
  - Sorting
---

# Three Sum Closest

## Intuition

We will follow the same logic as [Three Sum](https://leetcode-solutions/solutions/three-sum) and change the design to return the closest sum instead of the sets of sums.

## Approach

First, sort the array. We will use a loop to fix one number. The next two numbers can be searched using a two pointer approach. If at any point the sum equals the target, we can immediately return. Update the closest sum as we continue traversal.

## Complexity

### Time Complexity

The time complexity is $O(n^2)$ because we have an outer loop and an inner two pointer search.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  int threeSumClosest(vector<int>& nums, int target) {
    int closestSum = -999999;
    std::sort(nums.begin(), nums.end());
    for (unsigned short i = 0; i < nums.size() - 1; i++) {
      const int newTarget = target - nums.at(i);
      unsigned short left = i + 1, right = nums.size() - 1;
      while (left < right) {
        const int sum = nums.at(left) + nums.at(right);
        if (sum > newTarget) {
          right--;
        } else if (sum < newTarget) {
          left++;
        } else {
          return (sum + nums.at(i));
        }
        if (std::abs(sum - newTarget) < std::abs(closestSum - target)) {
          closestSum = sum + nums.at(i);
        }
      }
    }
    return closestSum;
  }
};
```
