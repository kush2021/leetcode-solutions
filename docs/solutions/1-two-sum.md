---
tags:
  - Array
  - Easy
  - Hash Table
---

# Two Sum

## Description

Given an array of integers `nums` and an integer `target`, return _indices of the two numbers such that they add up to `target`_.

You may assume that each input would have **_exactly one solution_** , and you may not use the _same_ element twice.

You can return the answer in any order.

### Example 1

Input: `nums = [2,7,11,15], target = 9`  
Output: `[0,1]`  
Explanation: Because `nums[0] + nums[1] == 9` we return `[0, 1]`.

### Example 2

Input: `nums = [3,2,4], target = 6`  
Output: `[1,2]`

### Example 3

Input: `nums = [3,3], target = 6`  
Output: `[0,1]`

### Constraints

- `2 <= nums.length <= 10^4`
- `-10^9 <= nums[i] <= 10^9`
- `-10^9 <= target <= 10^9`
- **Only one valid answer exists.**

## Intuition

The first approach we may consider to solving this problem is a brute-force approach which utilizes a nested loop to consider all possible pairs of elements in `nums`. By considering every single pair of numbers, we can iterate until we find the pair that adds up to `target`, at which point we may return the indices of the numbers.

Although no additional memory is required, we have to iterate through `nums` twice in the worst-case, giving us a time complexity of $O(n^2)$. Is there a way we can solve this problem with only one iteration of `nums`?

To answer this question, we must first realize that in order to solve the problem in a single pass, we need a way to store the previous numbers that we have found. Since we are guaranteed that each input has a _single_ output, we do not need to worry about duplicate elements. Furthermore, given a single number, `num`, we know which other number we are looking for, `target - num`. These two facts will help us solve this problem efficiently.

Let us first consider using a set to store our numbers. We can iterate through `nums` and during each iteration, check if `target - num` has been found (since `target - num` is the other number we need to find). If not, we can add `num` to our set. If so, we have found our answer. The problem is that we are asked to return the _indices_ of the numbers, which we do not know.

Instead of using a set, we can use a hash map that maps the numbers to their indices. We can follow the same algorithm as before, but now when we have successfully found a pair of numbers, we can return the indices using the map.

## Approach

1. Initialize a hash map, `foundNums` to store the numbers and their indices as key-value pairs, respectively.

2. Iterate through `nums`.

    a. Save `target - nums[i]` as `complement`.

    b. If `complement` is in `foundNums`, we can return `[foundNums[complement], i]`.

    c. Otherwise, we can update our hash map using `foundNums[num] = i`.

## Complexity

### Time Complexity

The worst-case time complexity is $O(n)$ because in the worst-case, we need to iterate through the entirety of `nums`. This happens when one of our numbers that add up to `target` is at the end of the array.

### Space Complexity

The worst-case space complexity is $O(n)$ because in the worst-case, we need to store $n$ numbers and their indices in our hash map. This also happens when one of our numbers that add up to `target` is at the end of the array.

## Code

```python
class Solution:
  def twoSum(self, nums: List[int], target: int) -> List[int]:
    foundNums = dict()
    for i, num in enumerate(nums):
      complement = target - num
      if complement in foundNums:
        return [foundNums[complement], i]
      foundNums[num] = i
```
