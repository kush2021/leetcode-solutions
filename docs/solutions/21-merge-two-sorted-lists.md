---
tags:
  - Easy
  - Linked List
  - Recursion
---

# Merge Two Sorted Lists

## Intuition

The intuition for this problem is fairly straightforward. We will iteratively compare each list node value and append the smaller one to the list we are creating.

## Approach

Ensure that both lists are non-empty. If one list is non-empty, return the other list.

Set a `head` variable to the smaller of the two nodes. Set another `tail` to the head. Loop until one list becomes non-empty. Add the lower node to the end of `tail` and increment pointer for that list.

Check if any list has nodes remaining. If so, add those nodes to `tail`. Return `head`.

## Complexity

### Time Complexity

The time complexity is $O(\min\{n, m\})$ where $n$ and $m$ are the lengths of `list1` and `list2`, respectively. This is because we only need to loop until one list is empty.

### Space Complexity

The space complexity is $O(1)$ because we are creating the new list in place.

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
  ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
    if (list1 == nullptr) {
      return list2;
    } else if (list2 == nullptr) {
      return list1;
    }
    ListNode* head = assignHead(list1, list2);
    ListNode* tail = head;
    while (bothListsHaveNodes(list1, list2)) {
      if (isFirstValSmaller(list1, list2)) {
        addNode(list1, tail);
      } else {
        addNode(list2, tail);
      }
    }
    addRemainingNodes(tail, list1, list2);
    return head;
  }

private:
  ListNode* assignHead(ListNode*& l1, ListNode*& l2) {
    ListNode* head;
    if (isFirstValSmaller(l1, l2)) {
      head = l1;
      l1 = l1 -> next;
    } else {
      head = l2;
      l2 = l2 -> next;
    }
    return head;
  }

  inline bool isFirstValSmaller(const ListNode* l1, const ListNode* l2) {
    return ((l1 -> val) < (l2 -> val));
  }

  inline bool bothListsHaveNodes(const ListNode* l1, const ListNode* l2) {
    return !(l1 == nullptr || l2 == nullptr);
  }

  void addNode(ListNode*& add, ListNode*& tail) {
    tail -> next = add;
    tail = tail -> next;
    add = add -> next;
  }

  void addRemainingNodes(ListNode*& tail, ListNode* l1, ListNode* l2) {
    if (l1 != nullptr) {
      tail -> next = l1;
    } else if (l2 != nullptr) {
      tail -> next = l2;
    }
  }
};
```
