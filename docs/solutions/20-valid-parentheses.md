---
tags:
  - Easy
  - Stack
  - String
---

# Valid Parentheses

## Intuition

We can utilize a stack to easily solve this problem. A stack is a last-in, first-out data structure that can remember the order in which parentheses were traversed, allowing us to remove matching parentheses when possible.

## Approach

Initialize an empty stack. For each character in the input string, if the character is an open type, we can push it onto our stack. If not, we can pop the last value from the stack and check if it is the corresponding opening parentheses for our current character. If not, we can immediately return false. If so, we can continue traversing.

Before returning true, we need to make sure the stack is empty (i.e., all open parentheses that were pushed have found a match).

## Complexity

### Time Complexity

The time complexity is $O(n)$ where $n$ is the length of the input string. This is because we are executing the algorithm once per character.

### Space Complexity

The space complexity is $O(n)$ where $n$ is the length of the input string. This is because we are using a stack which, in the worst case, will hold all $n$ parentheses (i.e., when the input only contains open parentheses).

## Code

```cpp
class Solution {
public:
  bool isValid(string s) {
    std::stack<char> parentheses;
    for (auto ch: s) {
      if (isOpenParentheses(ch)) {
        parentheses.push(ch);
      } else if (
        parentheses.empty()
        || !isParenthesesMatch(parentheses.top(), ch)
      ) {
        return false;
      } else {
        parentheses.pop();
      }
    }
    return parentheses.empty();
  }

private:
  inline bool isOpenParentheses(const char ch) {
    return (
      ch == '('
      || ch == '{'
      || ch == '['
    );
  }

  inline bool isParenthesesMatch(const char ch1, const char ch2) {
    if (ch1 == '(') {
      return (ch2 == ')');
    }
    if (ch1 == '{') {
      return (ch2 == '}');
    }
    if (ch1 == '[') {
      return (ch2 == ']');
    }
    throw;
  }
};
```
