---
tags:
  - Easy
  - String
  - String Matching
  - Two Pointers
---

# Find the Index of the First Occurrence in a String

## Intuition

We can solve this problem trivially using a nested for-loop to compare the characters of the needle with the characters in the haystack. However, to solve this problem optimally, we need to apply the Knuth-Morris-Pratt (KMP) algorithm.

The KMP algorithm is used for pattern matching in strings. It takes advantage of a _prefix table_ to help avoid unnecessary comparisons. The prefix table is formed by setting the size of the table to the size of the pattern and the value at index `i` to the length of the longest proper prefix and suffix up to that character.

Let us consider an example. Consider the string `ABABCAB`. The prefix table will be an array of length seven. For any given pattern, we can set the first value to zero. This is because for the substring of length one, there are no proper prefixes that are also suffixes. For the second character, `B`, again, there are no proper prefixes that are also suffixes, so the value is zero. For the third character, `A`, the longest proper prefix and suffix is `A`, which has a length of one. Continuing this pattern, the array should look like `[0, 0, 1, 2, 0, 1, 2]`.

Once our prefix table is made, we can start iterating through the text. At any point, if a mismatch occurs, we can shift the pattern efficiently using the prefix table. We shift the pattern to the right based on the value of the prefix table prior to the current mismatched character of the pattern.

## Approach

Assign two pointers, `i` and `j`, to represent the indices of the haystack and needle, respectively.

Next, we compute the prefix table. Create an array with the size of the needle and initialize all values to zero. Set an integer to represent the length of the longest prefix and suffix to zero and an index to one.

Until the index reaches the end of the needle size, we will repeat our algorithm: if the current index (a new index `i`) and the index at `len` have the same character, set the prefix table at `i` to `len + 1` and increment both `len` and `i`. Otherwise, if `len` is not zero, set the value to the previous value in the prefix table, but do not increment either variable. Finally, assign the value zero and increment `i`. Return the table.

Until we cannot keep searching for a match, we will repeat our main algorithm. If the haystack and needle characters are equal, increment both pointers. If the needle has been exhausted, return the starting index.

If there is a mismatch and the needle is not at the beginning, set the needle to the value of the prefix table at `j - 1`. Otherwise, increment `i`.

If no match is found, return `-1`.

## Complexity

### Time Complexity

The time complexity is $O(n + m)$ where $n$ and $m$ are the lengths of the needle and haystack, respectively. This is because we must iterate through the entire haystack and the needle.

### Space Complexity

The space complexity is $O(n)$ where $n$ is the length of the needle. We need this additional space to store our prefix table.

## Code

```cpp
class Solution {
public:
  int strStr(std::string haystack, std::string needle) {
    unsigned short i = 0, j = 0;
    std::vector<unsigned short> lps = computeLPS(needle);
    while ((haystack.size() - i) >= (needle.size() - j)) {
      if (needle.at(j) == haystack.at(i)) {
        i++;
        j++;
      }
      if (j == needle.size()) return (i - j);
      else if (i < haystack.size() && needle.at(j) != haystack.at(i)) {
        if (j != 0) j = lps[j - 1];
        else i++;
      }
    }
    return -1;
  }

private:
  std::vector<unsigned short> computeLPS(std::string needle) {
    std::vector<unsigned short> lps(needle.size(), 0);
    unsigned short len = 0, i = 1;
    while (i < needle.size()) {
      if (needle.at(i) == needle.at(len)) lps[i++] = ++len;
      else {
        if (len != 0) len = lps[len - 1];
        else lps[i++] = 0;
      }
    }
    return lps;
  }
};
```