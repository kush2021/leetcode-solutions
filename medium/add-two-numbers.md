# C++ Optimal Solution - Add Two Numbers

## Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
This problem may appear, at first glance, to have increased complexity due to the reverse order of the linked list. However, thinking of the elementary addition algorithm, it is done in reverse order, meaning this is in fact beneficial for us.

We start at the reverse end of the numbers (i.e., beginning of the list) and add, maintaining a carry value. We continue adding until all numbers have been traversed and there is no more carry.

## Approach
<!-- Describe your approach to solving the problem. -->
Initialize a new linked list and a carry. Loop while the lists have not been traversed or the carry is non-zero. Every iteration, add the numbers from the list (if any) and the carry. Reset the carry. If the sum is larger than 10, we will divide the value by 10 and keep the remainder, setting the carry to one. This will now be our value for the next element in the final sum. Advance the pointers and continue the process.

## Complexity

### Time Complexity:
<!-- Add your time complexity here, e.g. $$O(n)$$ -->
The time complexity is $O(\max\{m, n\})$ because our loop will continue until the longest list has been traversed. Any additional iterations due to the carry are constant time and are therefore insignificant.

### Space Complexity:
<!-- Add your space complexity here, e.g. $$O(n)$$ -->
The space complexity is $O(1)$ because we are only allocating a constant number of variables. Since the linked list is being returned, it does not count against the space complexity of the problem.

## Code

```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        int carry = 0;
        ListNode* head = new ListNode();
        ListNode* current = head;
        while (l1 != nullptr || l2 != nullptr || carry) {
            int sum = (l1 != nullptr ? l1 -> val : 0) + (l2 != nullptr ? l2 -> val : 0) + carry;
            carry = 0;
            if (sum >= 10) {
                sum %= 10;
                carry = 1;
            }
            current -> next = new ListNode(sum);
            current = current -> next;
            l1 = (l1 != nullptr ? l1 -> next : nullptr);
            l2 = (l2 != nullptr ? l2 -> next : nullptr);
        }
        return head -> next;
    }
};
```
