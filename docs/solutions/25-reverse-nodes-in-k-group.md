---
tags:
  - Hard
  - Linked List
  - Recursion
---

# Reverse Nodes in K-Group

## Intuition

This problem can be solved by reasoning about how to reverse $k$ nodes at a time. Reversing all of the nodes is a fairly straightforward task. We can simply switch the direction of each pointer in the list and change the head.

Extending this for our problem, we can perform this reversal $k$ nodes at a time and we also need to keep track of the previous group's tail and the next group's head (so we can reference these to assign the correct pointers).

## Approach

First, create a dummy head node that points to `head`. Set the previous group's tail to `dummy`.

We will iterate the rest of the list until there are no more $k$ node groups left. Get the $k$th node. If it is `null`, we can exit. Set the next group's head to `kth.next` and `prev` to `kth.next`. Set `current` to `groupTail.next`.

While `current != groupHead`, we can reverse the $k$ nodes. Use a temporary variable to hold `current.next`. Set the `current.next` to `prev` and `prev` to `current`. Finally, set `current` to `next`.

Now, we can assign `groupTail.next` to `kth` and advance `groupTail`.

Return `dummy.next`.

## Complexity

### Time Complexity

The time complexity is $O(n)$ because we must iterate through the entire list to perform the algorithm.

### Space Complexity

The space complexity is $O(1)$ because we are not using any space relative to the input size.

## Code

```cpp
class Solution {
public:
  ListNode* reverseKGroup(ListNode* head, int k) {
    ListNode* dummy = new ListNode(0, head);
    ListNode* groupTail = dummy;
    while (true) {
      ListNode* kth = getKth(groupTail, k);
      if (!kth) break;
      ListNode* groupHead = kth -> next;
      ListNode* prev = kth -> next;
      ListNode* current = groupTail -> next;
      while (current != groupHead) {
        ListNode* next = current -> next;
        current -> next = prev;
        prev = current;
        current = next;
      }
      ListNode* next = groupTail -> next;
      groupTail -> next = kth;
      groupTail = next;
    }
    return dummy -> next;
  }

private:
  ListNode* getKth(ListNode* current, const int k) {
    for (unsigned short i = 0; i < k; i++) {
      if (!current) return nullptr;
      current = current -> next;
    }
    return current;
  }
};
```
