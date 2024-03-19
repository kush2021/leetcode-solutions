---
tags:
  - Array
  - Easy
  - Two Pointers
---

# Remove Element

## Intuition

The approach for this problem is very similar to the approach used in [25 - Remove Duplicates From Sorted Array](http://localhost:8000/solutions/26-remove-duplicates-from-sorted-array/). However, instead of removing duplicate elements, we will be removing elements that are equal to `val`.

## Approach

Initialize a pointer to keep track of the next position in the array that needs to be filled.

Iterate through the array. Whenever an element not equal to `val` is encountered, assign that element to the index of our fill pointer and increment.

## Complexity

### Time Complexity

The time complexity is $O(n)$ because we need to iterate through the input array.

### Space Complexity

The space complexity is $O(1)$ because we are not using any extra space for larger input sizes.

## Code

```cpp
class Solution {
public:
  int removeElement(vector<int>& nums, int val) {
    unsigned short fillIndex = 0;
    for (unsigned short i = 0; i < nums.size(); i++) {
      if (nums.at(i) != val) {
        nums.at(fillIndex++) = nums.at(i);
      }
    }
    return fillIndex;
  }
};
```
