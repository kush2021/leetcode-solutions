---
tags:
  - Backtracking
  - Dynamic Programming
  - Medium
  - String
---

# Generate Parentheses

## Intuition

We can solve this problem using a helper function for recursive backtracking. During each function call, there are three possible cases. Either the current string is finished, we can add an open parentheses, or we can add a closed parentheses. To check if the string is finished, we can check if its length is `n * 2`. We can add `n` open parentheses. We can add a closing parentheses as long as there are more open parentheses.

## Approach

Define a backtracking function that takes `n`, an array of strings, the current string, and the number of open parentheses. First, check if the string is finished. If not, we have if-statements. If the count of open parentheses is smaller than `n`, we can do a recursive call and add an open parentheses to our string. If there are less closed parentheses than open, we can do a recursive call and add a closed parentheses to our string. Return the array.

## Complexity

### Time Complexity

The time complexity is $O(2^n)$ where $n$ is the initial `n` value. This is because we are doing two recursive calls for each function (i.e., the branching factor of the call tree is two), and the functions are called $n$ times before terminating (i.e., the length of the call tree is $n$).

### Space Complexity

The space complexity is $O(1)$ because we are not using additional space besides our return value.

## Code

```cpp
class Solution {
public:
  std::vector<std::string> generateParenthesis(int n) {
    std::vector<std::string> parentheses;
    backtrack(n, parentheses, "", 0);
    return parentheses;
  }

private:
  void backtrack(
    const int n,
    std::vector<std::string>& parentheses,
    std::string current,
    unsigned short open
  ) {
    if (current.size() == (n * 2)) {
      parentheses.push_back(current);
    } else {
      if (open < n) {
        backtrack(n, parentheses, current + '(', open + 1);
      }
      if ((current.size() / 2) < open) {
        backtrack(n, parentheses, current + ')', open);
      }
    }
  }
};
```
