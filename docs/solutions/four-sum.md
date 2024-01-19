---
tags:
  - Array
  - Medium
  - Sorting
  - Two Pointers
---

# Four Sum

## Intuition

To solve this problem, we have to repeat the three sum problem while fixing an extra integer. This means we can have doubly-nested loops and then perform a two-pointer approach to find the quadruplets.

## Approach

Create a nested array to store the sums. If the input array has a size of less than four, we can return an empty list (since there are not enough numbers to form a quadruplet without repeating values). Sort the input array.

Create a loop to traverse through `nums`. The loop will end once the index gets to `nums.size() - 3` because we need to leave at least three numbers worth of space for our next three values. Similarly, create another loop to traverse starting at one more than our previous loop index up to `nums.size() - 2`.

Within the nested loop, we can find the complement value by subtracting our two current numbers we are iterating on from the target. This is the value the remaining three numbers must add to. Now, we can perform a two pointer approach to find any possible sums. Start with the left pointer being one greater than our inner loop index and the right pointer being the last number. If the sum is greater than our complement, we can decrement the right pointer, If the sum is less than our complement, we can increment our left pointer. If the sum equals our complement, we can increment the left pointer (or decrement the right pointer) and check if the last value in our sums array (the nested array of quadruplets) is equal to the new quadruplet that adds up to target. If not, we can add this quadruplet to our sums. This works because we are guaranteed that our sums is accumulating in sorted order so to check for duplicates, we only need to check the very last array.

After the two-pointer approach is finished, we can increment our loop indices until the next value is different (make sure to not go out-of-range). Return the sums.

## Complexity

### Time Complexity

The time complexity is $O(n) * O(n) * O(n)$ for the two loops and the two-pointer method. Sorting is $O(n\log(n))$. The total time complexity is then $O(n^3) + O(n\log(n))$ which is $O(n^3)$.

### Space Complexity

The space complexity is $O(1)$ since we are not using any additional space respective to the input size. We do not count the sums array because that is our return value.

## Code

```cpp
class Solution {
public:
  std::vector<std::vector<int>> fourSum(std::vector<int>& nums, int target) {
    std::vector<std::vector<int>> sums;
    const unsigned short n = nums.size();
    if (n < 3) {
      return sums;
    }
    std::sort(nums.begin(), nums.end());
    for (unsigned short i = 0; i < (n - 3); i++) {
      for (unsigned short j = i + 1; j < (n - 2); j++) {
        twoSum(sums, nums, target, i, j);
        while ((j < (n - 2)) && (nums.at(j) == nums.at(j + 1))) {
          j++;
        }
      }
      while ((i < (n - 1)) && (nums.at(i) == nums.at(i + 1))) {
        i++;
      }
    }
    return sums;
  }

private:
  void twoSum(
    std::vector<std::vector<int>>& sums,
    const std::vector<int> nums,
    const int target,
    const unsigned short i,
    const unsigned short j
  ) {
    long long complement = target - nums.at(i);
    complement -= nums.at(j);
    unsigned short left = j + 1, right = nums.size() - 1;
    while (left < right) {
      const long long sum = nums.at(left) + nums.at(right);
      if (sum > complement) {
        right--;
      } else if (sum < complement) {
        left++;
      } else {
        const std::vector<int> potentialSum {nums.at(i), nums.at(j), nums.at(left), nums.at(right)};
        if (sums.empty() || sums.at(sums.size() - 1) != potentialSum) {
          sums.push_back(std::vector<int> {nums.at(i), nums.at(j), nums.at(left), nums.at(right)});
        }
        left++;
      }
    }
  }
};
```
