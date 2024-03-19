---
tags:
  - Array
  - Greedy
  - Medium
  - Two Pointers
---

# Container With Most Water

## Intuition

To find the container with the most water, we have to consider the rectangles formed by the base and the height. The base is given by the difference of the indices of the walls we are considering and the height is given by the _minimum_ of the height of the walls we are considering.

The brute-force solution would be to find every possible rectangle and return the maximum container. However, this costs $O(n^2)$ time.

The optimal solution involves using two pointers, one at each end of the array, and searching inwards. The pointer that is moved inwards is the pointer corresponding to the limiting wall (i.e., the pointer corresponding to the minimum height).

## Approach

Initialize two pointers, one starting at the beginning of the array and one at the end. Loop until the pointers meet each other (we do not have to consider the case where the pointers are equal because we know that this container will have a value of zero).

At each iteration, we need to calculate the current area of water we can store. The base of the rectangle is given by the difference in the pointers and the height is given by the minimum wall. Next, we can modify the maximum water, if required. Finally, we need to increment the left pointer or decrement the right pointer. If the left pointer was the limiting wall, increment it. Otherwise, decrement the right pointer.

## Complexity

### Time Complexity

The time complexity is $O(n)$ because we are traversing the array only once.

### Space Complexity

The space complexity is $O(1)$ because we are only using constant variables for storage.

## Code

```cpp
class Solution {
public:
  int maxArea(std::vector<int>& height) {
    unsigned int left = 0, right = height.size() - 1, maxWater = 0;
    while (left < right) {
      maxWater = std::max(maxWater, (right - left) * std::min(height.at(left), height.at(right)));
      if (height.at(left) < height.at(right)) left++;
      else right--;
    }
    return maxWater;
  }
};
```
