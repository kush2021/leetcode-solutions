---
tags:
  - Medium
  - String
---

# Zigzag Conversion

## Intuition

The easiest approach to solve this problem is to consider each row as an array, traverse the string in such a way that we populate the arrays representing the rows to get the zigzag pattern, and finally read in the values from each row consecutively to get the final string. However, this costs $O(m)$ memory, where $m$ is the number of rows.

This problem can be done with constant space complexity. Instead of using rows to store the data, we just need a formula to calculate the next index of the string to append to our return value. There are two cases here for calculating the increment value; the first and last row, and all of the middle rows.

First, note that for any given row, the first character will be `s[i]` where `i` is the row we are iterating over. The first and last row for any given `numRows` value increments the index by `numRows * 2 - 2`. For the middle values, the pattern is more obscure. Consider the first example on the LeetCode website. The second row jumps by a constant value of two, two less than the jump for the first (and last) row which is four. But for the second example, the second row jumps by four, then two, then four again, etc. The third row jumps by two, then four, then two again. If you continue with examples of higher value of `numRows`, you will notice a pattern where each consecutive row starts by incrementing two less than the previous row, then immediately incrementing the difference between the initial jump (used for the first and last row) and the increment we just applied.

If we can formulate this pattern, we can loop over the string and append each character until we are finished.

## Approach

First, we can consider the trivial cases where `numRows` is one or `s.size() <= numRows`. In either case we can immediately return `s`.

We can initialize our increment value to be `numRows - 2 * 2` as we know we will need this for row one (and later for the last row). Iterate over the rows, appending the character corresponding to the current row number to our result.

Now add another loop to collect all values for the current row. The only difficult part here is to formalize our pattern we described earlier. We can see that for the first row, we can just use our existing increment value. However for middle rows, we can use this existing value _once_ before needing to calculate an intermediate jump. This intermediate jump is given by our initial increment (`numRows - 2 * 2`) minus the increment we just used. Remember to add out-of-bounds checks before appending characters here because we are incrementing manually (not through the for-loop).

At the end of the row, we can decrease the increment value used by two. If the increment becomes zero, we are at the last row and can reset it to `numRows - 2 * 2`.

## Complexity

### Time Complexity

Although we are using two for-loops, the time complexity is still $O(n)$ (where $n$ is the size of the string) because we are only reaching each character once.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
    std::string convert(std::string s, int numRows) {
      if (numRows == 1 || s.size() <= numRows) return s;
      std::string zigzag = "";
      unsigned short incr = numRows * 2 - 2;
      for (int i = 0; i < numRows; i++) {
        zigzag += s[i];
        for (int j = i; j < s.size(); ) {
          j += incr;
          if (j >= s.size()) break;
          zigzag += s[j];
          if (i != 0 && i != numRows - 1) {
            j += (numRows * 2 - 2) - incr;
            if (j >= s.size()) break;
            zigzag += s[j];
          }
        }
        incr -= 2;
        if (incr == 0) incr = numRows * 2 - 2;
      }
      return zigzag;
    }
};
```
