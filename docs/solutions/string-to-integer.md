---
tags:
  - Medium
  - String
---

# String to Integer

## Intuition

For this problem, we will just be implementing the algorithm provided in the description.

## Approach

I recommend splitting up the overall algorithm into multiple parts. This makes the code easier to read and debug.

First, we need to check that an empty string is not provided. Next, we can remove leading whitespace. If removing leading whitespace leaves an empty string, we can return zero. At this point, I decided to keep track of the negative and insert it later on. Then, we must format the string into a number that is ready for conversion. Disregard the string from the first non-digit to the end. Remove leading zeroes. Make sure to include checks for where the string may become empty. To convert the string, simply read in characters one by one, checking for overflow at each iteration. Luckily, we can use 64-bit integers so we don't need to work around for overflow.

## Complexity

### Time Complexity

The time complexity is $O(n)$. We are using methods and a loop which are up to $O(n)$ time.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  int myAtoi(std::string s) {
    if (s.empty()) return 0;
    s = removeLeadingWhitespace(s);
    const bool neg = (s[0] == '-');
    s = formatStr(s);
    if (s.size() == 0) return 0;
    return convert(s, neg);
  }

private:
  std::string removeLeadingWhitespace(std::string s) {
    s.erase(s.begin(), s.begin() + ((s.find_first_not_of(' ') != -1) ? s.find_first_not_of(' ') : s.size()));
    return s;
  }

  int convert(std::string s, bool neg) {
    long converted = 0;
    for (auto ch : s) {
      converted = ((converted * 10) + ((ch - '0') * (neg ? -1 : 1)));
      if (converted > std::numeric_limits<int>::max()) return std::numeric_limits<int>::max();
      if (converted < std::numeric_limits<int>::min()) return std::numeric_limits<int>::min();
    }
    return converted;
  }

  std::string formatStr(std::string s) {
    if ((s[0] == '-') || (s[0] == '+')) s.erase(s.begin(), s.begin() + 1);
    if (s.find_first_not_of("0123456789") != -1) s.erase(s.begin() + s.find_first_not_of("0123456789"), s.end());
    if (s.empty()) return s;
    s.erase(s.begin(), s.begin() + ((s.find_first_not_of('0') != -1) ? s.find_first_not_of('0') : s.size()));
    return s;
  }
};
```
