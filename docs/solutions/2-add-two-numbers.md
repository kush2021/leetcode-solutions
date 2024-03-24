---
tags:
  - Math
  - Medium
  - Linked List
---

# Add Two Numbers

## Description

You are given two **non-empty** linked lists representing two non-negative integers. The digits are stored in **reverse order**, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

### Example 1

Input: `l1 = [2,4,3], l2=[5,6,4]`  
Output: `[7,0,8]`
Explanation: `342 + 465 = 807`

### Example 2

Input: `l1 = [0], l2 = [0]`
Output: `[0]`

### Example 3

Input: `l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]`
Output: `[8,9,9,9,0,0,0,1]`

### Constraints

- The number of nodes in each linked list is in the range `[1,100]`.
- `0 <= Node.val <= 9`
- It is guaranteed that the list represents a number that does not have leading zeroes.

## Intuition

To solve this problem, we need to figure out an algorithm to sum two numbers in reverse order. Looking back to elementary math education, the general addition algorithm performs the sum of two numbers in reverse order.

Starting with the least-significant digits, we take the sum. If the sum is less than 10, we can add this sum to the least-significant digit of our answer. If the sum is greater than 10, we decrement the sum by 10 and add a carry value to the next least-significant digit. We can continue this process until the numbers are traversed and there is no more carry value.

## Approach

1. Initialize a `dummy` node to keep track of our solution. Initialize `current` to `dummy`. Initialize `carry` to 0.

2. Loop until both nodes are fully traversed and `carry` is zero.

    a. Compute the digit sum. This will be the sum of the values of `l1` and `l2` and `carry`. Keep in mind that `l1` and `l2` may be null. If so, use 0 for their values.

    b. Check for a carry. If the digit sum is 10 or greater, decrement the digit sum by 10 and set `carry` to 1, otherwise set `carry` to 0.

    c. Set `current.next` to a new node with the value of our digit sum.

    d. Advance the `current`, `l1`, and `l2` lists. Again, keep in mind that `l1` and `l2` may already be traversed, in which case we do nothing.
    
3. Return `dummy.next`.

## Complexity

### Time Complexity

The worst-case time complexity of this algorithm is $O(\max{m,n})$ where $m$ and $n$ are the lengths of `l1` and `l2`, respectively. This is because no matter what the inputs are, we always need to traverse the maximum length of `l1` and `l2`. We also may also need extra iterations to traverse `carry` but this will always be linear with respect to the lengths of the input lists.

### Space Complexity

The worst-case space complexity of this algorithm is $O(1)$ because we are not using additional space _outside of the return value_.

## Code

```python
class Solution:
  def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
    dummy = ListNode()
    current = dummy
    carry = 0
    while self.numsLeft(l1, l2, carry):
      digitSum = (l1.val if l1 else 0) + (l2.val if l2 else 0) + carry
      carry, digitSum = self.checkCarry(carry, digitSum)
      current.next = ListNode(digitSum)
      current, l1, l2 = self.advanceLists(current, l1, l2)
    return dummy.next

  def numsLeft(self, l1: Optional[ListNode], l2: Optional[ListNode], carry: int) -> bool:
    return l1 or l2 or carry

  def checkCarry(self, carry: int, digitSum: int) -> Tuple[int, int]:
    if digitSum >= 10:
      return 1, digitSum - 10
    return 0, digitSum

  def advanceLists(self, current: ListNode, l1: Optional[ListNode], l2: Optional[ListNode]) -> Tuple[Optional[ListNode], Optional[ListNode], Optional[ListNode]]:
    return current.next, (l1.next if l1 else None), (l2.next if l2 else None)
```
