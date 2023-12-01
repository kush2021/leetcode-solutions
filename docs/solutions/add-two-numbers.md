---
tags:
  - math
  - medium
  - linkedlist
---

# Add Two Numbers

## Intuition

The intuition for solving a problem like this comes from knowledge of elementary math algorithms. The addition algorithm for two integers was likely taught early on in school. To solve this problem, we need to replicate that algorithm in our program. It may seem problematic at first glance that the lists are in reverse order. However, elementary addition is done in reverse order. Indeed, the reverse order of the input parameters is to our benefit as addition is done from the smallest place-value digit to the largest.

## Approach

Initialize a new linked list for our solution. We will also need a value to represent any carry numbers (when adding single digits goes above 10). We will loop until all values have been traversed from `l1` and `l2`, and when the carry is zero. First, calculate the sum of the single digits. Note that `l1` or `l2` may be null. The carry also needs to be included in this computation. Next, reset the carry to zero. If the sum is greater than or equal to 10, we need to replace the sum with `sum % 10` and set the carry to one. This sum value will be the next digit for our solution. Finally, increment the pointers.

## Complexity

### Time Complexity

The time complexity is $O(\max\{n, m\})$ where $n$ and $m$ are the lengths of `l1` and `l2`, respectively. This is because we must loop for every value in both `l1` and `l2`. We take the maximum instead of the sum because the sum would imply that we need to loop once per each element in both lists. However, the first $\min\{n, m\}$ elements are done in a single loop.

### Space Complexity

The space complexity is $O(1)$ because we are not requiring any variable-amount of memory. Since we are returning the solution list, it does not go against our memory complexity.

## Code

```cpp
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        ListNode* head = new ListNode();
        ListNode* current = head;
        unsigned char carry = 0;
        while (l1 != nullptr || l2 != nullptr || carry) {
            unsigned char sum = ((l1 != nullptr) ? l1 -> val : 0) + ((l2 != nullptr) ? l2 -> val : 0) + carry;
            carry = 0;
            if (sum >= 10) {
                sum %= 10;
                carry = 1;
            }
            current -> next = new ListNode(sum);
            current = current -> next;
            l1 = (l1 != nullptr) ? l1 -> next : nullptr;
            l2 = (l2 != nullptr) ? l2 -> next : nullptr;
        }
        return head -> next;
    }
};
```
