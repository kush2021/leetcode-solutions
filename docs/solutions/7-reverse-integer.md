---
tags:
  - Math
  - Medium
---

# Reverse Integer

## Intuition

This problem is only made non-trivial by the variable-size constraint.

> Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

The problem this poses is that we need a way to check if the input will overflow before we try and reverse it. Of course, you could use a string to store the number and bypass the size requirements that way, but that still takes extra memory.

Consider any given input. We know that the input is a valid, signed, 32-bit integer. It follows that we can reverse every digit _except the last_ without causing overflow. Therefore, we just need to check the last digit prior to reversing it to avoid overflow.

## Approach

Loop until the input number is zero. At the start of the iteration, extract the last digit. Next, remove the last digit from the input. We can check if our reversed number (so-far) has overflowed. If not, add the new digit to the reversed number. If we are at the last digit, we can check if the reversed value is the same as the minimum and maximum integer values. If so, we can check if the final digit causes overflow.

## Complexity

### Time Complexity

The time complexity is $O(n)$ because we are looping for each number present in the input.

### Space Complexity

The space complexity is $O(1)$ because we are not using extra space outside of the return variable.

## Code

```cpp
class Solution {
public:
    int reverse(int x) {
      const int minInt = std::numeric_limits<int>::min(), maxInt = std::numeric_limits<int>::max();
      int reverse = 0;
      while (x) {
        const short digit = x % 10;
        x /= 10;
        if ((reverse > maxInt / 10) || ((reverse == maxInt / 10) && (digit >= maxInt % 10))) return 0;
        if ((reverse < minInt / 10) || ((reverse == minInt / 10) && (digit <= minInt % 10))) return 0;
        reverse = (reverse * 10) + digit;
      }
      return reverse;
    }
};
```
