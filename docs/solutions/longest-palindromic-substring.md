---
tags:
  - Dynamic Programming
  - Medium
  - String
---

# Longest Palindromic Substring

## Intuition

Without loss of generality, we can assume the longest palindrome is odd. The naive approach to solving this algorithm uses an $O(n^3)$ approach to check all possible substrings.

We can solve this problem more efficiently by considering a single loop of the input string. For each character, assume it is a center of a palindrome and expand outwards. Doing this for all characters will give us the longest palindromic substring for the input array. This approach is $O(n^2)$.

We can also solve this problem in linear time by using [Manacher's Algorithm](https://www.youtube.com/watch?v=V-sEwsca1ak). The idea behind this algorithm follows from the previous approach. However, by knowing the lengths of previously calculated palindromes, we can skip checking certain centers because we can mathematically prove that the palindrome surrounding that center is no better than our current longest palindrome. This is best illustrated with an example.

Assume we have the string "abaxabaxabb". We will expand around the first character ('a') and see that the palindrome around that center is one. Next, we must expand around the first 'b'. The palindrome surrounding that center is three. Similarly, the 'x' is a palindrome of 7. Now, we can demonstrate Manacher's algorithm to choose the next center. If we look at the letters following 'x' that are contained within the palindrome surrounding 'x', we have an 'a', 'b', and 'a'. Without any calculations, we can conclude that the first 'a' must be a palindrome of one (it should mirror the 'a' before the 'x'). For the 'b' we can conclude that the palindrome must be three (it should mirror the other 'b'). Rather, it must be at least three because we do not know what lies beyond the 'a' following the 'b'. Thus, we can skip the first 'a' and instead expand around 'b'.

Overall, we must consider four cases to choose the next center. The first case is that the palindrome is entirely contained within a larger palindrome. We can assign the palindrome at this center to the value belonging to its mirror and proceed with the next character. The second case is that we are at the end of the input string. The third case is that the mirror value extends beyond the containing palindrome. We can assign the palindrome around this center to be up until the end of the containing palindrome (you can check yourself that if this was not true, namely, that the palindrome could extend beyond the containing palindrome, then the containing palindrome was calculated incorrectly). The only case where we choose a center is when the mirror value does not extend beyond the containing palindrome and applying it to our current center takes us to the edge of the containing palindrome.

As for even-length palindromes, we can manipulate the input string by adding special characters (e.g., '#') between each letter to make the string odd-length. Now, even-length palindromes will in fact be odd-length palindromes about a special character.

Note: I tried my best to explain the algorithm using words but I encourage you to watch the linked video and work through examples by hand before trying to code the algorithm if you are having trouble understanding.

## Approach

Add a special character '@' at the start (to avoid overflow) and after each character ('#').

Next, loop through the modified input string, calculating the palindrome at each center. Expand outwards in both directions and keep track of the palindrome length in a corresponding array.

If the palindrome is greater than one, use the cases to decide which center to pick next. By default, we pick the next character. For this specific design, overflow is automatically checked by the external loop so we can ignore it. If the proceeding character(s) have a palindrome entirely contained but not at the right edge, we can skip. If the corresponding mirror extends beyond the containing palindrome, we can assign the center the value such that it extends up to, but not past, the containing palindrome. Otherwise, the character is our next center.

Return the substring using the maximum palindrome value. Remember to strip the special characters before returning the value.

## Complexity

### Time Complexity

The time complexity of Manacher's Algorithm is $O(n)$.

### Space Complexity

The space complexity is $O(n)$ because we need to keep track of an array with lengths of palindromes at each center.

## Code

```cpp
class Solution {
public:
    string longestPalindrome(string s) {
      std::string temp = "@";
      for (int i = 0; i < s.size(); i++) {
        temp += s[i];
        temp += '#';
      }
      s = temp;
      const unsigned short n = s.size();
      std::vector<int> p(n);
      unsigned short i = 1, maxCenter = 0;
      while (i < n - 1) {
        unsigned short expand = 1;
        while (s[i - expand] == s[i + expand]) expand++;
        p.at(i) = (expand - 1) * 2 + 1;
        if (p.at(i) > p.at(maxCenter)) maxCenter = i;
        unsigned short mirror = expand - 1, nextCenter = i + 1;
        for (int j = 1; j <= mirror; j++) {
          const unsigned short opposite = (p.at(i - j) - 1) / 2 + j;
          if (opposite < mirror) p.at(i + j) = p.at(i - j);
          else if (opposite > mirror) p.at(i + j) = (mirror - j) * 2 + 1;
          else {
            nextCenter = i + j;
            break;
          }
        }
        i = nextCenter;
      }
      s = s.substr(maxCenter - ((p.at(maxCenter) - 1) / 2), p.at(maxCenter));
      std::erase(s, '#');
      return s;
    }
};
```
