---
tags:
  - Dynamic Programming
  - Hard
  - Recursion
  - String
---

# Regular Expression Matching

## Intuition

To solve this problem, we need a dynamic programming approach that consider fragments of the pattern and string at a time, building up to the complete pattern and string.

Consider a table with characters of the pattern representing columns and characters of the string representing rows. We will also add an additional column and row and the start to represent the empty pattern and column. For the first cell (empty pattern and empty string), we can set this value to true (i.e., "" matches ""). For the first column, we can set all other values false (i.e., no character(s) will match with ""). The first row is a bit more tricky. We cannot set this row to false because we need to consider '\*' characters. Of course, the empty string cannot match with any characters. However, consider the string "" and the pattern "a\*". This is a valid match. The way we can check these cases is by looking at the first row and anywhere the '\*' character appears, set the current cell to the value two columns back in the same row. For instance, the first row for the string "" and pattern "a\*b\*c\*" will be TFTFTFT (consider the first empty pattern cell).

To fill out the rest of the table, we will traverse row-by-row. If the string and pattern characters match _or_ the pattern is a '.', we can set the current value to the previous diagonal value. The reason for this is because we are saying "if the pattern and string _up to the current character pair_ are a match and the current character pair is a match, then everything up to the current point is a match".

For the '\*' case, we have two sub-cases. Let's consider the case where the '\*' matches zero preceding characters. If so, we set the current cell to two previous cells (i.e., ignore the '\*' and following character). If it does match the preceding character, we can set the current cell to the value directly above.

## Approach

Let $n$ be the size of the string plus one. Let $m$ be the size of the pattern plus one.

Create an $n \times m$ matrix to represent the table with values initialized to false. The first cell will be true. Set the first row by looking for '\*' characters and setting those cells to the value present two cells back.

Traverse the rest of the table row-by-row. If there is a character match or the pattern character is a '.', set the current cell to the value immediately to the top-left. If there is a '\*' match, first check if the preceding character matches. If not, set the current cell to the value two cells back. Otherwise, if there is a character match, keep the current cell as true (if already true) or set it to the cell immediately above. Return the last cell.

## Complexity

### Time Complexity

The time complexity is $O(nm)$ because we are looping twice.

### Space Complexity

The space complexity is $O(nm)$ because we need to maintain a table.

## Code

```cpp
class Solution {
public:
  bool isMatch(std::string s, std::string p) {
    const unsigned short n = s.size() + 1, m = p.size() + 1;
    std::vector<std::vector<bool>> dp(n, std::vector<bool>(m));
    dp[0][0] = true;
    for (int i = 2; i < m; i++) if (p[i - 1] == '*') dp[0][i] = dp[0][i - 2];
    for (int i = 1; i < n; i++) {
      for (int j = 1; j < m; j++) {
        if ((p[j - 1] == '.') || (s[i - 1] == p[j - 1])) dp[i][j] = dp[i - 1][j - 1];
        else if (p[j - 1] == '*') {
          if (!dp[i][j - 1]) dp[i][j] = dp[i][j - 2];
          if ((p[j - 2] == s[i - 1]) || (p[j - 2] == '.')) dp[i][j] = (dp[i][j] || dp[i - 1][j]);
        }
      }
    }
    return dp[n - 1][m - 1];
  }
};
```
