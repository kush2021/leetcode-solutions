---
tags:
  - Easy
  - Math
---

# Palindrome Number

## Intuition

To check if a number is a palindrome, we simply need to reverse the number and check if it is equal to the input value.

## Approach

Copy the input value into another variable we can manipulate. We need to keep the input value untouched to check it later on. Next, we can reverse the number. At each iteration, take the last digit of the copied input and place it onto the end of the reversed digit.

## Complexity

### Time Complexity

The time complexity is $O(n)$ because we are doing $n$ iterations to reverse the number.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  bool isPalindrome(int x) {
    if (x < 0) return false;
    int xCopy = x;
    long reversed = 0;
    while (xCopy) {
      reversed = (reversed * 10) + (xCopy % 10);
      xCopy /= 10;
    }
    return (x == reversed);
  }
};
```
