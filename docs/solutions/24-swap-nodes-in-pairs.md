---
tags:
  - Linked List
  - Medium
  - Recursion
---

# Swap Nodes in Pairs

## Intuition

To solve this problem, we can simply traverse the list in pairs, swapping the nodes at each iteration. We must also remember to change a previous node's next once the current pair swaps. Consider the linked list $1 \rightarrow 2 \rightarrow 3 \rightarrow 4$. We cans swap the first nodes resulting in $2 \rightarrow 1 \rightarrow 3 \rightarrow 4$. Next, we can swap the last two nodes, resulting in $2 \rightarrow 1 \rightarrow 4 \rightarrow 3$. At this iteration, we also need to change the previous node's (represented by the $1$) next to point to $4$ instead of $3$. This applies to all iterations besides the first.

## Approach

Define pointers for `left`, `right`, and `prev`. `left` and `right` will point to `head` and `prev` will point to null.

If `head` is not null and there are at least two nodes, we can set the head to be `left -> next` since after the swap, the first node will be the current second node.

While `left` is not null, we can iterate through the list. Assign `right` to be `left -> next`, provided that node exists. Swap the two nodes. If `prev` exists, set that node's next to be `right`. Assign `prev` to be `left` and increment `left`.

Return `head`.

## Complexity

### Time Complexity

The time complexity is $O(n)$ where $n$ is the number of nodes in the input list. This is because we need to traverse the entire list once to swap all pairs of nodes.

### Space Complexity

The space complexity is $O(1)$ because our memory requirements are not dependent on the size of the input list.

## Code

```cpp
class Solution {
public:
  ListNode* swapPairs(ListNode* head) {
    ListNode* left = head;
    ListNode* right = left;
    ListNode* prev = nullptr;
    if (head && left -> next) head = left -> next;
    while (left) {
      if (!(left -> next)) break;
      right = left -> next;
      swap(left, right);
      if (prev) prev -> next = right;
      prev = left;
      left = left -> next;
    }
    return head;
  }

private:
  void swap(ListNode*& a, ListNode*& b) {
    a -> next = b -> next;
    b -> next = a;
  }
};
```
