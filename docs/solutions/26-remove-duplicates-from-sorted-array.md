---
tags:
  - Array
  - Easy
  - Two Pointers
---

# Remove Duplicates From Sorted Array

## Intuition

To address this issue effectively, we must tackle two key sub-problems with optimal solutions. Firstly, we need a method to identify duplicates, and secondly, we need a strategy to shuffle the elements in-place.

Identifying duplicates can be accomplished by simply comparing the value at `nums[i]` with the value at `nums[i - 1]`. If they match, we've detected a duplicate at index `i`.

For shuffling the elements in-place, a two-pointer approach proves beneficial. One pointer traverses through each value, checking for duplicates, while the second pointer indicates the next position in the array that requires filling. Visualize this process as systematically iterating through the array and overwriting it from the beginning, ensuring only unique integers are retained.

## Approach

Let's initialize the pointer to track our position at one and set the counter for unique values to one. This is possible as we're assured of at least one value in the array.

Moving forward, we'll iterate through the array, commencing from the second value (`i = 1`). If a duplicate is encountered, we'll proceed with the iteration. Conversely, upon encountering a unique value, we'll assign this value to the array at the index indicated by our position pointer. Additionally, we'll increment our counter for unique integers.

Finally, we'll return the count of unique integers identified.

## Complexity

### Time Complexity

We need to traverse the input array once to remove all the duplicates. This gives us a time complexity of $O(n)$.

### Space Complexity

Since our memory usage is not dependent on the input array, our space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  int removeDuplicates(std::vector<int>& nums) {
    unsigned short positionToFill = 1, uniqueCount = 1;
    for (unsigned short i = 1; i < nums.size(); i++) {
      if (nums.at(i) != nums.at(i - 1)) {
        nums.at(positionToFill++) = nums.at(i);
        uniqueCount++;
      }
    }
    return uniqueCount;
  }
};
```
