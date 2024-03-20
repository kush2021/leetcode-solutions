---
tags:
  - Bit Manipulation
  - Math
  - Medium
---

# Divide Two Integers

## Intuition

We can divide two integers following the specified rules using repeated subtraction. If we repeatedly subtract our divisor from our dividend until our dividend is no longer greater in magnitude, we can get our quotient by counting the iterations.

The problem with this approach is that it will take many iterations to complete for a very large dividend and a very small divisor. We can speed this up by doubling the divisor every time after we complete an iteration of subtraction. We will also need to increment our quotient accordingly.

To solve for integer overflow, we can use an unsigned 32-bit integer and complete the algorithm using absolute values, adding in the sign and checking for overflow at the end.

## Approach

Save the dividend and divisors as absolute values. Loop until the dividend is less than the divisor. Set a counter to zero, an extra variable to our absolute divisor, and a temporary quotient to one.

We must first check if the dividend is equal to the divisor. If so, increment the quotient and exit the loop.

Otherwise, we can add a second loop that works until our shifted divisor becomes zero (shift it past the integer limit) or our divisor is greater than our dividend. During each iteration, we can bit-shift our divisor once, increment our counter, and bit-shift our temporary quotient.

After we exit the loop, subtract the dividend by the divisor shifted `i - 1` times, where `i` is our counter. Increment our quotient by the temporary quotient shifted to the left (the iterations will shift our quotient one too many times).

Finally, we can check the sign and overflow, and return the quotient.

## Complexity

### Time Complexity

The time complexity is $O(\log(n^2))$ based on the number of iterations we must complete.

### Space Complexity

We are not using additional space to solve this problem.

## Code

```cpp
class Solution {
public:
  int divide(int dividend, int divisor) {
    unsigned int quotient = 0, absDividend = std::abs(dividend), absDivisor = std::abs(divisor);
    while (absDividend >= absDivisor) {
      unsigned int i = 0, shifted = absDivisor, tempQuotient = 1;
      if (absDividend == absDivisor) {
        quotient++;
        break;
      }
      else {
        while (shifted && absDividend > shifted) {
          shifted <<= 1;
          i++;
          tempQuotient <<= 1;
        }
        absDividend -= (absDivisor << (i - 1));
        quotient += tempQuotient >> 1;
      }
    }
    bool neg = (dividend < 0 && divisor > 0) || (dividend > 0 && divisor < 0);
    if (quotient > 2147483647 && !neg) return 2147483647;
    else if (quotient > 2147483648 && neg) return -2147483648;
    return (neg ? (-1 * quotient) : quotient);
  }
};
```
