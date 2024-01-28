---
tags:
  - Backtracking
  - Hash Table
  - String
---

# Letter Combinations of a Phone Number

## Intuition

To solve this problem, we need to utilize the concept of backtracking. For each letter corresponding to each digit, we must recursively call the function to accumulate our string. Once our string is at its full value, we can append this to our result.

## Approach

Create a hash map to define the digit-to-letter conversions. We will create a second function. This function will accumulate a string. This will correspond to one string in our final output list. Hence, we need to call this function for the number combinations we have.

First, check if our string has finished accumulating. If so, we can append this value to our output list. If not, we can loop through the letters corresponding to the current digit and call backtracking by updating the accumulated string with each new character.

## Complexity

### Time Complexity

The time complexity is $O(n \cdot 4^n)$ because our backtracking tree has a depth of $n$ and the total number of combinations is $O(4^n)$.

### Space Complexity

The space complexity is $O(1)$.

## Code

```cpp
class Solution {
public:
  std::vector<std::string> letterCombinations(std::string digits) {
    const std::unordered_map<char, std::string> lettersToPhoneNumbers = {
      {'2', "abc"}, {'3', "def"}, {'4', "ghi"}, {'5', "jkl"},
      {'6', "mno"}, {'7', "pqrs"}, {'8', "tuv"}, {'9', "wxyz"}
    };
    std::vector<std::string> combinedLetters;
    if (digits.size() != 0) {
      backtrack(0, "", combinedLetters, digits, lettersToPhoneNumbers);
    }
    return combinedLetters;
  }

private:
  void backtrack(
    unsigned short i,
    std::string accumulatedLetters,
    std::vector<std::string>& combinedLetters,
    const std::string digits,
    const std::unordered_map<char, std::string> lettersToPhoneNumbers
  ) {
    if (accumulatedLetters.size() == digits.size()) {
      combinedLetters.push_back(accumulatedLetters);
    } else {
      std::string phoneNumbers = lettersToPhoneNumbers.find(digits[i]) -> second;
      for (auto ch: phoneNumbers) {
        backtrack(
          i + 1,
          accumulatedLetters + ch,
          combinedLetters,
          digits,
          lettersToPhoneNumbers
        );
      }
    }
  }
};
```
