---
tags:
  - Linked List
  - Two Pointers
---

# Remove Nth Node From End of List

## Intuition

To solve this problem, the first approach we may consider is to do a first traversal of the linked list to find its length, and then a second traversal to remove the node.

However, we can solve this problem in one pass. Consider using two pointers, `fast` and `slow`. Initialize fast to be the nth node in the linked list. Initialize slow to be at the head. Now, we can traverse both nodes until `fast` reaches the end. At this point, `slow` will be the node to remove (we will also keep track of a `previous` for removal).

## Approach

First, use a loop to initialize `fast` to the nth node.

Next, set `slow` to be `head`. Traverse both nodes, along with a `previous` node to keep track of the node before `slow`, until the `fast` pointer is at the end.

Finally, remove the `slow` node and return `head`.

## Complexity

### Time Complexity

The time complexity is $O(n)$ where $n$ is the size of the linked list.

### Space Complexity

The space complexity is $O(1)$ because we only need to keep track of two pointers for any given input.

## Code

```cpp
class Solution {
public:
  ListNode* removeNthFromEnd(ListNode* head, int n) {
    return initSlowAndRemove(initFast(head, n), head);
  }

private:
  ListNode* initFast(ListNode* head, const int n) {
    ListNode* fast = head;
    for (unsigned short i = 0; i < (n - 1); i++) {
      fast = fast -> next;
    }
    return fast;
  }

  ListNode* initSlowAndRemove(ListNode* fast, ListNode* head) {
    ListNode* slow = head;
    ListNode* prev = nullptr;
    while ((fast -> next) != nullptr) {
      prev = slow;
      fast = fast -> next;
      slow = slow -> next;
    }
    return removeNode(slow, prev, head);
  }

  ListNode* removeNode(ListNode* remove, ListNode* prev, ListNode* head) {
    if (prev) {
      prev -> next = remove -> next;
      return head;
    }
    return head -> next;
  }
};
```
