---
tags:
  - Hash Table
  - Math
  - Medium
  - String
---

# Integer to Roman

## Intuition

We can build up the numeric Roman value by converting the number in each decimal place (i.e., ones, tens, hundreds, thousands) to the corresponding number. All we need is a mapping from base-ten values to Roman numerals.

## Approach

Create a nested array. The outer array will contain arrays representing each decimal place value. Each inner array will contain the conversion for the corresponding index. For instance, given the hundreds array, the fifth index will contain Roman numeral D.

## Complexity

### Time Complexity

The time complexity is $O(1)$ because the program does not run longer for lengthier inputs (subject to the LeetCode constraints).

### Space Complexity

The space complexity is $O(1)$ since it does not change with respect to the input.

## Code

```cpp
class Solution {
public:
  string intToRoman(int num) {
    const std::vector<std::vector<std::string>> conversions = {
      {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
      {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"},
      {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"},
      {"", "M", "MM", "MMM"}
    };
    return (
      conversions.at(3).at((num / 1000) % 10)
      + conversions.at(2).at((num / 100) % 10)
      + conversions.at(1).at((num / 10) % 10)
      + conversions.at(0).at(num % 10)
    );
  }
};
```
