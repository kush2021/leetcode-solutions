---
tags:
  - Easy
  - Hash Table
  - Math
  - String
---

# Roman to Integer

## Intuition

To go convert Roman numerals to integers, we just need to define when to subtract the decimal equivalent or add the decimal equivalent. For example, for the numeral VI, we want to add the numerals. For IV, we want to subtract the smaller one from the larger one.

Consider looping backwards through the numeral. We can formalize the condition for adding vs. subtracting by noticing that whenever we are subtracting, the converted value (so far) will be at least larger than five times the current value (five because that is the next step up from numeral to numeral, e.g., I to V).

## Approach

Use a hash map to define conversions between numerals and their decimal values. Loop through the string backwards. For each iteration, check if the current converted integer (the integer representing the entire converted set of characters) is larger than the single converted numeral (the character we are currently iterating on) times five. If so, we will subtract the numeral. Otherwise, we add.

## Complexity

### Time Complexity

The time complexity is $O(n)$ because we are looping through the string.

### Space Complexity

The space complexity is $O(1) because it does not depend on the input.

## Code

```cpp
class Solution {
public:
  int romanToInt(string s) {
    const std::unordered_map<char, unsigned short> conversions = {
      {'I', 1},
      {'V', 5},
      {'X', 10},
      {'L', 50},
      {'C', 100},
      {'D', 500},
      {'M', 1000}
    };
    unsigned short integer = 0;
    for (int i = s.size() - 1; i >= 0; i--) {
      const unsigned short converted = conversions.find(s[i]) -> second;
      integer = ((integer >= (5 * converted)) ? (integer - converted) : (integer + converted));
    }
    return integer;
  }
};
```
